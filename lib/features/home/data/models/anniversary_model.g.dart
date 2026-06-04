// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniversary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnniversaryModelImpl _$$AnniversaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$AnniversaryModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  originalDate: json['originalDate'] as String,
  repeatType: json['repeatType'] as String,
);

Map<String, dynamic> _$$AnniversaryModelImplToJson(
  _$AnniversaryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'originalDate': instance.originalDate,
  'repeatType': instance.repeatType,
};
