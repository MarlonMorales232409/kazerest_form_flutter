// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserAnswer _$UserAnswerFromJson(Map<String, dynamic> json) {
  return _UserAnswer.fromJson(json);
}

/// @nodoc
mixin _$UserAnswer {
  List<Map<String, dynamic>> get interestedModules =>
      throw _privateConstructorUsedError;
  Map<String, Map<String, dynamic>> get priorityModules =>
      throw _privateConstructorUsedError;
  List<UserInterest> get userInterests => throw _privateConstructorUsedError;
  List<CategoryImportance> get categoryImportance =>
      throw _privateConstructorUsedError;
  String? get comments =>
      throw _privateConstructorUsedError; // User contact information
  String? get userName => throw _privateConstructorUsedError;
  String? get userEmail => throw _privateConstructorUsedError;
  String? get userPhone => throw _privateConstructorUsedError;
  String? get businessName => throw _privateConstructorUsedError;
  String? get userRole => throw _privateConstructorUsedError;

  /// Serializes this UserAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAnswerCopyWith<UserAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAnswerCopyWith<$Res> {
  factory $UserAnswerCopyWith(
    UserAnswer value,
    $Res Function(UserAnswer) then,
  ) = _$UserAnswerCopyWithImpl<$Res, UserAnswer>;
  @useResult
  $Res call({
    List<Map<String, dynamic>> interestedModules,
    Map<String, Map<String, dynamic>> priorityModules,
    List<UserInterest> userInterests,
    List<CategoryImportance> categoryImportance,
    String? comments,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? businessName,
    String? userRole,
  });
}

/// @nodoc
class _$UserAnswerCopyWithImpl<$Res, $Val extends UserAnswer>
    implements $UserAnswerCopyWith<$Res> {
  _$UserAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interestedModules = null,
    Object? priorityModules = null,
    Object? userInterests = null,
    Object? categoryImportance = null,
    Object? comments = freezed,
    Object? userName = freezed,
    Object? userEmail = freezed,
    Object? userPhone = freezed,
    Object? businessName = freezed,
    Object? userRole = freezed,
  }) {
    return _then(
      _value.copyWith(
            interestedModules: null == interestedModules
                ? _value.interestedModules
                : interestedModules // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            priorityModules: null == priorityModules
                ? _value.priorityModules
                : priorityModules // ignore: cast_nullable_to_non_nullable
                      as Map<String, Map<String, dynamic>>,
            userInterests: null == userInterests
                ? _value.userInterests
                : userInterests // ignore: cast_nullable_to_non_nullable
                      as List<UserInterest>,
            categoryImportance: null == categoryImportance
                ? _value.categoryImportance
                : categoryImportance // ignore: cast_nullable_to_non_nullable
                      as List<CategoryImportance>,
            comments: freezed == comments
                ? _value.comments
                : comments // ignore: cast_nullable_to_non_nullable
                      as String?,
            userName: freezed == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String?,
            userEmail: freezed == userEmail
                ? _value.userEmail
                : userEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            userPhone: freezed == userPhone
                ? _value.userPhone
                : userPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessName: freezed == businessName
                ? _value.businessName
                : businessName // ignore: cast_nullable_to_non_nullable
                      as String?,
            userRole: freezed == userRole
                ? _value.userRole
                : userRole // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserAnswerImplCopyWith<$Res>
    implements $UserAnswerCopyWith<$Res> {
  factory _$$UserAnswerImplCopyWith(
    _$UserAnswerImpl value,
    $Res Function(_$UserAnswerImpl) then,
  ) = __$$UserAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Map<String, dynamic>> interestedModules,
    Map<String, Map<String, dynamic>> priorityModules,
    List<UserInterest> userInterests,
    List<CategoryImportance> categoryImportance,
    String? comments,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? businessName,
    String? userRole,
  });
}

/// @nodoc
class __$$UserAnswerImplCopyWithImpl<$Res>
    extends _$UserAnswerCopyWithImpl<$Res, _$UserAnswerImpl>
    implements _$$UserAnswerImplCopyWith<$Res> {
  __$$UserAnswerImplCopyWithImpl(
    _$UserAnswerImpl _value,
    $Res Function(_$UserAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interestedModules = null,
    Object? priorityModules = null,
    Object? userInterests = null,
    Object? categoryImportance = null,
    Object? comments = freezed,
    Object? userName = freezed,
    Object? userEmail = freezed,
    Object? userPhone = freezed,
    Object? businessName = freezed,
    Object? userRole = freezed,
  }) {
    return _then(
      _$UserAnswerImpl(
        interestedModules: null == interestedModules
            ? _value._interestedModules
            : interestedModules // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        priorityModules: null == priorityModules
            ? _value._priorityModules
            : priorityModules // ignore: cast_nullable_to_non_nullable
                  as Map<String, Map<String, dynamic>>,
        userInterests: null == userInterests
            ? _value._userInterests
            : userInterests // ignore: cast_nullable_to_non_nullable
                  as List<UserInterest>,
        categoryImportance: null == categoryImportance
            ? _value._categoryImportance
            : categoryImportance // ignore: cast_nullable_to_non_nullable
                  as List<CategoryImportance>,
        comments: freezed == comments
            ? _value.comments
            : comments // ignore: cast_nullable_to_non_nullable
                  as String?,
        userName: freezed == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        userEmail: freezed == userEmail
            ? _value.userEmail
            : userEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        userPhone: freezed == userPhone
            ? _value.userPhone
            : userPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessName: freezed == businessName
            ? _value.businessName
            : businessName // ignore: cast_nullable_to_non_nullable
                  as String?,
        userRole: freezed == userRole
            ? _value.userRole
            : userRole // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAnswerImpl implements _UserAnswer {
  const _$UserAnswerImpl({
    required final List<Map<String, dynamic>> interestedModules,
    required final Map<String, Map<String, dynamic>> priorityModules,
    required final List<UserInterest> userInterests,
    required final List<CategoryImportance> categoryImportance,
    this.comments,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.businessName,
    this.userRole,
  }) : _interestedModules = interestedModules,
       _priorityModules = priorityModules,
       _userInterests = userInterests,
       _categoryImportance = categoryImportance;

  factory _$UserAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAnswerImplFromJson(json);

  final List<Map<String, dynamic>> _interestedModules;
  @override
  List<Map<String, dynamic>> get interestedModules {
    if (_interestedModules is EqualUnmodifiableListView)
      return _interestedModules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interestedModules);
  }

  final Map<String, Map<String, dynamic>> _priorityModules;
  @override
  Map<String, Map<String, dynamic>> get priorityModules {
    if (_priorityModules is EqualUnmodifiableMapView) return _priorityModules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_priorityModules);
  }

  final List<UserInterest> _userInterests;
  @override
  List<UserInterest> get userInterests {
    if (_userInterests is EqualUnmodifiableListView) return _userInterests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userInterests);
  }

  final List<CategoryImportance> _categoryImportance;
  @override
  List<CategoryImportance> get categoryImportance {
    if (_categoryImportance is EqualUnmodifiableListView)
      return _categoryImportance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryImportance);
  }

  @override
  final String? comments;
  // User contact information
  @override
  final String? userName;
  @override
  final String? userEmail;
  @override
  final String? userPhone;
  @override
  final String? businessName;
  @override
  final String? userRole;

  @override
  String toString() {
    return 'UserAnswer(interestedModules: $interestedModules, priorityModules: $priorityModules, userInterests: $userInterests, categoryImportance: $categoryImportance, comments: $comments, userName: $userName, userEmail: $userEmail, userPhone: $userPhone, businessName: $businessName, userRole: $userRole)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAnswerImpl &&
            const DeepCollectionEquality().equals(
              other._interestedModules,
              _interestedModules,
            ) &&
            const DeepCollectionEquality().equals(
              other._priorityModules,
              _priorityModules,
            ) &&
            const DeepCollectionEquality().equals(
              other._userInterests,
              _userInterests,
            ) &&
            const DeepCollectionEquality().equals(
              other._categoryImportance,
              _categoryImportance,
            ) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.userRole, userRole) ||
                other.userRole == userRole));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_interestedModules),
    const DeepCollectionEquality().hash(_priorityModules),
    const DeepCollectionEquality().hash(_userInterests),
    const DeepCollectionEquality().hash(_categoryImportance),
    comments,
    userName,
    userEmail,
    userPhone,
    businessName,
    userRole,
  );

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      __$$UserAnswerImplCopyWithImpl<_$UserAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAnswerImplToJson(this);
  }
}

abstract class _UserAnswer implements UserAnswer {
  const factory _UserAnswer({
    required final List<Map<String, dynamic>> interestedModules,
    required final Map<String, Map<String, dynamic>> priorityModules,
    required final List<UserInterest> userInterests,
    required final List<CategoryImportance> categoryImportance,
    final String? comments,
    final String? userName,
    final String? userEmail,
    final String? userPhone,
    final String? businessName,
    final String? userRole,
  }) = _$UserAnswerImpl;

  factory _UserAnswer.fromJson(Map<String, dynamic> json) =
      _$UserAnswerImpl.fromJson;

  @override
  List<Map<String, dynamic>> get interestedModules;
  @override
  Map<String, Map<String, dynamic>> get priorityModules;
  @override
  List<UserInterest> get userInterests;
  @override
  List<CategoryImportance> get categoryImportance;
  @override
  String? get comments; // User contact information
  @override
  String? get userName;
  @override
  String? get userEmail;
  @override
  String? get userPhone;
  @override
  String? get businessName;
  @override
  String? get userRole;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
