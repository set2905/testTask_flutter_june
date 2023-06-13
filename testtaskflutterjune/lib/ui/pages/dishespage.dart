import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtaskflutterjune/blocs/cart/cartbloc.dart';
import 'package:testtaskflutterjune/blocs/dishes/dishesbloc.dart';
import 'package:testtaskflutterjune/repositories/dishespagerepository.dart';
import 'package:testtaskflutterjune/repositories/models/dish.dart';
import 'package:testtaskflutterjune/ui/widgets/dishesList.dart';

import '../../blocs/bottom_nav/bottomnavbloc.dart';
import '../../blocs/bottom_nav/bottomnavstate.dart';
import '../../blocs/dishes/dishesevent.dart';
import '../widgets/navbar.dart';

class DishesPage extends StatelessWidget {
  const DishesPage(
      {super.key, required this.bottomNavigationBloc, required this.cartBloc});
  final BottomNavBloc bottomNavigationBloc;
  final CartBloc cartBloc;
  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavBloc, BottomNavState>(
      bloc: bottomNavigationBloc,
      listener: (context, state) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              actions: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: 58,
                  child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png")),
                ),
              ],
              title: Center(
                child: Text("Азиатская кухня",
                    style: Theme.of(context).textTheme.headlineMedium),
              )),
          bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
              bloc: bottomNavigationBloc,
              builder: (BuildContext context, BottomNavState state) {
                return NavBar(bottomNavigationBloc: bottomNavigationBloc);
              }),
          body: BlocProvider<DishesBloc>(
            create: (context) => DishesBloc(
              dishesPageRepository: DishesPageRepository(),
            )..add(const DishesOpenedEvent(0)),
            child: DishesList(
              cartBloc: cartBloc,
            ),
          )),
    );
  }
}
