import 'package:equatable/equatable.dart';
import 'package:testtaskflutterjune/repositories/models/cartentry.dart';
import 'package:testtaskflutterjune/repositories/models/dish.dart';

abstract class CartEvent extends Equatable {
  final CartEntry cartEntry;
  const CartEvent(this.cartEntry);

    @override
  List<Object?> get props => [cartEntry];
}

class CartEntryCountChangeEvent extends CartEvent{
  const CartEntryCountChangeEvent(super.cartEntry, this.change);
  final int change;
}

class CartEntryRemovedEvent extends CartEvent{
  const CartEntryRemovedEvent(super.cartEntry);

}