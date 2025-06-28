// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_interest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInterestImpl _$$UserInterestImplFromJson(Map<String, dynamic> json) =>
    _$UserInterestImpl(
      id: json['id'] as String?,
      title: json['title'] as String,
      maxLevel: (json['maxLevel'] as num).toInt(),
      userLevel: (json['userLevel'] as num).toInt(),
    );

Map<String, dynamic> _$$UserInterestImplToJson(_$UserInterestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'maxLevel': instance.maxLevel,
      'userLevel': instance.userLevel,
    };
