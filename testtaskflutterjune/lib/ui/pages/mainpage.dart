import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtaskflutterjune/ui/pages/dishespage.dart';

import '../../blocs/bottom_nav/bottomnavbloc.dart';
import '../../repositories/models/category.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.categories});
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final BottomNavBloc bottomNavigationBloc =
        BlocProvider.of<BottomNavBloc>(context);
    return Scaffold(
      body: Center(
          child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DishesPage(
                                  bottomNavigationBloc: bottomNavigationBloc)));
                    },
                    child: Container(
                      width: 381,
                      height: 164,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(categories[index].imageurl),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 150, 0),
                        child: Text(
                          categories[index].name,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
