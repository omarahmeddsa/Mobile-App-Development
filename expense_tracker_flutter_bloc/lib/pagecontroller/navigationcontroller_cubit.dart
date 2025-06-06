import 'package:bloc/bloc.dart';

import 'navigationcontroller_state.dart';

class NavigationcontrollerCubit extends Cubit<NavigationcontrollerState> {
  NavigationcontrollerCubit()
    : super(NavigationcontrollerInitial(pageIndex: 0));

  void changePageNumber(int pageIndex) {
    emit(NavigationcontrollerUpdate(pageIndex));
  }
}
