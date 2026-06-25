import 'package:hive_flutter/hive_flutter.dart';

/// JWT 토큰을 Hive에 보관한다. (시연용 — 운영에서는 flutter_secure_storage 권장)
class TokenStorage {
  TokenStorage._();
  static final TokenStorage instance = TokenStorage._();

  static const _boxKey = 'auth';
  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  Box get _box => Hive.box(_boxKey);

  String? get accessToken => _box.get(_accessKey) as String?;
  String? get refreshToken => _box.get(_refreshKey) as String?;
  bool get isLoggedIn => accessToken != null;

  Future<void> save({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _box.put(_accessKey, accessToken);
    if (refreshToken != null) {
      await _box.put(_refreshKey, refreshToken);
    }
  }

  Future<void> updateAccess(String accessToken) async {
    await _box.put(_accessKey, accessToken);
  }

  Future<void> clear() async {
    await _box.delete(_accessKey);
    await _box.delete(_refreshKey);
  }
}
