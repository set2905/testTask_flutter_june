import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:testtaskflutterjune/repositories/cartpagerepository.dart';
import 'package:testtaskflutterjune/repositories/models/category.dart';

import '../../repositories/mainpagerepository.dart';
import 'bottomnavevent.dart';
import 'bottomnavstate.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  final MainPageRepository firstPageRepository;
  final CartPageRepository secondPageRepository;
  int currentIndex = 0;

  BottomNavBloc(
      {required this.firstPageRepository, required this.secondPageRepository})
      : super(const PageLoading()) {
    on<AppStarted>((event, emit) => add(PageTapped(index: currentIndex)));
    on<PageTapped>((event, emit) async {
      currentIndex = event.index;
      emit(CurrentIndexChanged(currentIndex));
      if (event.index == 0) {
        var data = await _getMainPageData();
        emit(MainPageLoaded(data.categories));
      }
      if (event.index == 2) {
        emit(const CartPageLoaded());
      }
      //currentIndex = event.index;
    }, transformer: restartable());
  }

  Future<CategoriesResponse> _getMainPageData() async {
    var data = firstPageRepository.data;
    if (data.categories.isEmpty == true) {
      await firstPageRepository.fetchData();
      data = firstPageRepository.data;
    }
    return data;
  }
}
