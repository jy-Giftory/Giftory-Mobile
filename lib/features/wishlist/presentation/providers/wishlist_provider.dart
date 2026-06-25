import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/core/network/dio_client.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';

part 'wishlist_provider.g.dart';

@riverpod
class WishlistNotifier extends _$WishlistNotifier {
  Dio get _dio => ref.read(dioProvider);

  @override
  Future<List<GiftRecommendation>> build() async {
    final res = await _dio.get('/wishlists');
    final list = res.data['wishlists'] as List;
    return list.map(_fromJson).toList();
  }

  Future<void> add(GiftRecommendation item) async {
    await _dio.post('/wishlists', data: {
      'giftName': item.title,
      'price': item.price,
      'reason': item.reason,
      'tip': item.deliveryTip,
      'purchaseUrl': item.naverShoppingUrl,
    });
    ref.invalidateSelf();
    await future;
  }

  Future<void> removeByServerId(String id) async {
    await _dio.delete('/wishlists/$id');
    ref.invalidateSelf();
    await future;
  }

  Future<void> toggleByContent(GiftRecommendation item) async {
    final current = state.valueOrNull ?? [];
    final matched = current
        .where((w) => w.title == item.title && w.price == item.price)
        .toList();
    if (matched.isNotEmpty) {
      await removeByServerId(matched.first.id);
    } else {
      await add(item);
    }
  }

  bool containsContent(GiftRecommendation item) {
    final current = state.valueOrNull ?? [];
    return current.any((w) => w.title == item.title && w.price == item.price);
  }

  GiftRecommendation _fromJson(dynamic json) => GiftRecommendation(
        id: json['id'].toString(),
        title: json['giftName'] as String,
        price: json['price'] as int,
        reason: json['reason'] as String,
        deliveryTip: json['tip'] as String,
        searchQuery: json['giftName'] as String,
        isInWishlist: true,
      );
}
