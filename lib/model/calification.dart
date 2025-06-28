import 'package:freezed_annotation/freezed_annotation.dart';

part 'calification.freezed.dart';
part 'calification.g.dart';

@freezed
abstract class Calification with _$Calification {
  const factory Calification({
    required String id,
    required String name,
    required int maxValue,
  }) = _Calification;

  factory Calification.fromJson(Map<String, dynamic> json) => _$CalificationFromJson(json);
}