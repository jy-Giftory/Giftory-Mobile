part of 'anniversary_model.dart';

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnniversaryModel _$AnniversaryModelFromJson(Map<String, dynamic> json) {
  return _AnniversaryModel.fromJson(json);
}

mixin _$AnniversaryModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get originalDate =>
      throw _privateConstructorUsedError;
  String get repeatType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnniversaryModelCopyWith<AnniversaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $AnniversaryModelCopyWith<$Res> {
  factory $AnniversaryModelCopyWith(
    AnniversaryModel value,
    $Res Function(AnniversaryModel) then,
  ) = _$AnniversaryModelCopyWithImpl<$Res, AnniversaryModel>;
  @useResult
  $Res call({String id, String title, String originalDate, String repeatType});
}

class _$AnniversaryModelCopyWithImpl<$Res, $Val extends AnniversaryModel>
    implements $AnniversaryModelCopyWith<$Res> {
  _$AnniversaryModelCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

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
                : id
                      as String,
            title: null == title
                ? _value.title
                : title
                      as String,
            originalDate: null == originalDate
                ? _value.originalDate
                : originalDate
                      as String,
            repeatType: null == repeatType
                ? _value.repeatType
                : repeatType
                      as String,
          )
          as $Val,
    );
  }
}

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

class __$$AnniversaryModelImplCopyWithImpl<$Res>
    extends _$AnniversaryModelCopyWithImpl<$Res, _$AnniversaryModelImpl>
    implements _$$AnniversaryModelImplCopyWith<$Res> {
  __$$AnniversaryModelImplCopyWithImpl(
    _$AnniversaryModelImpl _value,
    $Res Function(_$AnniversaryModelImpl) _then,
  ) : super(_value, _then);

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
            : id
                  as String,
        title: null == title
            ? _value.title
            : title
                  as String,
        originalDate: null == originalDate
            ? _value.originalDate
            : originalDate
                  as String,
        repeatType: null == repeatType
            ? _value.repeatType
            : repeatType
                  as String,
      ),
    );
  }
}

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

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnniversaryModelImplCopyWith<_$AnniversaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
