// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_interest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserInterest _$UserInterestFromJson(Map<String, dynamic> json) {
  return _UserInterest.fromJson(json);
}

/// @nodoc
mixin _$UserInterest {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get maxLevel => throw _privateConstructorUsedError;
  int get userLevel => throw _privateConstructorUsedError;

  /// Serializes this UserInterest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInterest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInterestCopyWith<UserInterest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInterestCopyWith<$Res> {
  factory $UserInterestCopyWith(
    UserInterest value,
    $Res Function(UserInterest) then,
  ) = _$UserInterestCopyWithImpl<$Res, UserInterest>;
  @useResult
  $Res call({String? id, String title, int maxLevel, int userLevel});
}

/// @nodoc
class _$UserInterestCopyWithImpl<$Res, $Val extends UserInterest>
    implements $UserInterestCopyWith<$Res> {
  _$UserInterestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInterest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? maxLevel = null,
    Object? userLevel = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            maxLevel: null == maxLevel
                ? _value.maxLevel
                : maxLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            userLevel: null == userLevel
                ? _value.userLevel
                : userLevel // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserInterestImplCopyWith<$Res>
    implements $UserInterestCopyWith<$Res> {
  factory _$$UserInterestImplCopyWith(
    _$UserInterestImpl value,
    $Res Function(_$UserInterestImpl) then,
  ) = __$$UserInterestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String title, int maxLevel, int userLevel});
}

/// @nodoc
class __$$UserInterestImplCopyWithImpl<$Res>
    extends _$UserInterestCopyWithImpl<$Res, _$UserInterestImpl>
    implements _$$UserInterestImplCopyWith<$Res> {
  __$$UserInterestImplCopyWithImpl(
    _$UserInterestImpl _value,
    $Res Function(_$UserInterestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserInterest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? maxLevel = null,
    Object? userLevel = null,
  }) {
    return _then(
      _$UserInterestImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        maxLevel: null == maxLevel
            ? _value.maxLevel
            : maxLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        userLevel: null == userLevel
            ? _value.userLevel
            : userLevel // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInterestImpl implements _UserInterest {
  const _$UserInterestImpl({
    this.id,
    required this.title,
    required this.maxLevel,
    required this.userLevel,
  });

  factory _$UserInterestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInterestImplFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final int maxLevel;
  @override
  final int userLevel;

  @override
  String toString() {
    return 'UserInterest(id: $id, title: $title, maxLevel: $maxLevel, userLevel: $userLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInterestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.maxLevel, maxLevel) ||
                other.maxLevel == maxLevel) &&
            (identical(other.userLevel, userLevel) ||
                other.userLevel == userLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, maxLevel, userLevel);

  /// Create a copy of UserInterest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInterestImplCopyWith<_$UserInterestImpl> get copyWith =>
      __$$UserInterestImplCopyWithImpl<_$UserInterestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInterestImplToJson(this);
  }
}

abstract class _UserInterest implements UserInterest {
  const factory _UserInterest({
    final String? id,
    required final String title,
    required final int maxLevel,
    required final int userLevel,
  }) = _$UserInterestImpl;

  factory _UserInterest.fromJson(Map<String, dynamic> json) =
      _$UserInterestImpl.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  int get maxLevel;
  @override
  int get userLevel;

  /// Create a copy of UserInterest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInterestImplCopyWith<_$UserInterestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
