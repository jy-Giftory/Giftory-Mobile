import 'package:giftory/features/auth/data/datasources/auth_datasource.dart';
import 'package:giftory/features/auth/data/models/user_model.dart';
import 'package:giftory/features/auth/domain/entities/user.dart';
import 'package:giftory/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;
  const AuthRepositoryImpl(this._datasource);

  @override
  Future<void> sendVerification(String email) =>
      _datasource.sendVerification(email);

  @override
  Future<User> signup({
    required String email,
    required String verificationCode,
    required String password,
    required String passwordConfirm,
  }) async {
    final model = await _datasource.signup(
      email: email,
      verificationCode: verificationCode,
      password: password,
      passwordConfirm: passwordConfirm,
    );
    return model.toEntity();
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final model = await _datasource.login(email: email, password: password);
    return model.toEntity();
  }

  @override
  Future<void> logout() => _datasource.logout();

  @override
  Future<void> deleteAccount() => _datasource.deleteAccount();
}
