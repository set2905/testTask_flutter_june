import 'dart:async';

import 'package:bloc/bloc.dart';
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
      emit(CurrentIndexChanged(event.index));
      if (currentIndex == 0) {
        var data = await _getMainPageData();
        emit(MainPageLoaded(data.categories));
      }
      if (currentIndex == 1) {
        String data = await _getCategoryPageData();
        emit(CartPageLoaded());
      }
    });
  }

  Future<CategoriesResponse> _getMainPageData() async {
    var data = firstPageRepository.data;
    await firstPageRepository.fetchData();
    data = firstPageRepository.data;
    return data;
  }

  Future<String> _getCategoryPageData() async {
    String data = secondPageRepository.data;
    await secondPageRepository.fetchData();
    data = secondPageRepository.data;
    return data;
  }
}
