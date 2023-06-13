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
                              Container(
                                height: 119,
                                // width: 109,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
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
}
