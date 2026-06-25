import 'package:dio/dio.dart';
import 'package:giftory/core/network/token_storage.dart';
import 'package:giftory/features/auth/data/models/user_model.dart';

class AuthDatasource {
  final Dio _dio;
  const AuthDatasource(this._dio);

  Future<void> sendVerification(String email) async {
    final res = await _dio.post(
      '/auth/send-verification',
      data: {'email': email},
    );
    if (res.statusCode != 200) throw _error(res);
  }

  Future<UserModel> signup({
    required String email,
    required String verificationCode,
    required String password,
    required String passwordConfirm,
  }) async {
    final res = await _dio.post('/auth/signup', data: {
      'email': email,
      'verification_code': verificationCode,
      'password': password,
      'password_confirm': passwordConfirm,
    });
    if (res.statusCode != 201) throw _error(res);

    final data = res.data as Map<String, dynamic>;
    await TokenStorage.instance.save(
      accessToken: data['access_token'] as String,
      refreshToken: data['refresh_token'] as String?,
    );
    return UserModel(id: data['user_id'].toString(), email: email);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    if (res.statusCode != 200) throw _error(res);

    final data = res.data as Map<String, dynamic>;
    await TokenStorage.instance.save(
      accessToken: data['access_token'] as String,
      refreshToken: data['refresh_token'] as String?,
    );
    final user = data['user'] as Map<String, dynamic>;
    return UserModel(
      id: user['id'].toString(),
      email: user['email'] as String,
    );
  }

  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } finally {
      await TokenStorage.instance.clear();
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _dio.delete('/auth/delete');
    } finally {
      await TokenStorage.instance.clear();
    }
  }

  Exception _error(Response res) {
    final data = res.data;
    if (data is Map) {
      if (data['detail'] != null) return Exception(data['detail'].toString());
      final first = data.values.isNotEmpty ? data.values.first : null;
      if (first is List && first.isNotEmpty) {
        return Exception(first.first.toString());
      }
      return Exception(data.toString());
    }
    return Exception('요청에 실패했습니다 (${res.statusCode})');
  }
}
