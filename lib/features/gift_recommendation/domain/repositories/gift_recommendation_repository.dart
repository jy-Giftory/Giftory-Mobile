import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation_request.dart';

abstract class GiftRecommendationRepository {
  Future<({String subtitle, List<GiftRecommendation> items, String congratsMessage})>
      getRecommendations(GiftRecommendationRequest request);
}
