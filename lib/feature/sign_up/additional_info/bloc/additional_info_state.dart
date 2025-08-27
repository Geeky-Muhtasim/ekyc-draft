// class AdditionalInfoState {
//   final String gender;
//   final String purpose;
//   final String occupation;
//   final String selectedCountry;
//   final String selectedDivision;
//   final String selectedDistrict;
//   final String selectedThana;
//   final String selectedCity;
//   final String selectedNetWorth; 

//   AdditionalInfoState({
//     this.gender = 'Male',
//     this.purpose = 'Personal',
//     this.occupation = 'Service',
//     this.selectedCountry = 'Bangladesh',
//     this.selectedDivision = 'Dhaka',
//     this.selectedDistrict = 'Dhaka',
//     this.selectedThana = 'Dhanmondi',
//     this.selectedCity = 'Dhaka City',
//     this.selectedNetWorth = '1 lac - 5 lac',
//   });

//   AdditionalInfoState copyWith({
//     String? gender,
//     String? purpose,
//     String? occupation,
//     String? selectedCountry,
//     String? selectedDivision,
//     String? selectedDistrict,
//     String? selectedThana,
//     String? selectedCity,
//     String? selectedNetWorth, 
//   }) {
//     return AdditionalInfoState(
//       gender: gender ?? this.gender,
//       purpose: purpose ?? this.purpose,
//       occupation: occupation ?? this.occupation,
//       selectedCountry: selectedCountry ?? this.selectedCountry,
//       selectedDivision: selectedDivision ?? this.selectedDivision,
//       selectedDistrict: selectedDistrict ?? this.selectedDistrict,
//       selectedThana: selectedThana ?? this.selectedThana,
//       selectedCity: selectedCity ?? this.selectedCity,
//       selectedNetWorth: selectedNetWorth ?? this.selectedNetWorth,
//     );
//   }
// }

// class AdditionalInfoState {
//   final String gender;
//   final String purpose;
//   final String occupation;
//   final String selectedCountry;
//   final String selectedDivision;
//   final String selectedDistrict;
//   final String selectedThana;
//   final String selectedCity;
//   final String selectedNetWorth;

//   // New dynamic lists
//   final List<String> divisionList;
//   final List<String> districtList;
//   final List<String> thanaList;
//   final List<String> netWorthList;

//   AdditionalInfoState({
//     this.gender = 'Male',
//     this.purpose = 'Personal',
//     this.occupation = 'Service',
//     this.selectedCountry = 'Bangladesh',
//     this.selectedDivision = '',
//     this.selectedDistrict = '',
//     this.selectedThana = '',
//     this.selectedCity = '',
//     this.selectedNetWorth = '',
//     this.divisionList = const [],
//     this.districtList = const [],
//     this.thanaList = const [],
//     this.netWorthList = const [],
//   });

//   AdditionalInfoState copyWith({
//     String? gender,
//     String? purpose,
//     String? occupation,
//     String? selectedCountry,
//     String? selectedDivision,
//     String? selectedDistrict,
//     String? selectedThana,
//     String? selectedCity,
//     String? selectedNetWorth,
//     List<String>? divisionList,
//     List<String>? districtList,
//     List<String>? thanaList,
//     List<String>? netWorthList,
//   }) {
//     return AdditionalInfoState(
//       gender: gender ?? this.gender,
//       purpose: purpose ?? this.purpose,
//       occupation: occupation ?? this.occupation,
//       selectedCountry: selectedCountry ?? this.selectedCountry,
//       selectedDivision: selectedDivision ?? this.selectedDivision,
//       selectedDistrict: selectedDistrict ?? this.selectedDistrict,
//       selectedThana: selectedThana ?? this.selectedThana,
//       selectedCity: selectedCity ?? this.selectedCity,
//       selectedNetWorth: selectedNetWorth ?? this.selectedNetWorth,
//       divisionList: divisionList ?? this.divisionList,
//       districtList: districtList ?? this.districtList,
//       thanaList: thanaList ?? this.thanaList,
//       netWorthList: netWorthList ?? this.netWorthList,
//     );
//   }
// }

class AdditionalInfoState {
  final String gender;
  final String purpose;
  final String occupation;
  final String selectedCountry;
  final String selectedDivision;
  final String selectedDistrict;
  final String selectedThana;
  final String selectedNetWorth;

  // Division, District, Thana, NetWorth option maps
  final List<Map<String, dynamic>> divisionList;
  final List<Map<String, dynamic>> allDistricts;
  final List<Map<String, dynamic>> allThanas;
  final List<Map<String, dynamic>> netWorthList;

  AdditionalInfoState({
    this.gender = 'Male',
    this.purpose = 'Personal',
    this.occupation = 'Service',
    this.selectedCountry = 'Bangladesh',
    this.selectedDivision = '',
    this.selectedDistrict = '',
    this.selectedThana = '',
    this.selectedNetWorth = '',
    this.divisionList = const [],
    this.allDistricts = const [],
    this.allThanas = const [],
    this.netWorthList = const [],
  });

  AdditionalInfoState copyWith({
    String? gender,
    String? purpose,
    String? occupation,
    String? selectedCountry,
    String? selectedDivision,
    String? selectedDistrict,
    String? selectedThana,
    String? selectedNetWorth,
    List<Map<String, dynamic>>? divisionList,
    List<Map<String, dynamic>>? allDistricts,
    List<Map<String, dynamic>>? allThanas,
    List<Map<String, dynamic>>? netWorthList,
  }) {
    return AdditionalInfoState(
      gender: gender ?? this.gender,
      purpose: purpose ?? this.purpose,
      occupation: occupation ?? this.occupation,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedDivision: selectedDivision ?? this.selectedDivision,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedThana: selectedThana ?? this.selectedThana,
      selectedNetWorth: selectedNetWorth ?? this.selectedNetWorth,
      divisionList: divisionList ?? this.divisionList,
      allDistricts: allDistricts ?? this.allDistricts,
      allThanas: allThanas ?? this.allThanas,
      netWorthList: netWorthList ?? this.netWorthList,
    );
  }
}
