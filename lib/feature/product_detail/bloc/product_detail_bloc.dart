import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<LoadProductDetailEvent>((event, emit) async {
      emit(ProductDetailLoading());

      try {
        // Simulate fetching product details by productCode (replace with real API later)
        await Future.delayed(const Duration(seconds: 1));

        final product = ProductModel(
          productCode: event.productId,
          productType: 1,
          serviceTypeId: 'I',
          name: 'Sample Product Name',
          description: '<p>Sample product description with HTML content.</p>',
        );

        emit(ProductDetailLoaded(product: product));
      } catch (e) {
        emit(ProductDetailError(message: 'Failed to load product details.'));
      }
    });
  }
}
