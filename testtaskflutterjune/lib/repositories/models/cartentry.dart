import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'dish.dart';
@immutable
class CartEntry extends Equatable{
  const CartEntry(this.dish, this.count);
  final int count;
  final Dish dish;
  
  @override
  List<Object?> get props => [dish.id, count];
}
