import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../repositories/models/dish.dart';

class DishInfoWidget extends StatelessWidget {
  final Dish dish;
  final TextStyle nameStyle;
  final TextStyle priceAndWeightStyle;
  const DishInfoWidget({
    Key? key,
    required this.dish,
    required this.nameStyle,
    required this.priceAndWeightStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              overflow: TextOverflow.clip,
              dish.name,
              style: nameStyle,
            ),
          )),
      Row(
        children: [
          Text(
            "${dish.price} ₽",
            style: priceAndWeightStyle.apply(
                color: Theme.of(context).colorScheme.onSurface),
          ),
          Text(" · ${dish.weight}г",
              style: priceAndWeightStyle.apply(
                  color: Theme.of(context).colorScheme.onSecondary))
        ],
      ),
    ]);
  }
}