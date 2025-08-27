import 'package:bangladesh_finance_ekyc/model/product_model.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductModel product;
  ProductDetailLoaded({required this.product});
}

class ProductDetailError extends ProductDetailState {
  final String message;
  ProductDetailError({required this.message});
}
