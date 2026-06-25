import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation_request.dart';
import 'package:giftory/features/gift_recommendation/domain/repositories/gift_recommendation_repository.dart';

class GetGiftRecommendationsUsecase {
  final GiftRecommendationRepository _repository;
  const GetGiftRecommendationsUsecase(this._repository);

  Future<({String subtitle, List<GiftRecommendation> items, String congratsMessage})>
      call(GiftRecommendationRequest request) =>
          _repository.getRecommendations(request);
}
