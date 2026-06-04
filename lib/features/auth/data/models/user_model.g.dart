part of 'user_model.dart';

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(id: json['id'] as String, email: json['email'] as String);

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{'id': instance.id, 'email': instance.email};
