// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAnswerImpl _$$UserAnswerImplFromJson(Map<String, dynamic> json) =>
    _$UserAnswerImpl(
      interestedModules: (json['interestedModules'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      priorityModules: (json['priorityModules'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as Map<String, dynamic>),
      ),
      userInterests: (json['userInterests'] as List<dynamic>)
          .map((e) => UserInterest.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryImportance: (json['categoryImportance'] as List<dynamic>)
          .map((e) => CategoryImportance.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: json['comments'] as String?,
      userName: json['userName'] as String?,
      userEmail: json['userEmail'] as String?,
      userPhone: json['userPhone'] as String?,
      businessName: json['businessName'] as String?,
      userRole: json['userRole'] as String?,
    );

Map<String, dynamic> _$$UserAnswerImplToJson(_$UserAnswerImpl instance) =>
    <String, dynamic>{
      'interestedModules': instance.interestedModules,
      'priorityModules': instance.priorityModules,
      'userInterests': instance.userInterests,
      'categoryImportance': instance.categoryImportance,
      'comments': instance.comments,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userPhone': instance.userPhone,
      'businessName': instance.businessName,
      'userRole': instance.userRole,
    };
