// abstract class AdditionalInfoEvent {}

// class UpdateGender extends AdditionalInfoEvent {
//   final String gender;
//   UpdateGender(this.gender);
// }

// class UpdatePurpose extends AdditionalInfoEvent {
//   final String purpose;
//   UpdatePurpose(this.purpose);
// }

// class UpdateOccupation extends AdditionalInfoEvent {
//   final String occupation;
//   UpdateOccupation(this.occupation);
// }

// class UpdateDropdown extends AdditionalInfoEvent {
//   final String field;
//   final String value;
//   UpdateDropdown(this.field, this.value);
// }

import 'package:equatable/equatable.dart';

abstract class AdditionalInfoEvent extends Equatable {
  const AdditionalInfoEvent();

  @override
  List<Object?> get props => [];
}

// Dropdown update event with optional ID for triggering fetch
class UpdateDropdown extends AdditionalInfoEvent {
  final String field;
  final String value;
  final int? id;

  const UpdateDropdown(this.field, this.value, {this.id});

  @override
  List<Object?> get props => [field, value, id];
}

// Radio selections
class UpdateGender extends AdditionalInfoEvent {
  final String gender;
  const UpdateGender(this.gender);
  @override
  List<Object?> get props => [gender];
}

class UpdatePurpose extends AdditionalInfoEvent {
  final String purpose;
  const UpdatePurpose(this.purpose);
  @override
  List<Object?> get props => [purpose];
}

class UpdateOccupation extends AdditionalInfoEvent {
  final String occupation;
  const UpdateOccupation(this.occupation);
  @override
  List<Object?> get props => [occupation];
}

// Events to fetch API data
class FetchDivisions extends AdditionalInfoEvent {}

class FetchDistricts extends AdditionalInfoEvent {
  final int divisionId;
  const FetchDistricts(this.divisionId);

  @override
  List<Object?> get props => [divisionId];
}

class FetchThanas extends AdditionalInfoEvent {
  final int districtId;
  const FetchThanas(this.districtId);

  @override
  List<Object?> get props => [districtId];
}

class FetchNetWorths extends AdditionalInfoEvent {}

