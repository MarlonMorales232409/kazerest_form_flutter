
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kazerest_form/model/category_importance.dart';
import 'package:kazerest_form/model/user_interest.dart';

part 'user_answer.freezed.dart';
part 'user_answer.g.dart';

@freezed
abstract class UserAnswer with _$UserAnswer {
  const factory UserAnswer({
    required List<Map<String, dynamic>> interestedModules,
    required Map<String, Map<String, dynamic>> priorityModules,
    required List<UserInterest> userInterests,
    required List<CategoryImportance> categoryImportance,
    String? comments,
    // User contact information
    String? userName,
    String? userEmail,
    String? userPhone,
    String? businessName,
    String? userRole,
  }) = _UserAnswer;

  factory UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerFromJson(json);

}