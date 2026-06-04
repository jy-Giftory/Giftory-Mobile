// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_recommendation_model.dart';

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GiftRecommendationModel _$GiftRecommendationModelFromJson(
  Map<String, dynamic> json,
) {
  return _GiftRecommendationModel.fromJson(json);
}

mixin _$GiftRecommendationModel {
  String get title => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_tip')
  String get deliveryTip => throw _privateConstructorUsedError;
  @JsonKey(name: 'search_query')
  String get searchQuery => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftRecommendationModelCopyWith<GiftRecommendationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $GiftRecommendationModelCopyWith<$Res> {
  factory $GiftRecommendationModelCopyWith(
    GiftRecommendationModel value,
    $Res Function(GiftRecommendationModel) then,
  ) = _$GiftRecommendationModelCopyWithImpl<$Res, GiftRecommendationModel>;
  @useResult
  $Res call({
    String title,
    int price,
    String reason,
    @JsonKey(name: 'delivery_tip') String deliveryTip,
    @JsonKey(name: 'search_query') String searchQuery,
  });
}

class _$GiftRecommendationModelCopyWithImpl<
  $Res,
  $Val extends GiftRecommendationModel
>
    implements $GiftRecommendationModelCopyWith<$Res> {
  _$GiftRecommendationModelCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? price = null,
    Object? reason = null,
    Object? deliveryTip = null,
    Object? searchQuery = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title
                      as String,
            price: null == price
                ? _value.price
                : price
                      as int,
            reason: null == reason
                ? _value.reason
                : reason
                      as String,
            deliveryTip: null == deliveryTip
                ? _value.deliveryTip
                : deliveryTip
                      as String,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery
                      as String,
          )
          as $Val,
    );
  }
}

abstract class _$$GiftRecommendationModelImplCopyWith<$Res>
    implements $GiftRecommendationModelCopyWith<$Res> {
  factory _$$GiftRecommendationModelImplCopyWith(
    _$GiftRecommendationModelImpl value,
    $Res Function(_$GiftRecommendationModelImpl) then,
  ) = __$$GiftRecommendationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    int price,
    String reason,
    @JsonKey(name: 'delivery_tip') String deliveryTip,
    @JsonKey(name: 'search_query') String searchQuery,
  });
}

class __$$GiftRecommendationModelImplCopyWithImpl<$Res>
    extends
        _$GiftRecommendationModelCopyWithImpl<
          $Res,
          _$GiftRecommendationModelImpl
        >
    implements _$$GiftRecommendationModelImplCopyWith<$Res> {
  __$$GiftRecommendationModelImplCopyWithImpl(
    _$GiftRecommendationModelImpl _value,
    $Res Function(_$GiftRecommendationModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? price = null,
    Object? reason = null,
    Object? deliveryTip = null,
    Object? searchQuery = null,
  }) {
    return _then(
      _$GiftRecommendationModelImpl(
        title: null == title
            ? _value.title
            : title
                  as String,
        price: null == price
            ? _value.price
            : price
                  as int,
        reason: null == reason
            ? _value.reason
            : reason
                  as String,
        deliveryTip: null == deliveryTip
            ? _value.deliveryTip
            : deliveryTip
                  as String,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftRecommendationModelImpl implements _GiftRecommendationModel {
  const _$GiftRecommendationModelImpl({
    required this.title,
    required this.price,
    required this.reason,
    @JsonKey(name: 'delivery_tip') required this.deliveryTip,
    @JsonKey(name: 'search_query') required this.searchQuery,
  });

  factory _$GiftRecommendationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftRecommendationModelImplFromJson(json);

  @override
  final String title;
  @override
  final int price;
  @override
  final String reason;
  @override
  @JsonKey(name: 'delivery_tip')
  final String deliveryTip;
  @override
  @JsonKey(name: 'search_query')
  final String searchQuery;

  @override
  String toString() {
    return 'GiftRecommendationModel(title: $title, price: $price, reason: $reason, deliveryTip: $deliveryTip, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftRecommendationModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.deliveryTip, deliveryTip) ||
                other.deliveryTip == deliveryTip) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, price, reason, deliveryTip, searchQuery);

  /// Create a copy of GiftRecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftRecommendationModelImplCopyWith<_$GiftRecommendationModelImpl>
  get copyWith =>
      __$$GiftRecommendationModelImplCopyWithImpl<
        _$GiftRecommendationModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftRecommendationModelImplToJson(this);
  }
}

abstract class _GiftRecommendationModel implements GiftRecommendationModel {
  const factory _GiftRecommendationModel({
    required final String title,
    required final int price,
    required final String reason,
    @JsonKey(name: 'delivery_tip') required final String deliveryTip,
    @JsonKey(name: 'search_query') required final String searchQuery,
  }) = _$GiftRecommendationModelImpl;

  factory _GiftRecommendationModel.fromJson(Map<String, dynamic> json) =
      _$GiftRecommendationModelImpl.fromJson;

  @override
  String get title;
  @override
  int get price;
  @override
  String get reason;
  @override
  @JsonKey(name: 'delivery_tip')
  String get deliveryTip;
  @override
  @JsonKey(name: 'search_query')
  String get searchQuery;

  /// Create a copy of GiftRecommendationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftRecommendationModelImplCopyWith<_$GiftRecommendationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

GiftRecommendationResponseModel _$GiftRecommendationResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _GiftRecommendationResponseModel.fromJson(json);
}

/// @nodoc
mixin _$GiftRecommendationResponseModel {
  String get subtitle => throw _privateConstructorUsedError;
  List<GiftRecommendationModel> get recommendations =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'congrats_message')
  String get congratsMessage => throw _privateConstructorUsedError;

  /// Serializes this GiftRecommendationResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftRecommendationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftRecommendationResponseModelCopyWith<GiftRecommendationResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftRecommendationResponseModelCopyWith<$Res> {
  factory $GiftRecommendationResponseModelCopyWith(
    GiftRecommendationResponseModel value,
    $Res Function(GiftRecommendationResponseModel) then,
  ) =
      _$GiftRecommendationResponseModelCopyWithImpl<
        $Res,
        GiftRecommendationResponseModel
      >;
  @useResult
  $Res call({
    String subtitle,
    List<GiftRecommendationModel> recommendations,
    @JsonKey(name: 'congrats_message') String congratsMessage,
  });
}

/// @nodoc
class _$GiftRecommendationResponseModelCopyWithImpl<
  $Res,
  $Val extends GiftRecommendationResponseModel
>
    implements $GiftRecommendationResponseModelCopyWith<$Res> {
  _$GiftRecommendationResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftRecommendationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtitle = null,
    Object? recommendations = null,
    Object? congratsMessage = null,
  }) {
    return _then(
      _value.copyWith(
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            recommendations: null == recommendations
                ? _value.recommendations
                : recommendations // ignore: cast_nullable_to_non_nullable
                      as List<GiftRecommendationModel>,
            congratsMessage: null == congratsMessage
                ? _value.congratsMessage
                : congratsMessage // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GiftRecommendationResponseModelImplCopyWith<$Res>
    implements $GiftRecommendationResponseModelCopyWith<$Res> {
  factory _$$GiftRecommendationResponseModelImplCopyWith(
    _$GiftRecommendationResponseModelImpl value,
    $Res Function(_$GiftRecommendationResponseModelImpl) then,
  ) = __$$GiftRecommendationResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String subtitle,
    List<GiftRecommendationModel> recommendations,
    @JsonKey(name: 'congrats_message') String congratsMessage,
  });
}

/// @nodoc
class __$$GiftRecommendationResponseModelImplCopyWithImpl<$Res>
    extends
        _$GiftRecommendationResponseModelCopyWithImpl<
          $Res,
          _$GiftRecommendationResponseModelImpl
        >
    implements _$$GiftRecommendationResponseModelImplCopyWith<$Res> {
  __$$GiftRecommendationResponseModelImplCopyWithImpl(
    _$GiftRecommendationResponseModelImpl _value,
    $Res Function(_$GiftRecommendationResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GiftRecommendationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtitle = null,
    Object? recommendations = null,
    Object? congratsMessage = null,
  }) {
    return _then(
      _$GiftRecommendationResponseModelImpl(
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        recommendations: null == recommendations
            ? _value._recommendations
            : recommendations // ignore: cast_nullable_to_non_nullable
                  as List<GiftRecommendationModel>,
        congratsMessage: null == congratsMessage
            ? _value.congratsMessage
            : congratsMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftRecommendationResponseModelImpl
    implements _GiftRecommendationResponseModel {
  const _$GiftRecommendationResponseModelImpl({
    required this.subtitle,
    required final List<GiftRecommendationModel> recommendations,
    @JsonKey(name: 'congrats_message') required this.congratsMessage,
  }) : _recommendations = recommendations;

  factory _$GiftRecommendationResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$GiftRecommendationResponseModelImplFromJson(json);

  @override
  final String subtitle;
  final List<GiftRecommendationModel> _recommendations;
  @override
  List<GiftRecommendationModel> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  @JsonKey(name: 'congrats_message')
  final String congratsMessage;

  @override
  String toString() {
    return 'GiftRecommendationResponseModel(subtitle: $subtitle, recommendations: $recommendations, congratsMessage: $congratsMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftRecommendationResponseModelImpl &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            const DeepCollectionEquality().equals(
              other._recommendations,
              _recommendations,
            ) &&
            (identical(other.congratsMessage, congratsMessage) ||
                other.congratsMessage == congratsMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    subtitle,
    const DeepCollectionEquality().hash(_recommendations),
    congratsMessage,
  );

  /// Create a copy of GiftRecommendationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftRecommendationResponseModelImplCopyWith<
    _$GiftRecommendationResponseModelImpl
  >
  get copyWith =>
      __$$GiftRecommendationResponseModelImplCopyWithImpl<
        _$GiftRecommendationResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftRecommendationResponseModelImplToJson(this);
  }
}

abstract class _GiftRecommendationResponseModel
    implements GiftRecommendationResponseModel {
  const factory _GiftRecommendationResponseModel({
    required final String subtitle,
    required final List<GiftRecommendationModel> recommendations,
    @JsonKey(name: 'congrats_message') required final String congratsMessage,
  }) = _$GiftRecommendationResponseModelImpl;

  factory _GiftRecommendationResponseModel.fromJson(Map<String, dynamic> json) =
      _$GiftRecommendationResponseModelImpl.fromJson;

  @override
  String get subtitle;
  @override
  List<GiftRecommendationModel> get recommendations;
  @override
  @JsonKey(name: 'congrats_message')
  String get congratsMessage;

  /// Create a copy of GiftRecommendationResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftRecommendationResponseModelImplCopyWith<
    _$GiftRecommendationResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
