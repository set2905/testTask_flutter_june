// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dish _$DishFromJson(Map<String, dynamic> json) => Dish(
      json['id'] as int,
      json['name'] as String,
      json['image_url'] as String?,
      json['price'] as int,
      json['weight'] as int,
      json['description'] as String,
      (json['tegs'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageurl,
      'description': instance.description,
      'tegs': instance.tags,
      'price': instance.price,
      'weight': instance.weight,
    };

DishesResponse _$DishesResponseFromJson(Map<String, dynamic> json) =>
    DishesResponse(
      (json['dishes'] as List<dynamic>)
          .map((e) => Dish.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DishesResponseToJson(DishesResponse instance) =>
    <String, dynamic>{
      'dishes': instance.dishes,
    };
