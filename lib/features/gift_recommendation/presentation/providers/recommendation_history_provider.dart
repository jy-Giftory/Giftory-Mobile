import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/core/network/dio_client.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/recommendation_record.dart';

part 'recommendation_history_provider.g.dart';

@riverpod
class RecommendationHistoryNotifier extends _$RecommendationHistoryNotifier {
  Dio get _dio => ref.read(dioProvider);

  @override
  Future<List<RecommendationRecord>> build() async {
    final res =
        await _dio.get('/recommendations', queryParameters: {'limit': 100});
    final list = res.data['recommendations'] as List;
    return list.map(_fromServer).toList();
  }

  Future<void> save({
    required String recipient,
    required int budgetMin,
    required int budgetMax,
    required List<GiftRecommendation> items,
    required String congratsMessage,
    String? detailedInterests,
    String? memo,
  }) async {
    await _dio.post('/recommendations', data: {
      'recipient': recipient,
      'budgetMin': budgetMin,
      'budgetMax': budgetMax,
      'detailedInterests': detailedInterests,
      'extraMemo': memo,
      'results': items
          .map((i) => {
                'giftName': i.title,
                'price': i.price,
                'reason': i.reason,
                'tip': i.deliveryTip,
                'purchaseUrl': i.naverShoppingUrl,
                'wish': i.isInWishlist,
              })
          .toList(),
      'congratsMessage': congratsMessage,
    });
    ref.invalidateSelf();
    await future;
  }

  Future<void> remove(String id) async {
    await _dio.delete('/recommendations/$id');
    ref.invalidateSelf();
    await future;
  }

  RecommendationRecord _fromServer(dynamic json) {
    final results = (json['results'] as List?) ?? [];
    final recipient = json['recipient'] as String? ?? '';
    return RecommendationRecord(
      id: json['id'].toString(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      recipient: recipient,
      subtitle: recipient.isEmpty ? 'AI 선물 추천' : '$recipient님을 위한 추천 선물',
      items: results
          .asMap()
          .entries
          .map((e) => _itemFromServer(e.key, e.value))
          .toList(),
      congratsMessage: json['congratsMessage'] as String? ?? '',
    );
  }

  GiftRecommendation _itemFromServer(int idx, dynamic r) => GiftRecommendation(
        id: idx.toString(),
        title: r['giftName'] as String? ?? '',
        price: (r['price'] as num?)?.toInt() ?? 0,
        reason: r['reason'] as String? ?? '',
        deliveryTip: r['tip'] as String? ?? '',
        searchQuery: r['giftName'] as String? ?? '',
        isInWishlist: r['wish'] as bool? ?? false,
      );
}
