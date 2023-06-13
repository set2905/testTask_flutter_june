import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:testtaskflutterjune/repositories/models/cartentry.dart';

@immutable
abstract class CartState extends Equatable {
  final List<CartEntry> entries;
  const CartState(this.entries);
  @override
  List<Object?> get props => [entries];
}

class CartWithItemsState extends CartState {
  const CartWithItemsState(super.entries, this.total);
  final int total;
}

class CartEmptyState extends CartState {
  CartEmptyState() : super([]);
}
