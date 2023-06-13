import 'package:dio/dio.dart';
import 'package:testtaskflutterjune/repositories/models/category.dart';
import 'package:testtaskflutterjune/repositories/models/dish.dart';

import 'api/api.dart';

class DishesPageRepository {
  DishesResponse _data = DishesResponse([]);
  List<String> _tags = [];

  Future<void> fetchData() async {
    final dio = Dio();
    final client = Api(dio);
    _data = await client.getDishes();
  }

  List<String> getAllTags() {
    if (_tags.isNotEmpty) return _tags;
    if (_data.dishes.isEmpty) return [];
    Iterable<List<String>> result = _data.dishes.map((e) => e.tags);
    List<String> expanded = result.expand((e) => e).toList();
    _tags = expanded.toSet().toList();
    return _tags;
  }

  DishesResponse get data => _data;
  List<String> get tags => getAllTags();
}
