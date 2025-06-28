// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_module.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SystemModule _$SystemModuleFromJson(Map<String, dynamic> json) {
  return _SystemModule.fromJson(json);
}

/// @nodoc
mixin _$SystemModule {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this SystemModule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SystemModule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SystemModuleCopyWith<SystemModule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemModuleCopyWith<$Res> {
  factory $SystemModuleCopyWith(
    SystemModule value,
    $Res Function(SystemModule) then,
  ) = _$SystemModuleCopyWithImpl<$Res, SystemModule>;
  @useResult
  $Res call({String id, String title, String description});
}

/// @nodoc
class _$SystemModuleCopyWithImpl<$Res, $Val extends SystemModule>
    implements $SystemModuleCopyWith<$Res> {
  _$SystemModuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SystemModule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SystemModuleImplCopyWith<$Res>
    implements $SystemModuleCopyWith<$Res> {
  factory _$$SystemModuleImplCopyWith(
    _$SystemModuleImpl value,
    $Res Function(_$SystemModuleImpl) then,
  ) = __$$SystemModuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String description});
}

/// @nodoc
class __$$SystemModuleImplCopyWithImpl<$Res>
    extends _$SystemModuleCopyWithImpl<$Res, _$SystemModuleImpl>
    implements _$$SystemModuleImplCopyWith<$Res> {
  __$$SystemModuleImplCopyWithImpl(
    _$SystemModuleImpl _value,
    $Res Function(_$SystemModuleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SystemModule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(
      _$SystemModuleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SystemModuleImpl implements _SystemModule {
  const _$SystemModuleImpl({
    required this.id,
    required this.title,
    required this.description,
  });

  factory _$SystemModuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemModuleImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'SystemModule(id: $id, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemModuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description);

  /// Create a copy of SystemModule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemModuleImplCopyWith<_$SystemModuleImpl> get copyWith =>
      __$$SystemModuleImplCopyWithImpl<_$SystemModuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemModuleImplToJson(this);
  }
}

abstract class _SystemModule implements SystemModule {
  const factory _SystemModule({
    required final String id,
    required final String title,
    required final String description,
  }) = _$SystemModuleImpl;

  factory _SystemModule.fromJson(Map<String, dynamic> json) =
      _$SystemModuleImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;

  /// Create a copy of SystemModule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SystemModuleImplCopyWith<_$SystemModuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
