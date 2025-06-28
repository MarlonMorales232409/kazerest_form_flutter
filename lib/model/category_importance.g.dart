// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_importance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImportanceImpl _$$CategoryImportanceImplFromJson(
  Map<String, dynamic> json,
) => _$CategoryImportanceImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  value: (json['value'] as num).toInt(),
  maxValue: (json['maxValue'] as num).toInt(),
);

Map<String, dynamic> _$$CategoryImportanceImplToJson(
  _$CategoryImportanceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'value': instance.value,
  'maxValue': instance.maxValue,
};
