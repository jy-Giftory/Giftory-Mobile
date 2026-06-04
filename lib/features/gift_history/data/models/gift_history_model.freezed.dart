part of 'gift_history_model.dart';

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GiftHistoryModel _$GiftHistoryModelFromJson(Map<String, dynamic> json) {
  return _GiftHistoryModel.fromJson(json);
}

mixin _$GiftHistoryModel {
  String get id => throw _privateConstructorUsedError;
  String get recipientName => throw _privateConstructorUsedError;
  String get giftName => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int get satisfaction => throw _privateConstructorUsedError;
  String? get occasionLabel => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  String? get purchaseLink => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftHistoryModelCopyWith<GiftHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $GiftHistoryModelCopyWith<$Res> {
  factory $GiftHistoryModelCopyWith(
    GiftHistoryModel value,
    $Res Function(GiftHistoryModel) then,
  ) = _$GiftHistoryModelCopyWithImpl<$Res, GiftHistoryModel>;
  @useResult
  $Res call({
    String id,
    String recipientName,
    String giftName,
    String date,
    int price,
    int satisfaction,
    String? occasionLabel,
    String? memo,
    String? purchaseLink,
  });
}

class _$GiftHistoryModelCopyWithImpl<$Res, $Val extends GiftHistoryModel>
    implements $GiftHistoryModelCopyWith<$Res> {
  _$GiftHistoryModelCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recipientName = null,
    Object? giftName = null,
    Object? date = null,
    Object? price = null,
    Object? satisfaction = null,
    Object? occasionLabel = freezed,
    Object? memo = freezed,
    Object? purchaseLink = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id
                      as String,
            recipientName: null == recipientName
                ? _value.recipientName
                : recipientName
                      as String,
            giftName: null == giftName
                ? _value.giftName
                : giftName
                      as String,
            date: null == date
                ? _value.date
                : date
                      as String,
            price: null == price
                ? _value.price
                : price
                      as int,
            satisfaction: null == satisfaction
                ? _value.satisfaction
                : satisfaction
                      as int,
            occasionLabel: freezed == occasionLabel
                ? _value.occasionLabel
                : occasionLabel
                      as String?,
            memo: freezed == memo
                ? _value.memo
                : memo
                      as String?,
            purchaseLink: freezed == purchaseLink
                ? _value.purchaseLink
                : purchaseLink
                      as String?,
          )
          as $Val,
    );
  }
}

abstract class _$$GiftHistoryModelImplCopyWith<$Res>
    implements $GiftHistoryModelCopyWith<$Res> {
  factory _$$GiftHistoryModelImplCopyWith(
    _$GiftHistoryModelImpl value,
    $Res Function(_$GiftHistoryModelImpl) then,
  ) = __$$GiftHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String recipientName,
    String giftName,
    String date,
    int price,
    int satisfaction,
    String? occasionLabel,
    String? memo,
    String? purchaseLink,
  });
}

class __$$GiftHistoryModelImplCopyWithImpl<$Res>
    extends _$GiftHistoryModelCopyWithImpl<$Res, _$GiftHistoryModelImpl>
    implements _$$GiftHistoryModelImplCopyWith<$Res> {
  __$$GiftHistoryModelImplCopyWithImpl(
    _$GiftHistoryModelImpl _value,
    $Res Function(_$GiftHistoryModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recipientName = null,
    Object? giftName = null,
    Object? date = null,
    Object? price = null,
    Object? satisfaction = null,
    Object? occasionLabel = freezed,
    Object? memo = freezed,
    Object? purchaseLink = freezed,
  }) {
    return _then(
      _$GiftHistoryModelImpl(
        id: null == id
            ? _value.id
            : id
                  as String,
        recipientName: null == recipientName
            ? _value.recipientName
            : recipientName
                  as String,
        giftName: null == giftName
            ? _value.giftName
            : giftName
                  as String,
        date: null == date
            ? _value.date
            : date
                  as String,
        price: null == price
            ? _value.price
            : price
                  as int,
        satisfaction: null == satisfaction
            ? _value.satisfaction
            : satisfaction
                  as int,
        occasionLabel: freezed == occasionLabel
            ? _value.occasionLabel
            : occasionLabel
                  as String?,
        memo: freezed == memo
            ? _value.memo
            : memo
                  as String?,
        purchaseLink: freezed == purchaseLink
            ? _value.purchaseLink
            : purchaseLink
                  as String?,
      ),
    );
  }
}

@JsonSerializable()
class _$GiftHistoryModelImpl implements _GiftHistoryModel {
  const _$GiftHistoryModelImpl({
    required this.id,
    required this.recipientName,
    required this.giftName,
    required this.date,
    required this.price,
    required this.satisfaction,
    this.occasionLabel,
    this.memo,
    this.purchaseLink,
  });

  factory _$GiftHistoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftHistoryModelImplFromJson(json);

  @override
  final String id;
  @override
  final String recipientName;
  @override
  final String giftName;
  @override
  final String date;
  @override
  final int price;
  @override
  final int satisfaction;
  @override
  final String? occasionLabel;
  @override
  final String? memo;
  @override
  final String? purchaseLink;

  @override
  String toString() {
    return 'GiftHistoryModel(id: $id, recipientName: $recipientName, giftName: $giftName, date: $date, price: $price, satisfaction: $satisfaction, occasionLabel: $occasionLabel, memo: $memo, purchaseLink: $purchaseLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftHistoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.giftName, giftName) ||
                other.giftName == giftName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.satisfaction, satisfaction) ||
                other.satisfaction == satisfaction) &&
            (identical(other.occasionLabel, occasionLabel) ||
                other.occasionLabel == occasionLabel) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.purchaseLink, purchaseLink) ||
                other.purchaseLink == purchaseLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    recipientName,
    giftName,
    date,
    price,
    satisfaction,
    occasionLabel,
    memo,
    purchaseLink,
  );

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftHistoryModelImplCopyWith<_$GiftHistoryModelImpl> get copyWith =>
      __$$GiftHistoryModelImplCopyWithImpl<_$GiftHistoryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftHistoryModelImplToJson(this);
  }
}

abstract class _GiftHistoryModel implements GiftHistoryModel {
  const factory _GiftHistoryModel({
    required final String id,
    required final String recipientName,
    required final String giftName,
    required final String date,
    required final int price,
    required final int satisfaction,
    final String? occasionLabel,
    final String? memo,
    final String? purchaseLink,
  }) = _$GiftHistoryModelImpl;

  factory _GiftHistoryModel.fromJson(Map<String, dynamic> json) =
      _$GiftHistoryModelImpl.fromJson;

  @override
  String get id;
  @override
  String get recipientName;
  @override
  String get giftName;
  @override
  String get date;
  @override
  int get price;
  @override
  int get satisfaction;
  @override
  String? get occasionLabel;
  @override
  String? get memo;
  @override
  String? get purchaseLink;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftHistoryModelImplCopyWith<_$GiftHistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
