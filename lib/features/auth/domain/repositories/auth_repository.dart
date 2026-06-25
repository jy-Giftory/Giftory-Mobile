import 'package:giftory/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> sendVerification(String email);
  Future<User> signup({
    required String email,
    required String verificationCode,
    required String password,
    required String passwordConfirm,
  });
  Future<User> login({required String email, required String password});
  Future<void> logout();
  Future<void> deleteAccount();
}
