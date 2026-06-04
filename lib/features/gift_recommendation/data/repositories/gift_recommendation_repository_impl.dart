import 'package:giftory/features/gift_recommendation/data/datasources/gift_recommendation_datasource.dart';
import 'package:giftory/features/gift_recommendation/data/models/gift_recommendation_model.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation_request.dart';
import 'package:giftory/features/gift_recommendation/domain/repositories/gift_recommendation_repository.dart';

class GiftRecommendationRepositoryImpl implements GiftRecommendationRepository {
  final GiftRecommendationDatasource _datasource;
  const GiftRecommendationRepositoryImpl(this._datasource);

  @override
  Future<({String subtitle, List<GiftRecommendation> items, String congratsMessage})>
      getRecommendations(GiftRecommendationRequest request) async {
    final response = await _datasource.fetch(request);
    final items = response.recommendations
        .asMap()
        .entries
        .map((e) => e.value.toEntity(e.key.toString()))
        .toList();
    return (
      subtitle: response.subtitle,
      items: items,
      congratsMessage: response.congratsMessage,
    );
  }
}
