import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtaskflutterjune/blocs/dishes/dishesbloc.dart';
import 'package:testtaskflutterjune/repositories/dishespagerepository.dart';
import 'package:testtaskflutterjune/repositories/models/dish.dart';
import 'package:testtaskflutterjune/ui/widgets/dishesList.dart';

import '../../blocs/dishes/dishesevent.dart';

class DishesPage extends StatelessWidget {
  const DishesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: BlocProvider<DishesBloc>(
          create: (context) => DishesBloc(
            dishesPageRepository: DishesPageRepository(),
          )..add(const DishesOpenedEvent(0)),
          child: const DishesList(),
        ));
  }
}
