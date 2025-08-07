// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'home_event.dart';
// import 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   // String? selectedServiceTypeId;

//   HomeBloc() : super(HomeInitialState()) {
//     on<LoadHomeMenuEvent>((event, emit) async {
//       emit(HomeLoadingState());

//       try {
//         await Future.delayed(const Duration(milliseconds: 500));

//         final menuItems = [
//           HomeMenuItem(key: 'Islamic', title: 'Islamic', icon: Icons.mosque),
//           HomeMenuItem(
//             key: 'Conventional',
//             title: 'Conventional',
//             icon: Icons.account_balance,
//           ),
//         ];

//         emit(HomeLoadedState(menuItems: menuItems));
//       } catch (e) {
//         emit(HomeErrorState(message: 'Failed to load categories'));
//       }
//     });
//     // on<SaveServiceTypeEvent>((event, emit) {
//     //   selectedServiceTypeId = event.serviceTypeId;
//     //   emit(HomeSelectedState(selectedServiceTypeId: event.serviceTypeId));
//     // });

//     on<SaveServiceTypeEvent>((event, emit) {
//       // selectedServiceTypeId = event.serviceTypeId;
//       // print('🔍 Saved Service Type ID: $selectedServiceTypeId'); // 👈

//       emit(HomeSelectedState(selectedServiceTypeId: event.serviceTypeId!));
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
    on<LoadHomeMenuEvent>((event, emit) async {
      emit(HomeLoadingState());

      try {
        await Future.delayed(const Duration(milliseconds: 500));

        final menuItems = [
          HomeMenuItem(key: 'Islamic', title: 'Islamic', icon: Icons.mosque),
          HomeMenuItem(key: 'Conventional', title: 'Conventional', icon: Icons.account_balance),
        ];

        emit(HomeLoadedState(menuItems: menuItems));
      } catch (e) {
        emit(HomeErrorState(message: 'Failed to load categories'));
      }
    });

    on<SaveServiceTypeEvent>((event, emit) {
      ProductSelectionState().setServiceTypeId(event.serviceTypeId);
      emit(HomeSelectedState(selectedServiceTypeId: event.serviceTypeId));
    });
  }
}