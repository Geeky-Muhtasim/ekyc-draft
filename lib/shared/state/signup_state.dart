// class SignupState {
//   // Singleton pattern
//   static final SignupState _instance = SignupState._internal();
//   factory SignupState() => _instance;
//   SignupState._internal();

//   // Persisted signup flow data
//   int? nidId;
//   int? photoId;
//   int? additionalInfoId;
//   int? nomineeId;
//   int? otpId;
//   String? password;

//   set idNo(idNo) {}

//   // Reset all fields (call after successful signup or logout)
//   void reset() {
//     nidId = null;
//     photoId = null;
//     additionalInfoId = null;
//     nomineeId = null;
//     otpId = null;
//     password = null;
//   }

//   // Convert to JSON for API submission
//   Map<String, dynamic> toJson() {
//     return {
//       "nid_id": nidId ?? 0,
//       "photo_id": photoId ?? 0,
//       "additional_info_id": additionalInfoId ?? 0,
//       "nominee_id": nomineeId ?? 0,
//       "otp_id": otpId ?? 0,
//       "password": password ?? "",
//     };
//   }

//   @override
//   String toString() {
//     return 'SignupState('
//         'nidId: $nidId, '
//         'photoId: $photoId, '
//         'additionalInfoId: $additionalInfoId, '
//         'nomineeId: $nomineeId, '
//         'otpId: $otpId, '
//         'password: $password)';
//   }
// }

// lib/shared/state/signup_state.dart
class SignupState {
  // ---------- Singleton ----------
  static final SignupState _instance = SignupState._internal();
  factory SignupState() => _instance;
  SignupState._internal();

  // ---------- Persisted signup flow data ----------
  int? nidId;
  int? photoId;
  int? additionalInfoId;
  int? nomineeId;
  int? otpId;
  String? password;

  // (This looked unused; leaving in place for compatibility)
  set idNo(idNo) {}

  // ---------- NEW: Frozen product snapshot (captured at start of eKYC) ----------
  Map<String, dynamic>? _productSnapshot;

  /// Attach a product selection snapshot (e.g., at MobileNo page entry).
  /// Call with: `SignupState().attachProductSelection(ProductSelectionState().toApiJson());`
  void attachProductSelection(Map<String, dynamic> productJson) {
    _productSnapshot = Map<String, dynamic>.from(productJson);
  }

  Map<String, dynamic> get productSnapshot => _productSnapshot ?? {};
  bool get hasProductSnapshot => _productSnapshot != null;

  // ---------- JSON builders ----------
  /// Existing signup JSON (kept for backward compatibility).
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

  /// Explicit alias for clarity when merging with product snapshot.
  Map<String, dynamic> toSignupJson() => toJson();

  /// Final merged payload for backend submission on the Final Review page.
  /// Contains both the frozen product snapshot and current signup/eKYC data.
  Map<String, dynamic> toFinalSubmission() {
    return {
      "product": productSnapshot,   // frozen at start of eKYC
      "signup": toSignupJson(),     // latest signup/eKYC data
    };
  }

  // ---------- Lifecycle ----------
  /// Reset all fields after successful submission or logout.
  void reset() {
    nidId = null;
    photoId = null;
    additionalInfoId = null;
    nomineeId = null;
    otpId = null;
    password = null;
    _productSnapshot = null;
  }

  @override
  String toString() {
    return 'SignupState('
        'nidId: $nidId, '
        'photoId: $photoId, '
        'additionalInfoId: $additionalInfoId, '
        'nomineeId: $nomineeId, '
        'otpId: $otpId, '
        'password: $password, '
        'hasProductSnapshot: $hasProductSnapshot)';
  }
}
