
import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_module.freezed.dart';
part 'system_module.g.dart';

@freezed
abstract class SystemModule with _$SystemModule {
  const factory SystemModule({
    required String id,
    required String title,
    required String description,
  }) = _SystemModule;

  factory SystemModule.fromJson(Map<String, dynamic> json) =>
      _$SystemModuleFromJson(json);

}