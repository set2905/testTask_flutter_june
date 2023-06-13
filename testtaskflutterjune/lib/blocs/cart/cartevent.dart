import 'package:equatable/equatable.dart';
import 'package:testtaskflutterjune/repositories/models/cartentry.dart';
import 'package:testtaskflutterjune/repositories/models/dish.dart';

abstract class CartEvent extends Equatable {
  final Dish dish;
  const CartEvent(this.dish);

    @override
  List<Object?> get props => [dish];
}

class CartEntryCountChangeEvent extends CartEvent{
  const CartEntryCountChangeEvent(super.dish, this.change);
  final int change;
}
class CartEntryAddedEvent extends CartEvent{
  const CartEntryAddedEvent(super.dish);
}
class CartEntryRemovedEvent extends CartEvent{
  const CartEntryRemovedEvent(super.dish);

}