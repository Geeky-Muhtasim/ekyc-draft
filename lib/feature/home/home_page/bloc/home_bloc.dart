// import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'home_event.dart';
// import 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(HomeInitialState()) {
//     on<LoadHomeMenuEvent>((event, emit) async {
//       emit(HomeLoadingState());

//       try {
//         await Future.delayed(const Duration(milliseconds: 500));

//         final menuItems = [
//           HomeMenuItem(key: 'Islamic', title: 'Islamic', icon: Icons.mosque),
//           HomeMenuItem(key: 'Conventional', title: 'Conventional', icon: Icons.account_balance),
//         ];

//         emit(HomeLoadedState(menuItems: menuItems));
//       } catch (e) {
//         emit(HomeErrorState(message: 'Failed to load categories'));
//       }
//     });

//     on<SaveServiceTypeEvent>((event, emit) {
//       ProductSelectionState().setServiceTypeId(event.serviceTypeId);
//       emit(HomeSelectedState(selectedServiceTypeId: event.serviceTypeId));
//     });
//   }
// }
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<LoadHomeMenuEvent>(_onLoadMenu);
    on<SaveServiceTypeEvent>(_onSaveServiceType);
  }

  Future<void> _onLoadMenu(
    LoadHomeMenuEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      // Start a brand-new product journey on Home
      ProductSelectionState().reset();

      await Future.delayed(const Duration(milliseconds: 300));

      final menuItems = [
        HomeMenuItem(key: 'Islamic', title: 'Islamic', icon: Icons.mosque),
        HomeMenuItem(key: 'Conventional', title: 'Conventional', icon: Icons.account_balance),
      ];

      emit(HomeLoadedState(menuItems: menuItems));
    } catch (e) {
      emit(HomeErrorState(message: 'Failed to load categories'));
    }
  }

  void _onSaveServiceType(
    SaveServiceTypeEvent event,
    Emitter<HomeState> emit,
  ) {
    // Persist immediately in our global singleton
    ProductSelectionState().setServiceTypeId(event.serviceTypeId);
    debugPrint('[HomeBloc] ✅ Saved serviceTypeId=${event.serviceTypeId}');
    emit(HomeSelectedState(selectedServiceTypeId: event.serviceTypeId));
  }
}
