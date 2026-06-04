import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:giftory/features/gift_history/data/models/gift_history_model.dart';

class GiftHistoryDatasource {
  static const _boxKey = 'gift_histories';
  static const _dataKey = 'data';

  Box get _box => Hive.box(_boxKey);

  Future<List<GiftHistoryModel>> getAll() async {
    final raw = _box.get(_dataKey, defaultValue: '[]') as String;
    final list = jsonDecode(raw) as List;
    return list.map((e) => GiftHistoryModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> add(GiftHistoryModel model) async {
    final list = await getAll();
    final index = list.indexWhere((m) => m.id == model.id);
    if (index != -1) {
      list[index] = model;
    } else {
      list.add(model);
    }
    await _persist(list);
  }

  Future<void> delete(String id) async {
    final list = await getAll();
    list.removeWhere((m) => m.id == id);
    await _persist(list);
  }

  Future<void> _persist(List<GiftHistoryModel> list) async {
    await _box.put(
      _dataKey,
      jsonEncode(list.map((m) => m.toJson()).toList()),
    );
  }
}
