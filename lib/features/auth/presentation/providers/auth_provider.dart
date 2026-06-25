import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/core/network/dio_client.dart';
import 'package:giftory/core/network/token_storage.dart';
import 'package:giftory/features/auth/data/datasources/auth_datasource.dart';
import 'package:giftory/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:giftory/features/auth/domain/entities/user.dart';

part 'auth_provider.g.dart';

@riverpod
AuthDatasource authDatasource(Ref ref) =>
    AuthDatasource(ref.watch(dioProvider));

@riverpod
AuthRepositoryImpl authRepository(Ref ref) =>
    AuthRepositoryImpl(ref.watch(authDatasourceProvider));

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  User? build() => null;

  bool get isLoggedIn => TokenStorage.instance.isLoggedIn;

  Future<void> sendVerification(String email) async {
    await ref.read(authRepositoryProvider).sendVerification(email);
  }

  Future<void> signup({
    required String email,
    required String verificationCode,
    required String password,
    required String passwordConfirm,
  }) async {
    final repo = ref.read(authRepositoryProvider);
    state = await repo.signup(
      email: email,
      verificationCode: verificationCode,
      password: password,
      passwordConfirm: passwordConfirm,
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final repo = ref.read(authRepositoryProvider);
    state = await repo.login(email: email, password: password);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = null;
  }

  Future<void> deleteAccount() async {
    await ref.read(authRepositoryProvider).deleteAccount();
    state = null;
  }
}
