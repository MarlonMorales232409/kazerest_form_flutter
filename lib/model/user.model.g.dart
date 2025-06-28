// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      restaurantName: json['restaurantName'] as String,
      restaurantType: $enumDecode(
        _$RestaurantTypeEnumMap,
        json['restaurantType'],
      ),
      phone: json['phone'] as String,
      numberOfTables: (json['numberOfTables'] as num).toInt(),
      numberOfEmployees: (json['numberOfEmployees'] as num).toInt(),
      city: json['city'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      comments: json['comments'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'restaurantName': instance.restaurantName,
      'restaurantType': _$RestaurantTypeEnumMap[instance.restaurantType]!,
      'phone': instance.phone,
      'numberOfTables': instance.numberOfTables,
      'numberOfEmployees': instance.numberOfEmployees,
      'city': instance.city,
      'phoneNumber': instance.phoneNumber,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'comments': instance.comments,
    };

const _$RestaurantTypeEnumMap = {
  RestaurantType.fastFood: 'fastFood',
  RestaurantType.casualDining: 'casualDining',
  RestaurantType.fineDining: 'fineDining',
  RestaurantType.cafe: 'cafe',
  RestaurantType.foodTruck: 'foodTruck',
  RestaurantType.buffet: 'buffet',
  RestaurantType.pub: 'pub',
  RestaurantType.bar: 'bar',
  RestaurantType.bakery: 'bakery',
  RestaurantType.pizzeria: 'pizzeria',
  RestaurantType.other: 'other',
};
