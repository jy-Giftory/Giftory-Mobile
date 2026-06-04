import 'package:giftory/features/home/data/models/anniversary_model.dart';

class AnniversaryDatasource {
  final List<AnniversaryModel> _store = [
    const AnniversaryModel(
      id: '1',
      title: '엄마 생일',
      originalDate: '1990-05-12T00:00:00.000',
      repeatType: 'yearly',
    ),
    const AnniversaryModel(
      id: '2',
      title: '데이트 하는 날',
      originalDate: '2024-03-12T00:00:00.000',
      repeatType: 'monthly',
    ),
  ];

  Future<List<AnniversaryModel>> getAll() async => List.from(_store);

  Future<void> add(AnniversaryModel model) async {
    _store.add(model);
  }

  Future<void> delete(String id) async {
    _store.removeWhere((m) => m.id == id);
  }

  Future<void> update(AnniversaryModel model) async {
    final index = _store.indexWhere((m) => m.id == model.id);
    if (index != -1) _store[index] = model;
  }
}
