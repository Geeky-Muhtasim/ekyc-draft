// // class ProductSelectionState {
// //   static final ProductSelectionState _instance = ProductSelectionState._internal();

// //   factory ProductSelectionState() => _instance;

// //   ProductSelectionState._internal();

// //   String? _serviceTypeId; // "I" or "C"
// //   int? _productTypeId; // 1 or 2
// //   int? _productId;
// //   String? _productName;
// //   String? _productDescription;

// //   // Getters
// //   String? get serviceTypeId => _serviceTypeId;
// //   int? get productTypeId => _productTypeId;
// //   int? get productId => _productId;
// //   String? get productName => _productName;
// //   String? get productDescription => _productDescription;

// //   // Setters
// //   void setServiceTypeId(String value) => _serviceTypeId = value;
// //   void setProductTypeId(int value) => _productTypeId = value;
// //   void setProductDetails({required int id, required String name, required String description}) {
// //     _productId = id;
// //     _productName = name;
// //     _productDescription = description;
// //   }

// //   // Clear everything
// //   void reset() {
// //     _serviceTypeId = null;
// //     _productTypeId = null;
// //     _productId = null;
// //     _productName = null;
// //     _productDescription = null;
// //   }

// //   @override
// //   String toString() {
// //     return 'ProductSelectionState('
// //         'serviceTypeId: $_serviceTypeId, '
// //         'productTypeId: $_productTypeId, '
// //         'productId: $_productId, '
// //         'name: $_productName)';
// //   }
// // }
// import 'package:flutter/foundation.dart';

// /// Global selection + application input state for the product flow.
// /// - Keeps the selected category/product
// /// - Also stores user-entered application inputs (amounts, tenure, monthly mode)
// class ProductSelectionState {
//   static final ProductSelectionState _instance = ProductSelectionState._internal();
//   factory ProductSelectionState() => _instance;
//   ProductSelectionState._internal();

//   // ---------- Product selection ----------
//   String? _serviceTypeId; // "I" or "C"
//   int? _productTypeId;    // 1 = Fixed, 2 = Monthly
//   int? _productId;
//   String? _productName;
//   String? _productDescription;

//   // ---------- Application inputs ----------
//   // Common
//   int? _tenureMonths;

//   // Fixed deposit
//   double? _fixedAmount;

//   // Monthly deposit
//   // "on_time" or "installment"
//   String? _monthlyMode;
//   // On-time principal
//   double? _monthlyPrincipalAmount;
//   // Installment amount
//   double? _monthlyInstallmentAmount;

//   // ======= Getters =======
//   String? get serviceTypeId => _serviceTypeId;
//   int? get productTypeId => _productTypeId;
//   int? get productId => _productId;
//   String? get productName => _productName;
//   String? get productDescription => _productDescription;

//   int? get tenureMonths => _tenureMonths;
//   double? get fixedAmount => _fixedAmount;
//   String? get monthlyMode => _monthlyMode;
//   double? get monthlyPrincipalAmount => _monthlyPrincipalAmount;
//   double? get monthlyInstallmentAmount => _monthlyInstallmentAmount;

//   // ======= Setters (selection) =======
//   void setServiceTypeId(String value) => _serviceTypeId = value;
//   void setProductTypeId(int value) => _productTypeId = value;
//   void setProductDetails({
//     required int id,
//     required String name,
//     required String description,
//   }) {
//     _productId = id;
//     _productName = name;
//     _productDescription = description;
//   }

//   // ======= Setters (application inputs) =======
//   /// Set fixed deposit inputs
//   void setFixedInputs({
//     required double amount,
//     required int tenureMonths,
//   }) {
//     _productTypeId ??= 1; // be defensive
//     _fixedAmount = amount;
//     _tenureMonths = tenureMonths;

//     // Clear monthly-specific
//     _monthlyMode = null;
//     _monthlyPrincipalAmount = null;
//     _monthlyInstallmentAmount = null;
//   }

//   /// Set monthly on-time inputs
//   void setMonthlyOnTime({
//     required double principalAmount,
//     required int tenureMonths,
//   }) {
//     _productTypeId ??= 2; // be defensive
//     _monthlyMode = 'on_time';
//     _monthlyPrincipalAmount = principalAmount;
//     _tenureMonths = tenureMonths;

//     // Clear other fields
//     _fixedAmount = null;
//     _monthlyInstallmentAmount = null;
//   }

//   /// Set monthly installment inputs
//   void setMonthlyInstallment({
//     required double installmentAmount,
//     required int tenureMonths,
//   }) {
//     _productTypeId ??= 2; // be defensive
//     _monthlyMode = 'installment';
//     _monthlyInstallmentAmount = installmentAmount;
//     _tenureMonths = tenureMonths;

//     // Clear other fields
//     _fixedAmount = null;
//     _monthlyPrincipalAmount = null;
//   }

//   /// Clears *only* the application inputs (keeps selected product)
//   void clearApplicationInputs() {
//     _tenureMonths = null;
//     _fixedAmount = null;
//     _monthlyMode = null;
//     _monthlyPrincipalAmount = null;
//     _monthlyInstallmentAmount = null;
//   }

//   /// Clears everything (selection + inputs)
//   void reset() {
//     _serviceTypeId = null;
//     _productTypeId = null;
//     _productId = null;
//     _productName = null;
//     _productDescription = null;
//     clearApplicationInputs();
//   }

//   @override
//   String toString() {
//     return 'ProductSelectionState('
//         'serviceTypeId: $_serviceTypeId, '
//         'productTypeId: $_productTypeId, '
//         'productId: $_productId, '
//         'name: $_productName, '
//         'tenure: $_tenureMonths, '
//         'fixedAmount: $_fixedAmount, '
//         'mode: $_monthlyMode, '
//         'principal: $_monthlyPrincipalAmount, '
//         'installment: $_monthlyInstallmentAmount'
//         ')';
//   }
// }
import 'package:flutter/foundation.dart';

/// Single source of truth for the product flow.
/// Conventions:
/// - productTypeId: 1 = Fixed Deposit, 2 = Monthly Deposit
/// - schemeId (Monthly only): 1 = On Installment, 2 = On Time
class ProductSelectionState {
  // ---------- Singleton ----------
  ProductSelectionState._internal();
  static final ProductSelectionState _instance = ProductSelectionState._internal();
  factory ProductSelectionState() => _instance;

  // ---------- Selection ----------
  String? _serviceTypeId; // "I" or "C"
  int? _productTypeId;    // 1=Fixed, 2=Monthly
  int? _productId;        // productCode
  String? _productName;
  String? _productDescription;

  // ---------- Monthly-only ----------
  int? _schemeId;         // 1=installment, 2=on_time

  // ---------- Tenure ----------
  int? _tenureLockedMonths; // if present => tenure fixed (Fixed only)
  int? _tenureMonths;       // user-selected (when not locked / for Monthly)

  // ---------- Amounts ----------
  double? _fixedAmount;
  double? _monthlyPrincipalAmount;    // on-time
  double? _monthlyInstallmentAmount;  // installment

  // ---------- Branch selection ----------
  String? _branchId;
  String? _branchName;
  int? _districtId;

  // ---------- Created account IDs ----------
  int? _schemeAccountId;
  int? _timeAccountId;

  // ---------- Getters ----------
  String? get serviceTypeId => _serviceTypeId;
  int? get productTypeId => _productTypeId;
  int? get productId => _productId;
  String? get productName => _productName;
  String? get productDescription => _productDescription;

  int? get schemeId => _schemeId;               // (Monthly only)
  bool get hasLockedTenure => _tenureLockedMonths != null;
  int? get tenureLockedMonths => _tenureLockedMonths;
  int? get tenureMonths => _tenureMonths;
  int? get effectiveTenureMonths => _tenureLockedMonths ?? _tenureMonths;

  double? get fixedAmount => _fixedAmount;
  double? get monthlyPrincipalAmount => _monthlyPrincipalAmount;
  double? get monthlyInstallmentAmount => _monthlyInstallmentAmount;

  String? get branchId => _branchId;
  String? get branchName => _branchName;
  int? get districtId => _districtId;

  int? get schemeAccountId => _schemeAccountId;
  int? get timeAccountId => _timeAccountId;

  /// Convenience: the numeric amount actually chosen by user
  double? get selectedAmount {
    if (_productTypeId == 1) return _fixedAmount;
    if (_productTypeId == 2) {
      if (_schemeId == 2) return _monthlyPrincipalAmount;    // on-time
      if (_schemeId == 1) return _monthlyInstallmentAmount;  // installment
    }
    return null;
  }

  // ---------- Basic setters ----------
  void setServiceTypeId(String v) => _serviceTypeId = v;            // "I" or "C"
  void setProductTypeId(int v)     => _productTypeId = v;           // 1 or 2
  void setSchemeId(int v)          => _schemeId = v;                // 1 or 2 (monthly)

  void setProductDetails({
    required int id,
    required String name,
    required String description,
  }) {
    _productId = id;
    _productName = name;
    _productDescription = description;
  }

  /// For Fixed deposit: lock a tenure parsed from product name or API.
  void lockTenure(int months) {
    _tenureLockedMonths = months;
    _tenureMonths = months; // keep aligned
  }

  void unlockTenure() {
    _tenureLockedMonths = null;
  }

  int? lockTenureFromNameIfPresent() {
    final name = (_productName ?? '').toLowerCase();

    if (RegExp(r'\bquarterly\b').hasMatch(name)) { lockTenure(3);  return 3; }
    if (RegExp(r'\bhalf[-\s]?year(ly)?\b').hasMatch(name) ||
        RegExp(r'\bbi-?annual\b').hasMatch(name)) { lockTenure(6); return 6; }
    if (RegExp(r'\bannual(ly)?\b').hasMatch(name) ||
        RegExp(r'\byearly\b').hasMatch(name) ||
        RegExp(r'\b1\s*(year|yr)\b').hasMatch(name)) { lockTenure(12); return 12; }

    final yrs = RegExp(r'(\d{1,2})\s*(years|year|yrs|yr)\b').firstMatch(name);
    if (yrs != null) {
      final y = int.tryParse(yrs.group(1)!);
      if (y != null) { lockTenure(y * 12); return y * 12; }
    }

    final mons = RegExp(r'(\d{1,3})\s*(months|month|mons|mon)\b').firstMatch(name);
    if (mons != null) {
      final m = int.tryParse(mons.group(1)!);
      if (m != null) { lockTenure(m); return m; }
    }
    return null;
  }

  // ---------- Apply-page setters ----------
  void setFixedInputs({
    required double amount,
    required int tenureMonths,
  }) {
    _productTypeId ??= 1;
    _fixedAmount = amount;
    _tenureMonths = _tenureLockedMonths ?? tenureMonths;
    _schemeId = null;
    _monthlyPrincipalAmount = null;
    _monthlyInstallmentAmount = null;
  }

  void setMonthlyOnTime({
    required double principalAmount,
    required int tenureMonths,
  }) {
    _productTypeId ??= 2;
    _schemeId = 2;
    _monthlyPrincipalAmount = principalAmount;
    _tenureMonths = _tenureLockedMonths ?? tenureMonths;
    _fixedAmount = null;
    _monthlyInstallmentAmount = null;
  }

  void setMonthlyInstallment({
    required double installmentAmount,
    required int tenureMonths,
  }) {
    _productTypeId ??= 2;
    _schemeId = 1;
    _monthlyInstallmentAmount = installmentAmount;
    _tenureMonths = _tenureLockedMonths ?? tenureMonths;
    _fixedAmount = null;
    _monthlyPrincipalAmount = null;
  }

  /// Persist user's branch selection
  void setBranchSelection({
    required String branchId,
    required String branchName,
    required int districtId,
  }) {
    _branchId = branchId;
    _branchName = branchName;
    _districtId = districtId;
  }

  /// Persist created account ids for later registration
  void setSchemeAccountId(int id) {
    _schemeAccountId = id;
  }

  void setTimeAccountId(int id) {
    _timeAccountId = id;
  }

  /// Clear only Apply-page inputs (keeps chosen product)
  void clearApplicationInputs() {
    _tenureMonths = _tenureLockedMonths;
    _fixedAmount = null;
    _schemeId = null;
    _monthlyPrincipalAmount = null;
    _monthlyInstallmentAmount = null;
    // keep branch selection — it’s a real choice, not a draft
  }

  /// Clear everything (use after Successful submission if you want a fresh start)
  void reset() {
    _serviceTypeId = null;
    _productTypeId = null;
    _productId = null;
    _productName = null;
    _productDescription = null;

    _schemeId = null;
    _tenureLockedMonths = null;
    _tenureMonths = null;

    _fixedAmount = null;
    _monthlyPrincipalAmount = null;
    _monthlyInstallmentAmount = null;

    _branchId = null;
    _branchName = null;
    _districtId = null;

    _schemeAccountId = null;
    _timeAccountId = null;
  }

  /// Build the payload for your API/DB insert.
  Map<String, dynamic> toApiJson() {
    return {
      'serviceTypeId'  : _serviceTypeId,        // "I" / "C"
      'productTypeId'  : _productTypeId,        // 1 = Fixed, 2 = Monthly
      'schemeId'       : _schemeId,             // Monthly: 1=Installment, 2=On-time
      'productCode'    : _productId,
      'productName'    : _productName,          // optional (for audits)
      'tenureMonths'   : effectiveTenureMonths, // locked or selected
      'amount'         : selectedAmount,        // fixed/principal/installment
      'amountType'     : _productTypeId == 1
          ? 'fixed'
          : (_schemeId == 2 ? 'principal' : 'installment'),
      'branchId'       : _branchId,
      'branchName'     : _branchName,
      'districtId'     : _districtId,
    };
  }

  @override
  String toString() {
    return 'ProductSelectionState('
        'serviceTypeId=$_serviceTypeId, productTypeId=$_productTypeId, '
        'productId=$_productId, name=$_productName, '
        'schemeId=$_schemeId, '
        'tenureLocked=$_tenureLockedMonths, tenure=$_tenureMonths, '
        'fixed=$_fixedAmount, principal=$_monthlyPrincipalAmount, installment=$_monthlyInstallmentAmount, '
        'branchId=$_branchId, branchName=$_branchName, districtId=$_districtId, '
        'schemeAccountId=$_schemeAccountId, timeAccountId=$_timeAccountId'
        ')';
  }
}
