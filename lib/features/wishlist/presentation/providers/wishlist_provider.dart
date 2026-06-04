import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';

part 'wishlist_provider.g.dart';

@riverpod
class WishlistNotifier extends _$WishlistNotifier {
  @override
  List<GiftRecommendation> build() => [];

  void toggle(GiftRecommendation item) {
    final exists = state.any((i) => i.id == item.id);
    state = exists
        ? state.where((i) => i.id != item.id).toList()
        : [...state, item];
  }

  void remove(String id) {
    state = state.where((i) => i.id != id).toList();
  }

  bool contains(String id) => state.any((i) => i.id == id);
}
