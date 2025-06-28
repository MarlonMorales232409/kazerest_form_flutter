import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kazerest_form/model/enums.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
    required String email,
    required String restaurantName,
    required RestaurantType restaurantType,
    required String phone,
    required int numberOfTables,
    required int numberOfEmployees,
    required String city,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? comments,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}