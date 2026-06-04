import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/features/gift_history/data/datasources/gift_history_datasource.dart';
import 'package:giftory/features/gift_history/data/repositories/gift_history_repository_impl.dart';
import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';
import 'package:giftory/features/gift_history/domain/usecases/add_gift_history_usecase.dart';
import 'package:giftory/features/gift_history/domain/usecases/delete_gift_history_usecase.dart';
import 'package:giftory/features/gift_history/domain/usecases/get_gift_histories_usecase.dart';

part 'gift_history_provider.g.dart';

@riverpod
GiftHistoryDatasource giftHistoryDatasource(Ref ref) =>
    GiftHistoryDatasource();

@riverpod
GiftHistoryRepositoryImpl giftHistoryRepository(Ref ref) =>
    GiftHistoryRepositoryImpl(ref.watch(giftHistoryDatasourceProvider));

@riverpod
class GiftHistoryNotifier extends _$GiftHistoryNotifier {
  @override
  Future<List<GiftHistory>> build() async {
    final repo = ref.watch(giftHistoryRepositoryProvider);
    return GetGiftHistoriesUsecase(repo).call();
  }

  Future<void> add(GiftHistory history) async {
    final repo = ref.read(giftHistoryRepositoryProvider);
    await AddGiftHistoryUsecase(repo).call(history);
    ref.invalidateSelf();
  }

  Future<void> delete(String id) async {
    final repo = ref.read(giftHistoryRepositoryProvider);
    await DeleteGiftHistoryUsecase(repo).call(id);
    ref.invalidateSelf();
  }
}
