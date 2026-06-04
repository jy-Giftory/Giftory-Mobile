import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:giftory/features/home/data/models/anniversary_model.dart';

class AnniversaryDatasource {
  static const _boxKey = 'anniversaries';
  static const _dataKey = 'data';

  Box get _box => Hive.box(_boxKey);

  Future<List<AnniversaryModel>> getAll() async {
    final raw = _box.get(_dataKey, defaultValue: '[]') as String;
    final list = jsonDecode(raw) as List;
    return list.map((e) => AnniversaryModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> add(AnniversaryModel model) async {
    final list = await getAll();
    list.add(model);
    await _persist(list);
  }

  Future<void> delete(String id) async {
    final list = await getAll();
    list.removeWhere((m) => m.id == id);
    await _persist(list);
  }

  Future<void> update(AnniversaryModel model) async {
    final list = await getAll();
    final index = list.indexWhere((m) => m.id == model.id);
    if (index != -1) list[index] = model;
    await _persist(list);
  }

  Future<void> _persist(List<AnniversaryModel> list) async {
    await _box.put(
      _dataKey,
      jsonEncode(list.map((m) => m.toJson()).toList()),
    );
  }
}
