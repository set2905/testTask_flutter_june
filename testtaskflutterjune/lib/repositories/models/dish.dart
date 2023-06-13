import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable()
class Dish extends Equatable {
  int id;
  String name;
  @JsonKey(name: "image_url")
  String? imageurl;
  String description;
  @JsonKey(name: "tegs")
  List<String> tags;
  int price;
  int weight;
  Dish(this.id, this.name, this.imageurl, this.price, this.weight, this.description, this.tags);

  factory Dish.fromJson(Map<String, dynamic> json) =>
      _$DishFromJson(json);
  Map<String, dynamic> toJson() => _$DishToJson(this);
  
  @override
  List<Object?> get props => [id];
}


@JsonSerializable()
class DishesResponse {
  @JsonKey(name: "dishes")
  List<Dish> dishes;
  DishesResponse(this.dishes);

  factory DishesResponse.fromJson(Map<String, dynamic> json) =>
      _$DishesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DishesResponseToJson(this);
}