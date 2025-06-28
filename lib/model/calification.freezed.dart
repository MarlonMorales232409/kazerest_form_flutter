// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Calification _$CalificationFromJson(Map<String, dynamic> json) {
  return _Calification.fromJson(json);
}

/// @nodoc
mixin _$Calification {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get maxValue => throw _privateConstructorUsedError;

  /// Serializes this Calification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Calification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalificationCopyWith<Calification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalificationCopyWith<$Res> {
  factory $CalificationCopyWith(
    Calification value,
    $Res Function(Calification) then,
  ) = _$CalificationCopyWithImpl<$Res, Calification>;
  @useResult
  $Res call({String id, String name, int maxValue});
}

/// @nodoc
class _$CalificationCopyWithImpl<$Res, $Val extends Calification>
    implements $CalificationCopyWith<$Res> {
  _$CalificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Calification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? maxValue = null}) {
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
abstract class _$$CalificationImplCopyWith<$Res>
    implements $CalificationCopyWith<$Res> {
  factory _$$CalificationImplCopyWith(
    _$CalificationImpl value,
    $Res Function(_$CalificationImpl) then,
  ) = __$$CalificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int maxValue});
}

/// @nodoc
class __$$CalificationImplCopyWithImpl<$Res>
    extends _$CalificationCopyWithImpl<$Res, _$CalificationImpl>
    implements _$$CalificationImplCopyWith<$Res> {
  __$$CalificationImplCopyWithImpl(
    _$CalificationImpl _value,
    $Res Function(_$CalificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Calification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? maxValue = null}) {
    return _then(
      _$CalificationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$CalificationImpl implements _Calification {
  const _$CalificationImpl({
    required this.id,
    required this.name,
    required this.maxValue,
  });

  factory _$CalificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalificationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int maxValue;

  @override
  String toString() {
    return 'Calification(id: $id, name: $name, maxValue: $maxValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, maxValue);

  /// Create a copy of Calification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalificationImplCopyWith<_$CalificationImpl> get copyWith =>
      __$$CalificationImplCopyWithImpl<_$CalificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalificationImplToJson(this);
  }
}

abstract class _Calification implements Calification {
  const factory _Calification({
    required final String id,
    required final String name,
    required final int maxValue,
  }) = _$CalificationImpl;

  factory _Calification.fromJson(Map<String, dynamic> json) =
      _$CalificationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get maxValue;

  /// Create a copy of Calification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalificationImplCopyWith<_$CalificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
