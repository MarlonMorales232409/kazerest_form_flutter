

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_importance.freezed.dart';
part 'category_importance.g.dart';

@freezed
abstract class CategoryImportance with _$CategoryImportance {
  const factory CategoryImportance({
    required String id,
    required String name,
    required int value,
    required int maxValue,
  }) = _CategoryImportance;

  factory CategoryImportance.fromJson(Map<String, dynamic> json) =>
      _$CategoryImportanceFromJson(json);
}