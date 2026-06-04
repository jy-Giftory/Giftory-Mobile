import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';

part 'gift_recommendation_model.freezed.dart';
part 'gift_recommendation_model.g.dart';

@freezed
class GiftRecommendationModel with _$GiftRecommendationModel {
  const factory GiftRecommendationModel({
    required String title,
    required int price,
    required String reason,
    @JsonKey(name: 'delivery_tip') required String deliveryTip,
    @JsonKey(name: 'search_query') required String searchQuery,
  }) = _GiftRecommendationModel;

  factory GiftRecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$GiftRecommendationModelFromJson(json);
}

@freezed
class GiftRecommendationResponseModel with _$GiftRecommendationResponseModel {
  const factory GiftRecommendationResponseModel({
    required String subtitle,
    required List<GiftRecommendationModel> recommendations,
    @JsonKey(name: 'congrats_message') required String congratsMessage,
  }) = _GiftRecommendationResponseModel;

  factory GiftRecommendationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GiftRecommendationResponseModelFromJson(json);
}

extension GiftRecommendationModelX on GiftRecommendationModel {
  GiftRecommendation toEntity(String id) => GiftRecommendation(
        id: id,
        title: title,
        price: price,
        reason: reason,
        deliveryTip: deliveryTip,
        searchQuery: searchQuery,
      );
}
