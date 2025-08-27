// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';

// import 'product_apply_event.dart';
// import 'product_apply_state.dart';

// class ProductApplyBloc extends Bloc<ProductApplyEvent, ProductApplyState> {
//   ProductApplyBloc() : super(ProductApplyState.initial()) {
//     on<ProductApplyStarted>(_onStarted);
//     on<MonthlyModeChanged>(_onModeChanged);
//     on<AmountChanged>(_onAmountChanged);
//     on<TenureChanged>(_onTenureChanged);
//     on<SubmitPressed>(_onSubmit);
//   }

//   void _onStarted(ProductApplyStarted event, Emitter<ProductApplyState> emit) {
//     final selection = ProductSelectionState();

//     // Determine page mode from selected product type
//     final isFixed = (selection.productTypeId ?? 1) == 1;

//     // Tenure lock applies ONLY for Fixed; Monthly must ignore any lock.
//     final locked = isFixed && selection.hasLockedTenure;
//     final initialTenure = locked
//         ? (selection.tenureLockedMonths ?? state.tenureOptions.first)
//         : (selection.effectiveTenureMonths ?? state.tenureOptions.first);

//     // Clear previous inputs (keep lock if any)
//     selection.clearApplicationInputs();

//     // 👉 For monthly, default scheme is "on_time" => 2 (persist now)
//     if (!isFixed) {
//       selection.setSchemeId(2); // 2 = on_time
//       debugPrint('🟩 [ApplyBloc] Default monthly scheme set to ON_TIME (2)');
//     }

//     emit(
//       state.copyWith(
//         isFixed: isFixed,
//         monthlyMode: 'on_time',
//         amountText: '',
//         tenureMonths: initialTenure,
//         tenureLocked: locked,
//         isValid: false,
//         isSubmitting: false,
//         submitSuccess: false,
//         errorMessage: null,
//       ),
//     );

//     _dumpSelection('ApplyBloc::_onStarted');
//   }

//   void _onModeChanged(MonthlyModeChanged event, Emitter<ProductApplyState> emit) {
//     // Persist scheme immediately
//     final sel = ProductSelectionState();
//     final schemeId = (event.mode == 'on_time') ? 2 : 1;
//     sel.setSchemeId(schemeId);
//     debugPrint('🟨 [ApplyBloc] Monthly mode changed → schemeId=$schemeId ($event)');

//     emit(state.copyWith(
//       monthlyMode: event.mode,
//       amountText: '',
//       isValid: false,
//       errorMessage: null,
//     ));

//     _dumpSelection('ApplyBloc::_onModeChanged');
//   }

//   void _onAmountChanged(AmountChanged event, Emitter<ProductApplyState> emit) {
//     final txt = event.amountText.trim();
//     final parsed = double.tryParse(txt);
//     final valid = (parsed != null && parsed > 0.0);

//     emit(state.copyWith(
//       amountText: event.amountText,
//       isValid: valid,
//       errorMessage: null,
//     ));
//   }

//   void _onTenureChanged(TenureChanged event, Emitter<ProductApplyState> emit) {
//     if (state.tenureLocked) return; // ignore changes if locked
//     emit(state.copyWith(tenureMonths: event.tenureMonths, errorMessage: null));

//     // (Optional) We do NOT persist partial tenure into the singleton here to avoid
//     // storing draft values. Final tenure is persisted on Submit.
//     debugPrint('🟦 [ApplyBloc] Tenure changed (draft): ${event.tenureMonths} months');
//   }

//   void _onSubmit(SubmitPressed event, Emitter<ProductApplyState> emit) {
//     final selection = ProductSelectionState();

//     final parsed = double.tryParse(state.amountText.trim());
//     if (parsed == null || parsed <= 0) {
//       emit(state.copyWith(
//         errorMessage: 'Please enter a valid amount',
//         isSubmitting: false,
//         submitSuccess: false,
//       ));
//       return;
//     }

//     emit(state.copyWith(isSubmitting: true, errorMessage: null));

//     // Use locked tenure if available (Fixed), otherwise the selected one.
//     final months = selection.effectiveTenureMonths ?? state.tenureMonths;

//     if (state.isFixed) {
//       selection.setFixedInputs(amount: parsed, tenureMonths: months);
//       debugPrint('✅ [ApplyBloc] Persisted FIXED: amount=$parsed, tenure=$months');
//     } else if (state.monthlyMode == 'on_time') {
//       selection.setMonthlyOnTime(principalAmount: parsed, tenureMonths: months);
//       debugPrint('✅ [ApplyBloc] Persisted MONTHLY ON_TIME: principal=$parsed, tenure=$months');
//     } else {
//       selection.setMonthlyInstallment(installmentAmount: parsed, tenureMonths: months);
//       debugPrint('✅ [ApplyBloc] Persisted MONTHLY INSTALLMENT: installment=$parsed, tenure=$months');
//     }

//     _dumpSelection('ApplyBloc::_onSubmit (after persist)');

//     emit(state.copyWith(isSubmitting: false, submitSuccess: true));
//   }

//   void _dumpSelection(String label) {
//     final s = ProductSelectionState();
//     debugPrint('🧾 [$label]');
//     debugPrint('— serviceTypeId: ${s.serviceTypeId} (I/C)');
//     debugPrint('— productTypeId: ${s.productTypeId} (1=Fixed, 2=Monthly)');
//     debugPrint('— productId: ${s.productId}');
//     debugPrint('— productName: ${s.productName}');
//     debugPrint('— schemeId (monthly): ${s.schemeId} (1=Installment, 2=On-time)');
//     debugPrint('— tenureLockedMonths: ${s.tenureLockedMonths}');
//     debugPrint('— tenureMonths (effective=${s.effectiveTenureMonths}): ${s.tenureMonths}');
//     debugPrint('— fixedAmount: ${s.fixedAmount}');
//     debugPrint('— monthlyPrincipalAmount: ${s.monthlyPrincipalAmount}');
//     debugPrint('— monthlyInstallmentAmount: ${s.monthlyInstallmentAmount}');
//     debugPrint('— selectedAmount (auto): ${s.selectedAmount}');
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:bangladesh_finance_ekyc/core/service/branch_service.dart';
import 'package:bangladesh_finance_ekyc/core/service/accounts_service.dart';
import 'package:bangladesh_finance_ekyc/model/branch_model.dart';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';

import 'product_apply_event.dart';
import 'product_apply_state.dart';

class ProductApplyBloc extends Bloc<ProductApplyEvent, ProductApplyState> {
  ProductApplyBloc() : super(ProductApplyState.initial()) {
    on<ProductApplyStarted>(_onStarted);
    on<FetchBranches>(_onFetchBranches);
    on<BranchSelected>(_onBranchSelected);
    on<MonthlyModeChanged>(_onModeChanged);
    on<AmountChanged>(_onAmountChanged);
    on<TenureChanged>(_onTenureChanged);
    on<SubmitPressed>(_onSubmit);
  }

  void _onStarted(ProductApplyStarted event, Emitter<ProductApplyState> emit) {
    final selection = ProductSelectionState();

    final isFixed = (selection.productTypeId ?? 1) == 1;
    final locked = isFixed && selection.hasLockedTenure;
    final initialTenure = locked
        ? (selection.tenureLockedMonths ?? state.tenureOptions.first)
        : (selection.effectiveTenureMonths ?? state.tenureOptions.first);

    selection.clearApplicationInputs();

    if (!isFixed) {
      selection.setSchemeId(2); // default monthly = on_time
      debugPrint('🟩 [ApplyBloc] Default monthly scheme set to ON_TIME (2)');
    }

    emit(
      state.copyWith(
        isFixed: isFixed,
        monthlyMode: 'on_time',
        amountText: '',
        tenureMonths: initialTenure,
        tenureLocked: locked,
        isValid: false,
        isSubmitting: false,
        submitSuccess: false,
        errorMessage: null,
        isBranchesLoading: true,
        branchesError: null,
        branches: const [],
        selectedBranch: null,
      ),
    );

    add(FetchBranches());
  }

  Future<void> _onFetchBranches(FetchBranches event, Emitter<ProductApplyState> emit) async {
    emit(state.copyWith(isBranchesLoading: true, branchesError: null));

    try {
      final all = await BranchService.fetchBranches();

      // Optional: filter by service type (I vs C).
      // Very simple heuristic: keep names containing "Islamic Wing" for Islamic,
      // keep the rest for Conventional. Adjust as per your backend rules.
      final sel = ProductSelectionState();
      final isIslamic = (sel.serviceTypeId ?? 'I') == 'I';

      final branches = all.where((b) {
        final iw = b.branchName.toLowerCase().contains('islamic wing');
        return isIslamic ? iw : !iw;
      }).toList();

      // If user previously selected a branch, restore
      Branch? preselected;
      if (sel.branchId != null) {
        preselected = branches.firstWhere(
          (b) => b.branchId == sel.branchId,
          orElse: () => branches.isNotEmpty ? branches.first : Branch(branchId: '', branchName: '', districtId: 0),
        );
      }

      emit(state.copyWith(
        isBranchesLoading: false,
        branchesError: null,
        branches: branches,
        selectedBranch: (preselected?.branchId?.isNotEmpty ?? false) ? preselected : null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isBranchesLoading: false,
        branchesError: 'Failed to load branches. Tap to retry.',
        branches: const [],
        selectedBranch: null,
      ));
    }
  }

  void _onBranchSelected(BranchSelected event, Emitter<ProductApplyState> emit) {
    final b = event.branch;
    ProductSelectionState().setBranchSelection(
      branchId: b.branchId,
      branchName: b.branchName,
      districtId: b.districtId,
    );
    debugPrint('✅ [ApplyBloc] Persisted BRANCH: ${b.branchId} - ${b.branchName} (${b.districtId})');

    emit(state.copyWith(selectedBranch: b));
  }

  void _onModeChanged(MonthlyModeChanged event, Emitter<ProductApplyState> emit) {
    final sel = ProductSelectionState();
    final schemeId = (event.mode == 'on_time') ? 2 : 1;
    sel.setSchemeId(schemeId);
    debugPrint('🟨 [ApplyBloc] Monthly mode → schemeId=$schemeId');

    emit(state.copyWith(
      monthlyMode: event.mode,
      amountText: '',
      isValid: false,
      errorMessage: null,
    ));
  }

  void _onAmountChanged(AmountChanged event, Emitter<ProductApplyState> emit) {
    final txt = event.amountText.trim();
    final parsed = double.tryParse(txt);
    final valid = (parsed != null && parsed > 0.0);

    emit(state.copyWith(
      amountText: event.amountText,
      isValid: valid,
      errorMessage: null,
    ));
  }

  void _onTenureChanged(TenureChanged event, Emitter<ProductApplyState> emit) {
    if (state.tenureLocked) return;
    emit(state.copyWith(tenureMonths: event.tenureMonths, errorMessage: null));
  }

  Future<void> _onSubmit(SubmitPressed event, Emitter<ProductApplyState> emit) async {
    final selection = ProductSelectionState();

    // Require a branch selection
    if (state.selectedBranch == null) {
      emit(state.copyWith(
        errorMessage: 'Please select a branch',
        isSubmitting: false,
        submitSuccess: false,
      ));
      return;
    }

    final parsed = double.tryParse(state.amountText.trim());
    if (parsed == null || parsed <= 0) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid amount',
        isSubmitting: false,
        submitSuccess: false,
      ));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final months = selection.effectiveTenureMonths ?? state.tenureMonths;

    if (state.isFixed) {
      selection.setFixedInputs(amount: parsed, tenureMonths: months);
      debugPrint('✅ [ApplyBloc] Persisted FIXED: amount=$parsed, tenure=$months');
    } else if (state.monthlyMode == 'on_time') {
      selection.setMonthlyOnTime(principalAmount: parsed, tenureMonths: months);
      debugPrint('✅ [ApplyBloc] Persisted MONTHLY ON_TIME: principal=$parsed, tenure=$months');
    } else {
      selection.setMonthlyInstallment(installmentAmount: parsed, tenureMonths: months);
      debugPrint('✅ [ApplyBloc] Persisted MONTHLY INSTALLMENT: installment=$parsed, tenure=$months');
    }

    // ---- Call Accounts API based on product type ----
    try {
      final productTypeId = selection.productTypeId ?? (state.isFixed ? 1 : 2);
      final productCode = selection.productId;
      final branchId = selection.branchId;
      final tenure = selection.effectiveTenureMonths ?? state.tenureMonths;

      if (productCode == null || branchId == null || tenure == null) {
        throw Exception('Missing required data (product/branch/tenure)');
      }

      if (productTypeId == 1) {
        // Fixed -> Time Account
        final id = await AccountsService.createTimeAccount(
          productCode: productCode,
          productType: productTypeId,
          tenureMonths: tenure,
          amount: selection.fixedAmount ?? selection.selectedAmount ?? parsed,
          branchId: branchId,
        );
        selection.setTimeAccountId(id);
        debugPrint('🟢 Time account created: id=$id');
      } else {
        // Monthly -> Scheme Account
        final isOnTime = selection.schemeId == 2 || state.monthlyMode == 'on_time';
        final monthlyAmount = isOnTime
            ? (selection.monthlyPrincipalAmount ?? selection.selectedAmount ?? parsed)
            : (selection.monthlyInstallmentAmount ?? selection.selectedAmount ?? parsed);

        final id = await AccountsService.createSchemeAccount(
          schemeId: selection.schemeId ?? (isOnTime ? 2 : 1),
          productCode: productCode,
          productType: productTypeId,
          tenureMonths: tenure,
          branchId: branchId,
          monthlyDeposit: monthlyAmount,
        );
        selection.setSchemeAccountId(id);
        debugPrint('🟢 Scheme account created: id=$id');
      }

      // Freeze a snapshot of the product selection for the signup flow
      SignupState().attachProductSelection(selection.toApiJson());
      debugPrint('🧾 [ApplyBloc] Final payload: ${selection.toApiJson()}');

      emit(state.copyWith(isSubmitting: false, submitSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        submitSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
