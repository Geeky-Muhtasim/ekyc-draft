import 'package:flutter_bloc/flutter_bloc.dart';
import 'additional_info_event.dart';
import 'additional_info_state.dart';

class AdditionalInfoBloc extends Bloc<AdditionalInfoEvent, AdditionalInfoState> {
  AdditionalInfoBloc() : super(AdditionalInfoState()) {
    on<UpdateGender>((event, emit) => emit(state.copyWith(gender: event.gender)));
    on<UpdatePurpose>((event, emit) => emit(state.copyWith(purpose: event.purpose)));
    on<UpdateOccupation>((event, emit) => emit(state.copyWith(occupation: event.occupation)));
    on<UpdateDropdown>((event, emit) {
      switch (event.field) {
        case 'country':
          emit(state.copyWith(selectedCountry: event.value));        
        case 'division':
          emit(state.copyWith(selectedDivision: event.value));       
        case 'district':
          emit(state.copyWith(selectedDistrict: event.value));
        case 'thana':
          emit(state.copyWith(selectedThana: event.value));          
        case 'city':
          emit(state.copyWith(selectedCity: event.value)); 
        case 'netWorth': 
          emit(state.copyWith(selectedNetWorth: event.value));
          break;
      }
    });
  }
}

