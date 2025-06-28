// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get restaurantName => throw _privateConstructorUsedError;
  RestaurantType get restaurantType => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  int get numberOfTables => throw _privateConstructorUsedError;
  int get numberOfEmployees => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get comments => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    int id,
    String name,
    String email,
    String restaurantName,
    RestaurantType restaurantType,
    String phone,
    int numberOfTables,
    int numberOfEmployees,
    String city,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? comments,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? restaurantName = null,
    Object? restaurantType = null,
    Object? phone = null,
    Object? numberOfTables = null,
    Object? numberOfEmployees = null,
    Object? city = null,
    Object? phoneNumber = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? comments = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            restaurantName: null == restaurantName
                ? _value.restaurantName
                : restaurantName // ignore: cast_nullable_to_non_nullable
                      as String,
            restaurantType: null == restaurantType
                ? _value.restaurantType
                : restaurantType // ignore: cast_nullable_to_non_nullable
                      as RestaurantType,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            numberOfTables: null == numberOfTables
                ? _value.numberOfTables
                : numberOfTables // ignore: cast_nullable_to_non_nullable
                      as int,
            numberOfEmployees: null == numberOfEmployees
                ? _value.numberOfEmployees
                : numberOfEmployees // ignore: cast_nullable_to_non_nullable
                      as int,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            comments: freezed == comments
                ? _value.comments
                : comments // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String email,
    String restaurantName,
    RestaurantType restaurantType,
    String phone,
    int numberOfTables,
    int numberOfEmployees,
    String city,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? comments,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? restaurantName = null,
    Object? restaurantType = null,
    Object? phone = null,
    Object? numberOfTables = null,
    Object? numberOfEmployees = null,
    Object? city = null,
    Object? phoneNumber = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? comments = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        restaurantName: null == restaurantName
            ? _value.restaurantName
            : restaurantName // ignore: cast_nullable_to_non_nullable
                  as String,
        restaurantType: null == restaurantType
            ? _value.restaurantType
            : restaurantType // ignore: cast_nullable_to_non_nullable
                  as RestaurantType,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        numberOfTables: null == numberOfTables
            ? _value.numberOfTables
            : numberOfTables // ignore: cast_nullable_to_non_nullable
                  as int,
        numberOfEmployees: null == numberOfEmployees
            ? _value.numberOfEmployees
            : numberOfEmployees // ignore: cast_nullable_to_non_nullable
                  as int,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        comments: freezed == comments
            ? _value.comments
            : comments // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.id,
    required this.name,
    required this.email,
    required this.restaurantName,
    required this.restaurantType,
    required this.phone,
    required this.numberOfTables,
    required this.numberOfEmployees,
    required this.city,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.comments,
  });

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String restaurantName;
  @override
  final RestaurantType restaurantType;
  @override
  final String phone;
  @override
  final int numberOfTables;
  @override
  final int numberOfEmployees;
  @override
  final String city;
  @override
  final String? phoneNumber;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? comments;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, restaurantName: $restaurantName, restaurantType: $restaurantType, phone: $phone, numberOfTables: $numberOfTables, numberOfEmployees: $numberOfEmployees, city: $city, phoneNumber: $phoneNumber, createdAt: $createdAt, updatedAt: $updatedAt, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.restaurantName, restaurantName) ||
                other.restaurantName == restaurantName) &&
            (identical(other.restaurantType, restaurantType) ||
                other.restaurantType == restaurantType) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.numberOfTables, numberOfTables) ||
                other.numberOfTables == numberOfTables) &&
            (identical(other.numberOfEmployees, numberOfEmployees) ||
                other.numberOfEmployees == numberOfEmployees) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    restaurantName,
    restaurantType,
    phone,
    numberOfTables,
    numberOfEmployees,
    city,
    phoneNumber,
    createdAt,
    updatedAt,
    comments,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final int id,
    required final String name,
    required final String email,
    required final String restaurantName,
    required final RestaurantType restaurantType,
    required final String phone,
    required final int numberOfTables,
    required final int numberOfEmployees,
    required final String city,
    final String? phoneNumber,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final String? comments,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get restaurantName;
  @override
  RestaurantType get restaurantType;
  @override
  String get phone;
  @override
  int get numberOfTables;
  @override
  int get numberOfEmployees;
  @override
  String get city;
  @override
  String? get phoneNumber;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get comments;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
