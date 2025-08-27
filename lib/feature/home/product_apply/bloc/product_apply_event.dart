import 'package:flutter/foundation.dart';
import 'package:bangladesh_finance_ekyc/model/branch_model.dart';

@immutable
abstract class ProductApplyEvent {}

/// Initialize screen state based on ProductSelectionState
class ProductApplyStarted extends ProductApplyEvent {}

/// Fetch branches from API
class FetchBranches extends ProductApplyEvent {}

/// User picked a branch
class BranchSelected extends ProductApplyEvent {
  final Branch branch;
  BranchSelected(this.branch);
}

/// User switched monthly mode: 'on_time' or 'installment'
class MonthlyModeChanged extends ProductApplyEvent {
  final String mode;
  MonthlyModeChanged(this.mode);
}

/// Amount text changed (fixed amount / principal / installment)
class AmountChanged extends ProductApplyEvent {
  final String amountText;
  AmountChanged(this.amountText);
}

/// Tenure changed (only used when not locked, e.g., monthly without lock)
class TenureChanged extends ProductApplyEvent {
  final int tenureMonths;
  TenureChanged(this.tenureMonths);
}

/// User clicked Continue
class SubmitPressed extends ProductApplyEvent {}
