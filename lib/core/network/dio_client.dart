import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/core/config/api_config.dart';
import 'package:giftory/core/network/token_storage.dart';

part 'dio_client.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.serverBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
      // Django는 2xx 외 상태를 직접 다루기 위해 검증을 느슨하게 둔다.
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  dio.interceptors.add(_AuthInterceptor(dio));
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    requestHeader: false,
    responseHeader: false,
  ));

  return dio;
}

/// 모든 요청에 access token을 붙이고, 401 시 refresh로 한 번 재시도한다.
class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._dio);

  final Dio _dio;
  final _storage = TokenStorage.instance;

  static const _noAuthPaths = {
    '/auth/login',
    '/auth/signup',
    '/auth/send-verification',
    '/auth/refresh',
  };

  bool _refreshing = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storage.accessToken;
    if (token != null && !_noAuthPaths.contains(options.path)) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final isAuthError = response.statusCode == 401;
    final path = response.requestOptions.path;
    final refreshToken = _storage.refreshToken;

    if (isAuthError &&
        refreshToken != null &&
        !_noAuthPaths.contains(path) &&
        !_refreshing) {
      _refreshing = true;
      try {
        final refreshed = await _refreshAccessToken(refreshToken);
        if (refreshed != null) {
          await _storage.updateAccess(refreshed);
          // 원 요청 재시도
          final req = response.requestOptions;
          req.headers['Authorization'] = 'Bearer $refreshed';
          final retried = await _dio.fetch(req);
          _refreshing = false;
          return handler.resolve(retried);
        }
      } catch (_) {
        // refresh 실패 → 그대로 401 전달 (호출측에서 로그아웃 처리)
      }
      _refreshing = false;
    }
    handler.next(response);
  }

  Future<String?> _refreshAccessToken(String refreshToken) async {
    final res = await Dio(BaseOptions(baseUrl: ApiConfig.serverBaseUrl)).post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    if (res.statusCode == 200) {
      return res.data['access_token'] as String?;
    }
    return null;
  }
}
