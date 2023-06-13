import 'package:equatable/equatable.dart';

import 'dish.dart';

class CartEntry extends Equatable{
  CartEntry(this.dish);
  int count = 0;
  final Dish dish;
  
  @override
  List<Object?> get props => [dish.id, count];
}
