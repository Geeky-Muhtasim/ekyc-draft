// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'additional_info_event.dart';
// import 'additional_info_state.dart';

// class AdditionalInfoBloc extends Bloc<AdditionalInfoEvent, AdditionalInfoState> {
//   AdditionalInfoBloc() : super(AdditionalInfoState()) {
//     on<UpdateGender>((event, emit) => emit(state.copyWith(gender: event.gender)));
//     on<UpdatePurpose>((event, emit) => emit(state.copyWith(purpose: event.purpose)));
//     on<UpdateOccupation>((event, emit) => emit(state.copyWith(occupation: event.occupation)));
//     on<UpdateDropdown>((event, emit) {
//       switch (event.field) {
//         case 'country':
//           emit(state.copyWith(selectedCountry: event.value));
//         case 'division':
//           emit(state.copyWith(selectedDivision: event.value));
//         case 'district':
//           emit(state.copyWith(selectedDistrict: event.value));
//         case 'thana':
//           emit(state.copyWith(selectedThana: event.value));
//         case 'city':
//           emit(state.copyWith(selectedCity: event.value));
//         case 'netWorth':
//           emit(state.copyWith(selectedNetWorth: event.value));
//           break;
//       }
//     });
//   }
// }

// import 'dart:convert';

// import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/bloc/additional_info_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/bloc/additional_info_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;

// class AdditionalInfoBloc extends Bloc<AdditionalInfoEvent, AdditionalInfoState> {
//   AdditionalInfoBloc() : super(AdditionalInfoState()) {
//     on<UpdateGender>((event, emit) => emit(state.copyWith(gender: event.gender)));
//     on<UpdatePurpose>((event, emit) => emit(state.copyWith(purpose: event.purpose)));
//     on<UpdateOccupation>((event, emit) => emit(state.copyWith(occupation: event.occupation)));

//     on<UpdateDropdown>((event, emit) {
//       switch (event.field) {
//         case 'country':
//           emit(state.copyWith(selectedCountry: event.value));
//           break;
//         case 'division':
//           emit(state.copyWith(selectedDivision: event.value));
//           add(FetchDistricts(event.id!));
//           break;
//         case 'district':
//           emit(state.copyWith(selectedDistrict: event.value));
//           add(FetchThanas(event.id!));
//           break;
//         case 'thana':
//           emit(state.copyWith(selectedThana: event.value));
//           break;
//         case 'netWorth':
//           emit(state.copyWith(selectedNetWorth: event.value));
//           break;
//       }
//     });

//     on<FetchDivisions>(_fetchDivisions);
//     on<FetchDistricts>(_fetchDistricts);
//     on<FetchThanas>(_fetchThanas);
//     on<FetchNetWorths>(_fetchNetWorths);
//   }

//   Future<void> _fetchDivisions(FetchDivisions event, Emitter<AdditionalInfoState> emit) async {
//     try {
//       final res = await http.get(Uri.parse("http://192.168.0.53:8070/additional_info/divisions"));
//       if (res.statusCode == 200) {
//         final List<dynamic> data = json.decode(res.body) as List<dynamic>;
//         final List<Map<String, dynamic>> divisions =
//             data.map((e) => {"division_id": e['division_id'], "division_nm": e['division_nm']}).toList();
//         emit(state.copyWith(divisionList: divisions));
//       }
//     } catch (_) {}
//   }

//   Future<void> _fetchDistricts(FetchDistricts event, Emitter<AdditionalInfoState> emit) async {
//     try {
//       final res = await http.get(Uri.parse("http://192.168.0.53:8070/additional_info/districts"));
//       if (res.statusCode == 200) {
//         final List<dynamic> data = json.decode(res.body) as List<dynamic>;
//         final List<Map<String, dynamic>> filteredDistricts = data
//             .where((e) => e['division_id'] == event.divisionId)
//             .map((e) => {"district_id": e['district_id'], "district_nm": e['district_nm'], "division_id": e['division_id']})
//             .toList();
//         emit(state.copyWith(allDistricts: filteredDistricts));
//       }
//     } catch (_) {}
//   }

//   Future<void> _fetchThanas(FetchThanas event, Emitter<AdditionalInfoState> emit) async {
//     try {
//       final res = await http.get(Uri.parse("http://192.168.0.53:8070/additional_info/thanas"));
//       if (res.statusCode == 200) {
//         final List<dynamic> data = json.decode(res.body) as List<dynamic>;
//         final List<Map<String, dynamic>> filteredThanas = data
//             .where((e) => e['district_id'] == event.districtId)
//             .map((e) => {"thana_id": e['thana_id'], "thana_nm": e['thana_nm'], "district_id": e['district_id']})
//             .toList();
//         emit(state.copyWith(allThanas: filteredThanas));
//       }
//     } catch (_) {}
//   }

//   Future<void> _fetchNetWorths(FetchNetWorths event, Emitter<AdditionalInfoState> emit) async {
//     try {
//       final res = await http.get(Uri.parse("http://192.168.0.53:8070/additional_info/networths"));
//       if (res.statusCode == 200) {
//         final List<dynamic> data = json.decode(res.body) as List<dynamic>;
//         final List<Map<String, dynamic>> netWorths =
//             data.map((e) => {"net_worth_id": e['net_worth_id'], "net_worth_nm": e['net_worth_nm']}).toList();
//         emit(state.copyWith(netWorthList: netWorths));
//       }
//     } catch (_) {}
//   }
// }

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

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
          break;
        case 'division':
          emit(state.copyWith(
            selectedDivision: event.value,
            selectedDistrict: '',
            selectedThana: '',
          ));
          add(FetchDistricts(event.id!));
          break;
        case 'district':
          emit(state.copyWith(
            selectedDistrict: event.value,
            selectedThana: '',
          ));
          add(FetchThanas(event.id!));
          break;
        case 'thana':
          emit(state.copyWith(selectedThana: event.value));
          break;
        case 'netWorth':
          emit(state.copyWith(selectedNetWorth: event.value));
          break;
      }
    });

    on<FetchDivisions>(_fetchDivisions);
    on<FetchDistricts>(_fetchDistricts);
    on<FetchThanas>(_fetchThanas);
    on<FetchNetWorths>(_fetchNetWorths);
  }

  Future<void> _fetchDivisions(FetchDivisions event, Emitter<AdditionalInfoState> emit) async {
    try {
      final res = await http.get(Uri.parse("http://192.168.0.53:8070/additional_info/divisions"));
      // final res = await http.get(Uri.parse("http://172.50.10.121/additional_info/divisions"));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body) as List<dynamic>;
        final divisions = data.map((e) => {
          "division_id": e['division_id'],
          "division_nm": e['division_nm']
        }).toList();

        emit(state.copyWith(divisionList: divisions));
      }
    } catch (e) {
      print("❌ Error fetching divisions: $e");
    }
  }

  Future<void> _fetchDistricts(FetchDistricts event, Emitter<AdditionalInfoState> emit) async {
    try {
      final res = await http.get(Uri.parse("http://192.168.0.53:8070/additional_info/districts"));
      // final res = await http.get(Uri.parse("http://172.50.10.121:8070/additional_info/districts"));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body) as List<dynamic>;

        // Filter by division and deduplicate by district_nm
        final filtered = data.where((e) => e['division_id'] == event.divisionId).toList();

        final uniqueDistricts = {
          for (var e in filtered) e['district_nm']: e
        }.values.map((e) => {
          "district_id": e['district_id'],
          "district_nm": e['district_nm'],
          "division_id": e['division_id']
        }).toList();

        emit(state.copyWith(allDistricts: uniqueDistricts));
      }
    } catch (e) {
      print("❌ Error fetching districts: $e");
    }
  }

  Future<void> _fetchThanas(FetchThanas event, Emitter<AdditionalInfoState> emit) async {
    try {
      final res = await http.get(Uri.parse("http://192.168.0.53:8070/additional_info/thanas"));
      // final res = await http.get(Uri.parse("http://172.50.10.121:8070/additional_info/thanas"));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body) as List<dynamic>;

        // Filter by district and deduplicate by thana_nm
        final filtered = data.where((e) => e['district_id'] == event.districtId).toList();

        final uniqueThanas = {
          for (var e in filtered) e['thana_nm']: e
        }.values.map((e) => {
          "thana_id": e['thana_id'],
          "thana_nm": e['thana_nm'],
          "district_id": e['district_id']
        }).toList();

        emit(state.copyWith(allThanas: uniqueThanas));
      }
    } catch (e) {
      print("❌ Error fetching thanas: $e");
    }
  }

  Future<void> _fetchNetWorths(FetchNetWorths event, Emitter<AdditionalInfoState> emit) async {
    try {
      final res = await http.get(Uri.parse("http://192.168.0.53:8070/additional_info/networths"));
      // final res = await http.get(Uri.parse("http://172.50.10.121:8070/additional_info/networths"));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body) as List<dynamic>;
        final netWorths = data.map((e) => {
          "net_worth_id": e['net_worth_id'],
          "net_worth_nm": e['net_worth_nm']
        }).toList();

        emit(state.copyWith(netWorthList: netWorths));
      }
    } catch (e) {
      print("❌ Error fetching net worths: $e");
    }
  }
}
