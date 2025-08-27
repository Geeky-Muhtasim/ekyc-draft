import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bangladesh_finance_ekyc/model/product_model.dart';
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';

import 'product_detail_event.dart';
import 'product_detail_state.dart';

/// If you later switch to real API, keep the persistence below:
/// - setProductDetails(productCode/name/desc)
/// - lockTenureFromNameIfPresent() for Fixed (1), unlock for Monthly (2)
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<LoadProductDetailEvent>(_onLoad);
  }

  Future<void> _onLoad(
    LoadProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());
    try {
      // TODO: Replace with repository/API call by productCode
      await Future.delayed(const Duration(milliseconds: 400));

      // Demo product (replace fields with API response)
      final product = ProductModel(
        productCode: event.productId,
        productType: ProductSelectionState().productTypeId ?? 1, // prefer previously chosen type
        serviceTypeId: ProductSelectionState().serviceTypeId ?? 'I',
        name: 'Sample Product #${event.productId}',
        description: '<p>Sample product description with <strong>HTML</strong> content.</p>',
      );

      // 🔐 Persist to ProductSelectionState
      final sel = ProductSelectionState();
      sel.setProductDetails(
        id: product.productCode,
        name: product.name,
        description: product.description,
      );

      // Fixed: lock tenure from name (if present). Monthly: ensure unlock.
      final typeId = sel.productTypeId ?? product.productType;
      if (typeId == 1) {
        sel.lockTenureFromNameIfPresent();
      } else {
        sel.unlockTenure();
      }

      _dumpSelection('ProductDetailBloc::_onLoad (after persist)');
      emit(ProductDetailLoaded(product: product));
    } catch (e) {
      emit(ProductDetailError(message: 'Failed to load product details.'));
    }
  }

  void _dumpSelection(String label) {
    final s = ProductSelectionState();
    debugPrint('🧾 [$label]');
    debugPrint('— serviceTypeId: ${s.serviceTypeId} (I/C)');
    debugPrint('— productTypeId: ${s.productTypeId} (1=Fixed, 2=Monthly)');
    debugPrint('— productId: ${s.productId}');
    debugPrint('— productName: ${s.productName}');
    debugPrint('— tenureLockedMonths: ${s.tenureLockedMonths}');
    debugPrint('— tenureMonths (effective=${s.effectiveTenureMonths}): ${s.tenureMonths}');
    debugPrint('— fixedAmount: ${s.fixedAmount}');
    debugPrint('— monthlyPrincipalAmount: ${s.monthlyPrincipalAmount}');
    debugPrint('— monthlyInstallmentAmount: ${s.monthlyInstallmentAmount}');
    debugPrint('— selectedAmount: ${s.selectedAmount}');
  }
}
