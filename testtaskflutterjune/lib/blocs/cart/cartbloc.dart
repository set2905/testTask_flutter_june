import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtaskflutterjune/blocs/cart/cartevent.dart';
import 'package:testtaskflutterjune/blocs/cart/cartstate.dart';
import 'package:testtaskflutterjune/repositories/models/cartentry.dart';
import 'package:testtaskflutterjune/repositories/models/dish.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartEntry> currentCartItems = [];
  CartBloc() : super(CartEmptyState()) {
    on<CartEntryCountChangeEvent>((event, emit) async {
      if (currentCartItems.contains(event.cartEntry)) {
        currentCartItems
            .firstWhere((element) => element == event.cartEntry)
            .count += event.change;
      }

      emit(CartWithItemsState(currentCartItems, _getTotal()));
    });

    on<CartEntryRemovedEvent>((event, emit) async {
      if (currentCartItems.contains(event.cartEntry)) {
        currentCartItems.remove(event.cartEntry);
      }
      emit(CartWithItemsState(currentCartItems, _getTotal()));
    });
  }

  int _getTotal() {
    int total = 0;
    for (var element in currentCartItems) {
      total += element.count * element.dish.price;
    }
    return total;
  }
}
