abstract class AdditionalInfoEvent {}

class UpdateGender extends AdditionalInfoEvent {
  final String gender;
  UpdateGender(this.gender);
}

class UpdatePurpose extends AdditionalInfoEvent {
  final String purpose;
  UpdatePurpose(this.purpose);
}

class UpdateOccupation extends AdditionalInfoEvent {
  final String occupation;
  UpdateOccupation(this.occupation);
}

class UpdateDropdown extends AdditionalInfoEvent {
  final String field;
  final String value;
  UpdateDropdown(this.field, this.value);
}
