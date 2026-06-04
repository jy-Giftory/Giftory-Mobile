import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';

part 'gift_history_model.freezed.dart';
part 'gift_history_model.g.dart';

@freezed
class GiftHistoryModel with _$GiftHistoryModel {
  const factory GiftHistoryModel({
    required String id,
    required String recipientName,
    required String giftName,
    required String date,
    required int price,
    required int satisfaction,
    String? occasionLabel,
    String? memo,
    String? purchaseLink,
  }) = _GiftHistoryModel;

  factory GiftHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$GiftHistoryModelFromJson(json);
}

extension GiftHistoryModelX on GiftHistoryModel {
  GiftHistory toEntity() => GiftHistory(
        id: id,
        recipientName: recipientName,
        giftName: giftName,
        date: DateTime.parse(date),
        price: price,
        satisfaction: satisfaction,
        occasionLabel: occasionLabel,
        memo: memo,
        purchaseLink: purchaseLink,
      );
}

extension GiftHistoryX on GiftHistory {
  GiftHistoryModel toModel() => GiftHistoryModel(
        id: id,
        recipientName: recipientName,
        giftName: giftName,
        date: date.toIso8601String(),
        price: price,
        satisfaction: satisfaction,
        occasionLabel: occasionLabel,
        memo: memo,
        purchaseLink: purchaseLink,
      );
}
