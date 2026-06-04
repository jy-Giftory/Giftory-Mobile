import 'package:giftory/features/auth/data/models/user_model.dart';

class AuthDatasource {
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserModel(id: '1', email: email);
  }

  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserModel(id: '1', email: email);
  }
}