// import 'package:flutter/foundation.dart';

// @immutable
// class ProductApplyState {
//   final bool isFixed;
//   final String monthlyMode;           // 'on_time' or 'installment'
//   final String amountText;            // raw user input
//   final int tenureMonths;             // selected tenure (or locked value)
//   final List<int> tenureOptions;      // dropdown values
//   final bool tenureLocked;

//   final bool isValid;                 // simple amount validation
//   final bool isSubmitting;            // during submit
//   final bool submitSuccess;           // after submit; UI can navigate
//   final String? errorMessage;         // validation / other error

//   const ProductApplyState({
//     required this.isFixed,
//     required this.monthlyMode,
//     required this.amountText,
//     required this.tenureMonths,
//     required this.tenureOptions,
//     required this.tenureLocked,
//     required this.isValid,
//     required this.isSubmitting,
//     required this.submitSuccess,
//     this.errorMessage,
//   });

//   factory ProductApplyState.initial() => const ProductApplyState(
//         isFixed: true,
//         monthlyMode: 'on_time',
//         amountText: '',
//         tenureMonths: 3,
//         tenureOptions: [3, 6, 12, 24, 36, 60],
//         tenureLocked: false,
//         isValid: false,
//         isSubmitting: false,
//         submitSuccess: false,
//         errorMessage: null,
//       );

//   ProductApplyState copyWith({
//     bool? isFixed,
//     String? monthlyMode,
//     String? amountText,
//     int? tenureMonths,
//     List<int>? tenureOptions,
//     bool? tenureLocked,
//     bool? isValid,
//     bool? isSubmitting,
//     bool? submitSuccess,
//     String? errorMessage,
//   }) {
//     return ProductApplyState(
//       isFixed: isFixed ?? this.isFixed,
//       monthlyMode: monthlyMode ?? this.monthlyMode,
//       amountText: amountText ?? this.amountText,
//       tenureMonths: tenureMonths ?? this.tenureMonths,
//       tenureOptions: tenureOptions ?? this.tenureOptions,
//       tenureLocked: tenureLocked ?? this.tenureLocked,
//       isValid: isValid ?? this.isValid,
//       isSubmitting: isSubmitting ?? this.isSubmitting,
//       submitSuccess: submitSuccess ?? this.submitSuccess,
//       errorMessage: errorMessage,
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:bangladesh_finance_ekyc/model/branch_model.dart';

@immutable
class ProductApplyState {
  // Mode
  final bool isFixed;
  final String monthlyMode;           // 'on_time' or 'installment'

  // Amount & Tenure
  final String amountText;            // raw user input
  final int tenureMonths;             // selected tenure (or locked value)
  final List<int> tenureOptions;      // dropdown values
  final bool tenureLocked;

  // Branch UI
  final bool isBranchesLoading;
  final String? branchesError;
  final List<Branch> branches;
  final Branch? selectedBranch;

  // Submit UX
  final bool isValid;                 // amount validation (simple)
  final bool isSubmitting;
  final bool submitSuccess;
  final String? errorMessage;

  const ProductApplyState({
    required this.isFixed,
    required this.monthlyMode,
    required this.amountText,
    required this.tenureMonths,
    required this.tenureOptions,
    required this.tenureLocked,
    required this.isBranchesLoading,
    required this.branchesError,
    required this.branches,
    required this.selectedBranch,
    required this.isValid,
    required this.isSubmitting,
    required this.submitSuccess,
    this.errorMessage,
  });

  factory ProductApplyState.initial() => const ProductApplyState(
        isFixed: true,
        monthlyMode: 'on_time',
        amountText: '',
        tenureMonths: 3,
        tenureOptions: [3, 6, 12, 24, 36, 60],
        tenureLocked: false,
        isBranchesLoading: true,
        branchesError: null,
        branches: [],
        selectedBranch: null,
        isValid: false,
        isSubmitting: false,
        submitSuccess: false,
        errorMessage: null,
      );

  ProductApplyState copyWith({
    bool? isFixed,
    String? monthlyMode,
    String? amountText,
    int? tenureMonths,
    List<int>? tenureOptions,
    bool? tenureLocked,
    bool? isBranchesLoading,
    String? branchesError,
    List<Branch>? branches,
    Branch? selectedBranch,
    bool? isValid,
    bool? isSubmitting,
    bool? submitSuccess,
    String? errorMessage,
  }) {
    return ProductApplyState(
      isFixed: isFixed ?? this.isFixed,
      monthlyMode: monthlyMode ?? this.monthlyMode,
      amountText: amountText ?? this.amountText,
      tenureMonths: tenureMonths ?? this.tenureMonths,
      tenureOptions: tenureOptions ?? this.tenureOptions,
      tenureLocked: tenureLocked ?? this.tenureLocked,
      isBranchesLoading: isBranchesLoading ?? this.isBranchesLoading,
      branchesError: branchesError,
      branches: branches ?? this.branches,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      errorMessage: errorMessage,
    );
  }
}
