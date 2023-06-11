import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:testtaskflutterjune/repositories/models/category.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://run.mocky.io/v3/")
abstract class Api {
  
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @GET("/058729bd-1402-4578-88de-265481fd7d54")
  Future<CategoriesResponse> getCategories();
}