import 'package:dio/dio.dart';
import 'package:testtaskflutterjune/repositories/models/category.dart';

import 'api/api.dart';

class MainPageRepository {
 CategoriesResponse _data = CategoriesResponse([]);

  Future<void> fetchData() async {
    final dio = Dio();
    final client = Api(dio);
    _data = await client.getCategories();
  }

 CategoriesResponse get data => _data;
}
