// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAnswerImpl _$$UserAnswerImplFromJson(Map<String, dynamic> json) =>
    _$UserAnswerImpl(
      interestedModules: (json['interestedModules'] as List<dynamic>)
          .map((e) => SystemModule.fromJson(e as Map<String, dynamic>))
          .toList(),
      priorityModules: (json['priorityModules'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SystemModule.fromJson(e as Map<String, dynamic>)),
      ),
      userInterests: (json['userInterests'] as List<dynamic>)
          .map((e) => UserInterest.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryImportance: (json['categoryImportance'] as List<dynamic>)
          .map((e) => CategoryImportance.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: json['comments'] as String?,
    );

Map<String, dynamic> _$$UserAnswerImplToJson(_$UserAnswerImpl instance) =>
    <String, dynamic>{
      'interestedModules': instance.interestedModules,
      'priorityModules': instance.priorityModules,
      'userInterests': instance.userInterests,
      'categoryImportance': instance.categoryImportance,
      'comments': instance.comments,
    };
