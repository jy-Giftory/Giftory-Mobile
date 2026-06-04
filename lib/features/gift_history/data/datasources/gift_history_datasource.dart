import 'package:giftory/features/gift_history/data/models/gift_history_model.dart';

class GiftHistoryDatasource {
  final List<GiftHistoryModel> _store = [];

  Future<List<GiftHistoryModel>> getAll() async => List.from(_store);

  Future<void> add(GiftHistoryModel model) async => _store.add(model);

  Future<void> delete(String id) async =>
      _store.removeWhere((m) => m.id == id);
}
