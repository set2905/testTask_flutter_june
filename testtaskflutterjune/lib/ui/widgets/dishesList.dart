import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtaskflutterjune/blocs/dishes/dishesbloc.dart';
import 'package:testtaskflutterjune/blocs/dishes/dishesstate.dart';

import '../../blocs/dishes/dishesevent.dart';

class DishesList extends StatelessWidget {
  const DishesList({super.key});

  @override
  Widget build(BuildContext context) {
    final DishesBloc dishesBloc = BlocProvider.of<DishesBloc>(context);
    return BlocBuilder<DishesBloc, DishesState>(
      bloc: dishesBloc,
      builder: (BuildContext context, DishesState state) {
        if (state is DishesPageLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DishesPageLoaded) {
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: state.data.tags.length,
                  itemBuilder: (context, index) => TextButton(
                    child: Container(
                        width: 87,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: state.selectedTagIndex == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface),
                        child: Center(
                          child: Text(
                            state.data.tags[index],
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .apply(
                                    color: state.selectedTagIndex == index
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                          ),
                        )),
                    onPressed: () {
                      dishesBloc.add(DishesOpenedEvent(index));
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              childAspectRatio: 109 / 149,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: state.data.dishes.length,
                      itemBuilder: (BuildContext ctx, index) {
                        String url = state.data.dishes[index].imageurl == null
                            ? ""
                            : state.data.dishes[index].imageurl!;
                        return Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await _displayDishDialog(
                                      context, index, state);
                                },
                                child: Container(
                                  height: 119,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: url.isNotEmpty
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Image.network(
                                              url,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3.0, 0, 0, 0),
                                child: Text(
                                  overflow: TextOverflow.visible,
                                  state.data.dishes[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Future<void> _displayDishDialog(
      BuildContext context, int index, DishesPageLoaded state) async {
    return showDialog(
      context: context,
      builder: (context) {
        String url = state.data.dishes[index].imageurl == null
            ? ""
            : state.data.dishes[index].imageurl!;
        return AlertDialog(
           shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 311,
            height: 232,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10)),
            child: Stack(children: [Center(child: Image.network(url))]),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  state.data.dishes[index].name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              )),
          Row(
            children: [
              Text(
                "${state.data.dishes[index].price} ₽",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.apply(color: Theme.of(context).colorScheme.onSurface),
              ),
              Text(" · ${state.data.dishes[index].weight}г",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.apply(color: Theme.of(context).colorScheme.onSecondary))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              height: 62,
              child: Text(state.data.dishes[index].description,
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.clip),
            ),
          ),
          ElevatedButton(
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
                    "Добавить в корзину",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.apply(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ))
        ]));
      },
    );
  }
}
