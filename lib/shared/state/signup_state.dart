class SignupState {
  // Singleton pattern
  static final SignupState _instance = SignupState._internal();
  factory SignupState() => _instance;
  SignupState._internal();

  // Persisted signup flow data
  int? nidId;
  int? photoId;
  int? additionalInfoId;
  int? nomineeId;
  int? otpId;
  String? password;

  // Reset all fields (call after successful signup or logout)
  void reset() {
    nidId = null;
    photoId = null;
    additionalInfoId = null;
    nomineeId = null;
    otpId = null;
    password = null;
  }

  // Convert to JSON for API submission
  Map<String, dynamic> toJson() {
    return {
      "nid_id": nidId ?? 0,
      "photo_id": photoId ?? 0,
      "additional_info_id": additionalInfoId ?? 0,
      "nominee_id": nomineeId ?? 0,
      "otp_id": otpId ?? 0,
      "password": password ?? "",
    };
  }

  @override
  String toString() {
    return 'SignupState('
        'nidId: $nidId, '
        'photoId: $photoId, '
        'additionalInfoId: $additionalInfoId, '
        'nomineeId: $nomineeId, '
        'otpId: $otpId, '
        'password: $password)';
  }
}
