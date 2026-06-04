import 'package:giftory/features/gift_history/data/datasources/gift_history_datasource.dart';
import 'package:giftory/features/gift_history/data/models/gift_history_model.dart';
import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';
import 'package:giftory/features/gift_history/domain/repositories/gift_history_repository.dart';

class GiftHistoryRepositoryImpl implements GiftHistoryRepository {
  final GiftHistoryDatasource _datasource;
  const GiftHistoryRepositoryImpl(this._datasource);

  @override
  Future<List<GiftHistory>> getAll() async {
    final models = await _datasource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> add(GiftHistory history) async =>
      _datasource.add(history.toModel());

  @override
  Future<void> delete(String id) async => _datasource.delete(id);
}
