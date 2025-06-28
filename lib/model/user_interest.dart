
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_interest.freezed.dart';
part 'user_interest.g.dart';

@freezed
abstract class UserInterest with _$UserInterest {
  const factory UserInterest({
    String? id,
    required String title,
    required int maxLevel,
    required int userLevel,
  }) = _UserInterest;

  factory UserInterest.fromJson(Map<String, dynamic> json) =>
      _$UserInterestFromJson(json);
}