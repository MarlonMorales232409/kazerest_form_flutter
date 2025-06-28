// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalificationImpl _$$CalificationImplFromJson(Map<String, dynamic> json) =>
    _$CalificationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      maxValue: (json['maxValue'] as num).toInt(),
    );

Map<String, dynamic> _$$CalificationImplToJson(_$CalificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'maxValue': instance.maxValue,
    };
