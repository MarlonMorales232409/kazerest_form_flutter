// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_importance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CategoryImportance _$CategoryImportanceFromJson(Map<String, dynamic> json) {
  return _CategoryImportance.fromJson(json);
}

/// @nodoc
mixin _$CategoryImportance {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  int get maxValue => throw _privateConstructorUsedError;

  /// Serializes this CategoryImportance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryImportance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryImportanceCopyWith<CategoryImportance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryImportanceCopyWith<$Res> {
  factory $CategoryImportanceCopyWith(
    CategoryImportance value,
    $Res Function(CategoryImportance) then,
  ) = _$CategoryImportanceCopyWithImpl<$Res, CategoryImportance>;
  @useResult
  $Res call({String id, String name, int value, int maxValue});
}

/// @nodoc
class _$CategoryImportanceCopyWithImpl<$Res, $Val extends CategoryImportance>
    implements $CategoryImportanceCopyWith<$Res> {
  _$CategoryImportanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryImportance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? value = null,
    Object? maxValue = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
            maxValue: null == maxValue
                ? _value.maxValue
                : maxValue // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryImportanceImplCopyWith<$Res>
    implements $CategoryImportanceCopyWith<$Res> {
  factory _$$CategoryImportanceImplCopyWith(
    _$CategoryImportanceImpl value,
    $Res Function(_$CategoryImportanceImpl) then,
  ) = __$$CategoryImportanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int value, int maxValue});
}

/// @nodoc
class __$$CategoryImportanceImplCopyWithImpl<$Res>
    extends _$CategoryImportanceCopyWithImpl<$Res, _$CategoryImportanceImpl>
    implements _$$CategoryImportanceImplCopyWith<$Res> {
  __$$CategoryImportanceImplCopyWithImpl(
    _$CategoryImportanceImpl _value,
    $Res Function(_$CategoryImportanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryImportance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? value = null,
    Object? maxValue = null,
  }) {
    return _then(
      _$CategoryImportanceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
        maxValue: null == maxValue
            ? _value.maxValue
            : maxValue // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImportanceImpl implements _CategoryImportance {
  const _$CategoryImportanceImpl({
    required this.id,
    required this.name,
    required this.value,
    required this.maxValue,
  });

  factory _$CategoryImportanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImportanceImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int value;
  @override
  final int maxValue;

  @override
  String toString() {
    return 'CategoryImportance(id: $id, name: $name, value: $value, maxValue: $maxValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImportanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, value, maxValue);

  /// Create a copy of CategoryImportance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImportanceImplCopyWith<_$CategoryImportanceImpl> get copyWith =>
      __$$CategoryImportanceImplCopyWithImpl<_$CategoryImportanceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImportanceImplToJson(this);
  }
}

abstract class _CategoryImportance implements CategoryImportance {
  const factory _CategoryImportance({
    required final String id,
    required final String name,
    required final int value,
    required final int maxValue,
  }) = _$CategoryImportanceImpl;

  factory _CategoryImportance.fromJson(Map<String, dynamic> json) =
      _$CategoryImportanceImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get value;
  @override
  int get maxValue;

  /// Create a copy of CategoryImportance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryImportanceImplCopyWith<_$CategoryImportanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
