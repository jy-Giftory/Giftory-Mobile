import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/domain/entities/repeat_type.dart';

part 'anniversary_model.freezed.dart';
part 'anniversary_model.g.dart';

@freezed
class AnniversaryModel with _$AnniversaryModel {
  const factory AnniversaryModel({
    required String id,
    required String title,
    required String originalDate,
    required String repeatType,
  }) = _AnniversaryModel;

  factory AnniversaryModel.fromJson(Map<String, dynamic> json) =>
      _$AnniversaryModelFromJson(json);
}

extension AnniversaryModelX on AnniversaryModel {
  Anniversary toEntity() => Anniversary(
        id: id,
        title: title,
        originalDate: DateTime.parse(originalDate),
        repeatType: _parseRepeatType(repeatType),
      );

  static RepeatType _parseRepeatType(String value) {
    switch (value) {
      case 'monthly':
        return RepeatType.monthly;
      case 'biMonthly':
        return RepeatType.biMonthly;
      default:
        return RepeatType.yearly;
    }
  }
}

extension AnniversaryX on Anniversary {
  AnniversaryModel toModel() => AnniversaryModel(
        id: id,
        title: title,
        originalDate: originalDate.toIso8601String(),
        repeatType: repeatType.name,
      );
}
