import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtaskflutterjune/blocs/cart/cartbloc.dart';
import 'package:testtaskflutterjune/blocs/cart/cartstate.dart';
import 'package:testtaskflutterjune/ui/widgets/dishinfowidget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.cartBloc});
  final CartBloc cartBloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
              child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: state.entries.length,
                    itemBuilder: (context, index) {
                      String url = state.entries[index].dish.imageurl == null
                          ? ""
                          : state.entries[index].dish.imageurl!;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: SizedBox(
                          height: 64,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Container(
                                  height: double.infinity,
                                  width: 62,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: url.isNotEmpty
                                        ? Image.network(url)
                                        : null,
                                  )),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8,0,0,0),
                                child: SizedBox(
                                  width: 109,
                                  child: DishInfoWidget(
                                    dish: state.entries[index].dish,
                                    nameStyle: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                    priceAndWeightStyle:
                                        Theme.of(context).textTheme.headlineSmall!,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              if (state is CartWithItemsState)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Оплатить ${state.total} ₽",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.apply(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                        ),
                      )),
                )
            ],
          )),
        );
      },
    );
  }
}
