import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/features/auth/data/datasources/auth_datasource.dart';
import 'package:giftory/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:giftory/features/auth/domain/entities/user.dart';

part 'auth_provider.g.dart';

@riverpod
AuthDatasource authDatasource(Ref ref) => AuthDatasource();

@riverpod
AuthRepositoryImpl authRepository(Ref ref) =>
    AuthRepositoryImpl(ref.watch(authDatasourceProvider));

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  User? build() => null;

  Future<void> login({required String email, required String password}) async {
    final repo = ref.read(authRepositoryProvider);
    state = await repo.login(email: email, password: password);
  }

  Future<void> register({required String email, required String password}) async {
    final repo = ref.read(authRepositoryProvider);
    state = await repo.register(email: email, password: password);
  }

  void logout() {
    state = null;
  }
}