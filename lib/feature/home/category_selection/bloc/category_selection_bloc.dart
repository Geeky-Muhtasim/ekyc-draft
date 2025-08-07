// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'category_selection_event.dart';
// import 'category_selection_state.dart';
// import 'package:bangladesh_finance_ekyc/core/service/product_service.dart';

// class CategorySelectionBloc extends Bloc<CategorySelectionEvent, CategorySelectionState> {
//   final ProductService _productService = ProductService();

//   // String? serviceTypeId; // Store from route
//   // int? selectedProductType;

//   CategorySelectionBloc() : super(CategorySelectionInitial()) {
//     on<LoadSubCategoriesEvent>((event, emit) async {
//       emit(CategorySelectionLoading());
//       // serviceTypeId = event.categoryType == 'Islamic' ? 'I' : 'C';

//       try {
//         final allProducts = await _productService.fetchAllProducts();
//         print('📦 All products fetched: ${allProducts.length}');

//         final filteredProducts = allProducts.where(
//           (p) => p['service_type_id'] == serviceTypeId,
//         ).toList();

//         final productTypes = filteredProducts.map((p) => p['product_type']).toSet().toList();
//         print('🧩 Unique product types for $serviceTypeId: $productTypes');

//         final subCategories = <SubCategoryItem>[];
//         if (productTypes.contains(1)) {
//           subCategories.add(SubCategoryItem(key: 'Fixed', name: 'Fixed Deposit', icon: Icons.savings));
//         }
//         if (productTypes.contains(2)) {
//           subCategories.add(SubCategoryItem(key: 'Monthly', name: 'Monthly Deposit', icon: Icons.calendar_today));
//         }

//         emit(CategorySelectionLoaded(subCategories: subCategories));
//       } catch (e) {
//         print('❌ Error fetching categories: $e');
//         emit(CategorySelectionError(message: 'Failed to load categories.'));
//       }
//     });

//     on<SaveProductTypeEvent>((event, emit) {
//       selectedProductType = event.productTypeId;
//       print('📍 Selected product type ID: $selectedProductType');
//       emit(CategorySelectionProductTypeSelected(selectedProductType: selectedProductType!));
//     });
//   }
// }

import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_selection_event.dart';
import 'category_selection_state.dart';
import 'package:bangladesh_finance_ekyc/core/service/product_service.dart';
// import 'package:bangladesh_finance_ekyc/singleton/product_selection_state.dart';

class CategorySelectionBloc extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  final ProductService _productService = ProductService();

  CategorySelectionBloc() : super(CategorySelectionInitial()) {
    on<LoadSubCategoriesEvent>((event, emit) async {
      emit(CategorySelectionLoading());

      final serviceTypeId = event.categoryType == 'Islamic' ? 'I' : 'C';
      ProductSelectionState().setServiceTypeId(serviceTypeId);

      try {
        final allProducts = await _productService.fetchAllProducts();
        final filteredProducts = allProducts.where((p) => p['service_type_id'] == serviceTypeId).toList();
        final productTypes = filteredProducts.map((p) => p['product_type']).toSet().toList();

        final subCategories = <SubCategoryItem>[];
        if (productTypes.contains(1)) {
          subCategories.add(SubCategoryItem(key: 'Fixed', name: 'Fixed Deposit', icon: Icons.savings));
        }
        if (productTypes.contains(2)) {
          subCategories.add(SubCategoryItem(key: 'Monthly', name: 'Monthly Deposit', icon: Icons.calendar_today));
        }

        emit(CategorySelectionLoaded(subCategories: subCategories));
      } catch (e) {
        emit(CategorySelectionError(message: 'Failed to load categories.'));
      }
    });

    on<SaveProductTypeEvent>((event, emit) {
      ProductSelectionState().setProductTypeId(event.productTypeId);
      emit(CategorySelectionProductTypeSelected(selectedProductType: event.productTypeId));
    });
  }
}
