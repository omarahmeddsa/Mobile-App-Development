import 'package:equatable/equatable.dart';

sealed class NavigationcontrollerState extends Equatable {
  final int pageNumber;

  NavigationcontrollerState(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

class NavigationcontrollerInitial extends NavigationcontrollerState {
  NavigationcontrollerInitial({required int pageIndex}) : super(0);
}

class NavigationcontrollerUpdate extends NavigationcontrollerState {
  NavigationcontrollerUpdate(super.pageNumber);
}
