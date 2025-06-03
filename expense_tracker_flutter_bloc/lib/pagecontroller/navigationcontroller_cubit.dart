import 'package:bloc/bloc.dart';

import 'navigationcontroller_state.dart';

class NavigationcontrollerCubit extends Cubit<NavigationcontrollerState> {
  NavigationcontrollerCubit()
    : super(NavigationcontrollerInitial(pageIndex: 0));

  void changePageNumber(int pageIndex) {
    switch (pageIndex) {
      case 0:
        emit(NavigationcontrollerUpdate(pageIndex));

        break;
      case 1:
        emit(NavigationcontrollerUpdate(pageIndex));
        break;
    }
  }
}
