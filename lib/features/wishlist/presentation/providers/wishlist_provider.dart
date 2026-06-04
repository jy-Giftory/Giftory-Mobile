import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';

part 'wishlist_provider.g.dart';

@riverpod
class WishlistNotifier extends _$WishlistNotifier {
  static const _boxKey = 'wishlist';
  static const _dataKey = 'data';

  Box get _box => Hive.box(_boxKey);

  @override
  List<GiftRecommendation> build() {
    final raw = _box.get(_dataKey, defaultValue: '[]') as String;
    final list = jsonDecode(raw) as List;
    return list
        .map((e) => GiftRecommendation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  void toggle(GiftRecommendation item) {
    final exists = state.any((i) => i.id == item.id);
    state = exists
        ? state.where((i) => i.id != item.id).toList()
        : [...state, item];
    _persist();
  }

  void remove(String id) {
    state = state.where((i) => i.id != id).toList();
    _persist();
  }

  bool contains(String id) => state.any((i) => i.id == id);

  void _persist() {
    _box.put(
      _dataKey,
      jsonEncode(state.map((i) => i.toJson()).toList()),
    );
  }
}
