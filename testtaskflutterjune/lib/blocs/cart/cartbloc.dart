import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtaskflutterjune/blocs/cart/cartevent.dart';
import 'package:testtaskflutterjune/blocs/cart/cartstate.dart';
import 'package:testtaskflutterjune/repositories/models/cartentry.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartEntry> currentCartItems = [];
  CartBloc() : super(CartEmptyState()) {
    on<CartEntryCountChangeEvent>((event, emit) async {
      if (currentCartItems.map((e) => e.dish).contains(event.dish)) {
        var found = currentCartItems
            .firstWhere((element) => element.dish == event.dish);
        currentCartItems[currentCartItems.indexOf(found)] =
            CartEntry(found.dish, found.count + event.change);
      }
      emit(CartWithItemsState(currentCartItems, _getTotal()));
    });

    on<CartEntryRemovedEvent>((event, emit) {
      if (currentCartItems.map((e) => e.dish).contains(event.dish)) {
        currentCartItems.removeWhere((e) => e.dish == event.dish);
      }
      if (currentCartItems.isNotEmpty) {
        emit(CartWithItemsState(currentCartItems, _getTotal()));
      } else {
        emit(CartEmptyState());
      }
    });

    on<CartEntryAddedEvent>(((event, emit) {
      if (currentCartItems.map((e) => e.dish).contains(event.dish)) return;
      currentCartItems.add(CartEntry(event.dish, 1));
      emit(CartWithItemsState(currentCartItems, _getTotal()));
    }));
  }

  int _getTotal() {
    int total = 0;
    for (var element in currentCartItems) {
      total += element.count * element.dish.price;
    }
    return total;
  }
}
