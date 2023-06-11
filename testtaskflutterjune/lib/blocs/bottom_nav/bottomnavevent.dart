import 'package:equatable/equatable.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent({required this.index});
  final int index;
    @override
  List<Object?> get props => [index];
}

class PageTapped extends BottomNavEvent {
  const PageTapped({required super.index});
  @override
  String toString() => 'PageTapped: $index';
}

class AppStarted extends BottomNavEvent {
  const AppStarted({required super.index});

  @override
  String toString() => 'AppStarted';

}
