part of 'gift_recommendation_model.dart';

_$GiftRecommendationModelImpl _$$GiftRecommendationModelImplFromJson(
  Map<String, dynamic> json,
) => _$GiftRecommendationModelImpl(
  title: json['title'] as String,
  price: (json['price'] as num).toInt(),
  reason: json['reason'] as String,
  deliveryTip: json['delivery_tip'] as String,
  searchQuery: json['search_query'] as String,
);

Map<String, dynamic> _$$GiftRecommendationModelImplToJson(
  _$GiftRecommendationModelImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'price': instance.price,
  'reason': instance.reason,
  'delivery_tip': instance.deliveryTip,
  'search_query': instance.searchQuery,
};

_$GiftRecommendationResponseModelImpl
_$$GiftRecommendationResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$GiftRecommendationResponseModelImpl(
      subtitle: json['subtitle'] as String,
      recommendations: (json['recommendations'] as List<dynamic>)
          .map(
            (e) => GiftRecommendationModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      congratsMessage: json['congrats_message'] as String,
    );

Map<String, dynamic> _$$GiftRecommendationResponseModelImplToJson(
  _$GiftRecommendationResponseModelImpl instance,
) => <String, dynamic>{
  'subtitle': instance.subtitle,
  'recommendations': instance.recommendations,
  'congrats_message': instance.congratsMessage,
};
