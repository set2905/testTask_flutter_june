import 'package:flutter/material.dart';

import '../../repositories/models/category.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.categories});
  final List<Category> categories;
  @override
  Widget build(BuildContext context) {
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
                      debugPrint('Card tapped.');
                    },
                    child: Container(
                      width: 381,
                      height: 164,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(categories[index].image_url),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 0, 0),
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
