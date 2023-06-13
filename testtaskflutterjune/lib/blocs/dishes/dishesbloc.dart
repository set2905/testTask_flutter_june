import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:testtaskflutterjune/repositories/dishespagerepository.dart';
import 'package:testtaskflutterjune/repositories/models/dish.dart';

import '../../repositories/models/dishpagedata.dart';
import 'dishesevent.dart';
import 'dishesstate.dart';

class DishesBloc extends Bloc<DishesEvent, DishesState> {
  final DishesPageRepository dishesPageRepository;

  DishesBloc({required this.dishesPageRepository})
      : super(const DishesPageLoading(0)) {
    on<DishesOpenedEvent>((event, emit) async {
      var data = await _getDishesPageData(event.selectedTagIndex);
      emit(DishesPageLoaded(data, event.selectedTagIndex));
    }, transformer: restartable());
  }

  Future<DishPageData> _getDishesPageData(int selectedTagIndex) async {
    List<Dish> data = List.from(dishesPageRepository.data.dishes);
    if (data.isEmpty == true) {
      await dishesPageRepository.fetchData();
      data = dishesPageRepository.data.dishes;
    }
    List<String> tags = dishesPageRepository.getAllTags();
    if (selectedTagIndex < tags.length) {
      data = data
          .where((x) => x.tags.contains(tags[selectedTagIndex]))
          .toList();
    }
    return DishPageData(data, tags);
  }
}
