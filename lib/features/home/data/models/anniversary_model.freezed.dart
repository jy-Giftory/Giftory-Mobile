// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anniversary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnniversaryModel _$AnniversaryModelFromJson(Map<String, dynamic> json) {
  return _AnniversaryModel.fromJson(json);
}

/// @nodoc
mixin _$AnniversaryModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get originalDate => throw _privateConstructorUsedError;
  String get repeatType => throw _privateConstructorUsedError;

  /// Serializes this AnniversaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnniversaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnniversaryModelCopyWith<AnniversaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnniversaryModelCopyWith<$Res> {
  factory $AnniversaryModelCopyWith(
    AnniversaryModel value,
    $Res Function(AnniversaryModel) then,
  ) = _$AnniversaryModelCopyWithImpl<$Res, AnniversaryModel>;
  @useResult
  $Res call({String id, String title, String originalDate, String repeatType});
}

/// @nodoc
class _$AnniversaryModelCopyWithImpl<$Res, $Val extends AnniversaryModel>
    implements $AnniversaryModelCopyWith<$Res> {
  _$AnniversaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnniversaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? originalDate = null,
    Object? repeatType = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            originalDate: null == originalDate
                ? _value.originalDate
                : originalDate // ignore: cast_nullable_to_non_nullable
                      as String,
            repeatType: null == repeatType
                ? _value.repeatType
                : repeatType // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnniversaryModelImplCopyWith<$Res>
    implements $AnniversaryModelCopyWith<$Res> {
  factory _$$AnniversaryModelImplCopyWith(
    _$AnniversaryModelImpl value,
    $Res Function(_$AnniversaryModelImpl) then,
  ) = __$$AnniversaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String originalDate, String repeatType});
}

/// @nodoc
class __$$AnniversaryModelImplCopyWithImpl<$Res>
    extends _$AnniversaryModelCopyWithImpl<$Res, _$AnniversaryModelImpl>
    implements _$$AnniversaryModelImplCopyWith<$Res> {
  __$$AnniversaryModelImplCopyWithImpl(
    _$AnniversaryModelImpl _value,
    $Res Function(_$AnniversaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnniversaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? originalDate = null,
    Object? repeatType = null,
  }) {
    return _then(
      _$AnniversaryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        originalDate: null == originalDate
            ? _value.originalDate
            : originalDate // ignore: cast_nullable_to_non_nullable
                  as String,
        repeatType: null == repeatType
            ? _value.repeatType
            : repeatType // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnniversaryModelImpl implements _AnniversaryModel {
  const _$AnniversaryModelImpl({
    required this.id,
    required this.title,
    required this.originalDate,
    required this.repeatType,
  });

  factory _$AnniversaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnniversaryModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String originalDate;
  @override
  final String repeatType;

  @override
  String toString() {
    return 'AnniversaryModel(id: $id, title: $title, originalDate: $originalDate, repeatType: $repeatType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnniversaryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.originalDate, originalDate) ||
                other.originalDate == originalDate) &&
            (identical(other.repeatType, repeatType) ||
                other.repeatType == repeatType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, originalDate, repeatType);

  /// Create a copy of AnniversaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnniversaryModelImplCopyWith<_$AnniversaryModelImpl> get copyWith =>
      __$$AnniversaryModelImplCopyWithImpl<_$AnniversaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnniversaryModelImplToJson(this);
  }
}

abstract class _AnniversaryModel implements AnniversaryModel {
  const factory _AnniversaryModel({
    required final String id,
    required final String title,
    required final String originalDate,
    required final String repeatType,
  }) = _$AnniversaryModelImpl;

  factory _AnniversaryModel.fromJson(Map<String, dynamic> json) =
      _$AnniversaryModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get originalDate;
  @override
  String get repeatType;

  /// Create a copy of AnniversaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnniversaryModelImplCopyWith<_$AnniversaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
