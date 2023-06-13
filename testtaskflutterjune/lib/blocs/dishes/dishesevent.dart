import 'package:equatable/equatable.dart';

import '../../repositories/models/dish.dart';

abstract class DishesEvent extends Equatable {
  final int selectedTagIndex;
  //final List<Dish> dishes;
  const DishesEvent(this.selectedTagIndex);
}

class DishesOpenedEvent extends DishesEvent {
  const DishesOpenedEvent(super.selectedTagIndex);

  @override
  List<Object?> get props => [];
}
