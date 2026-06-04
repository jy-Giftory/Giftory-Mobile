import 'package:giftory/features/auth/data/datasources/auth_datasource.dart';
import 'package:giftory/features/auth/data/models/user_model.dart';
import 'package:giftory/features/auth/domain/entities/user.dart';
import 'package:giftory/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;
  const AuthRepositoryImpl(this._datasource);

  @override
  Future<User> login({required String email, required String password}) async {
    final model = await _datasource.login(email: email, password: password);
    return model.toEntity();
  }

  @override
  Future<User> register({required String email, required String password}) async {
    final model = await _datasource.register(email: email, password: password);
    return model.toEntity();
  }

  @override
  Future<void> logout() async {}
}
