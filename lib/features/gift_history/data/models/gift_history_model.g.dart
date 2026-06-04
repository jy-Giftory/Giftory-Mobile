part of 'gift_history_model.dart';

_$GiftHistoryModelImpl _$$GiftHistoryModelImplFromJson(
  Map<String, dynamic> json,
) => _$GiftHistoryModelImpl(
  id: json['id'] as String,
  recipientName: json['recipientName'] as String,
  giftName: json['giftName'] as String,
  date: json['date'] as String,
  price: (json['price'] as num).toInt(),
  satisfaction: (json['satisfaction'] as num).toInt(),
  occasionLabel: json['occasionLabel'] as String?,
  memo: json['memo'] as String?,
  purchaseLink: json['purchaseLink'] as String?,
);

Map<String, dynamic> _$$GiftHistoryModelImplToJson(
  _$GiftHistoryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'recipientName': instance.recipientName,
  'giftName': instance.giftName,
  'date': instance.date,
  'price': instance.price,
  'satisfaction': instance.satisfaction,
  'occasionLabel': instance.occasionLabel,
  'memo': instance.memo,
  'purchaseLink': instance.purchaseLink,
};
