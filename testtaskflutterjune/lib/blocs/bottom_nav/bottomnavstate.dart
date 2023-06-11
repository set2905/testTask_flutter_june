import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/models/category.dart';

@immutable
abstract class BottomNavState extends Equatable {
// final String text;

  const BottomNavState();

  @override
  List<Object?> get props => [];
}

class CurrentIndexChanged extends BottomNavState {
  final int currentIndex;
  const CurrentIndexChanged(this.currentIndex);

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';

}

class PageLoading extends BottomNavState {
  const PageLoading();

  @override
  String toString() => 'PageLoading';

}

class MainPageLoaded extends BottomNavState {
  const MainPageLoaded(this.categories);
 final List<Category> categories;
  @override
  String toString() => 'FirstPageLoaded';
}

class CartPageLoaded extends BottomNavState {
  const CartPageLoaded();

  @override
  String toString() => 'CategoryPageLoaded';
}
