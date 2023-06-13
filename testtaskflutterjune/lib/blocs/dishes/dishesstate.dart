import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../repositories/models/dishpagedata.dart';

@immutable
abstract class DishesState extends Equatable {
  final int selectedTagIndex;
  const DishesState(this.selectedTagIndex);
  @override
  List<Object?> get props => [selectedTagIndex];
}

class DishesPageLoaded extends DishesState {
  const DishesPageLoaded(this.data, super.selectedTagIndex);
  final DishPageData data;
  @override
  String toString() => 'DishesPageLoading';
}

class DishesPageLoading extends DishesState {
  const DishesPageLoading(super.selectedTagIndex);

  @override
  String toString() => 'DishesPageLoading';
}
