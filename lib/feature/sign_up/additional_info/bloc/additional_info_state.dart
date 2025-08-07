class AdditionalInfoState {
  final String gender;
  final String purpose;
  final String occupation;
  final String selectedCountry;
  final String selectedDivision;
  final String selectedDistrict;
  final String selectedThana;
  final String selectedCity;
  final String selectedNetWorth; 

  AdditionalInfoState({
    this.gender = 'Male',
    this.purpose = 'Personal',
    this.occupation = 'Service',
    this.selectedCountry = 'Bangladesh',
    this.selectedDivision = 'Dhaka',
    this.selectedDistrict = 'Dhaka',
    this.selectedThana = 'Dhanmondi',
    this.selectedCity = 'Dhaka City',
    this.selectedNetWorth = '1 lac - 5 lac',
  });

  AdditionalInfoState copyWith({
    String? gender,
    String? purpose,
    String? occupation,
    String? selectedCountry,
    String? selectedDivision,
    String? selectedDistrict,
    String? selectedThana,
    String? selectedCity,
    String? selectedNetWorth, 
  }) {
    return AdditionalInfoState(
      gender: gender ?? this.gender,
      purpose: purpose ?? this.purpose,
      occupation: occupation ?? this.occupation,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedDivision: selectedDivision ?? this.selectedDivision,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedThana: selectedThana ?? this.selectedThana,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedNetWorth: selectedNetWorth ?? this.selectedNetWorth,
    );
  }
}
