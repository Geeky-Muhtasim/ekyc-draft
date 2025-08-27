// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'product_list_event.dart';
// import 'product_list_state.dart';
// import 'package:bangladesh_finance_ekyc/core/service/product_service.dart';
// import 'package:bangladesh_finance_ekyc/model/product_model.dart';

// class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
//   final ProductService _productService = ProductService();

//   ProductListBloc() : super(ProductListInitial()) {
//     on<LoadProductListEvent>(_onLoadProducts);
//   }

//   Future<void> _onLoadProducts(
//     LoadProductListEvent event,
//     Emitter<ProductListState> emit,
//   ) async {
//     emit(ProductListLoading());

//     try {
//       final allProducts = await _productService.fetchAllProducts();

//       final filtered = allProducts.where((p) =>
//         p['service_type_id'] == event.serviceTypeId &&
//         p['product_type'] == event.productTypeId).toList();

//       final products = filtered.map((p) {
//         return ProductModel(
//           productCode: int.tryParse(p['product_code'].toString()) ?? 0,
//           name: (p['productname'] ?? '').toString(),
//           description: (p['productdesc'] ?? '').toString(),
//           serviceTypeId: (p['service_type_id'] ?? '').toString(),
//           productType: int.tryParse(p['product_type'].toString()) ?? 0,
//         );
//       }).toList();

//       emit(ProductListLoaded(products: products));
//     } catch (e) {
//       emit(ProductListError(message: 'Failed to load products'));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';
import 'package:bangladesh_finance_ekyc/core/service/product_service.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductService _productService = ProductService();

  ProductListBloc() : super(ProductListInitial()) {
    on<LoadProductListEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(ProductListLoading());

    try {
      final allProducts = await _productService.fetchAllProducts();
      // Debug
      // ignore: avoid_print
      print('📦 [ProductListBloc] Total products fetched: ${allProducts.length}');

      final filtered = allProducts.where((p) =>
        p['service_type_id'] == event.serviceTypeId &&
        p['product_type'] == event.productTypeId).toList();

      // Debug
      // ignore: avoid_print
      print('🔍 [ProductListBloc] Filtered for service=${event.serviceTypeId}, '
          'type=${event.productTypeId} → ${filtered.length} items');

      final products = filtered.map((p) {
        return ProductModel(
          productCode: int.tryParse(p['product_code'].toString()) ?? 0,
          name: (p['productname'] ?? '').toString(),
          description: (p['productdesc'] ?? '').toString(),
          serviceTypeId: (p['service_type_id'] ?? '').toString(),
          productType: int.tryParse(p['product_type'].toString()) ?? 0,
        );
      }).toList();

      emit(ProductListLoaded(products: products));
    } catch (e) {
      // ignore: avoid_print
      print('❌ [ProductListBloc] Failed to load products: $e');
      emit(ProductListError(message: 'Failed to load products'));
    }
  }
}
