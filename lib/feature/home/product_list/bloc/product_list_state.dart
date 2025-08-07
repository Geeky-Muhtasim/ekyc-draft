import 'package:equatable/equatable.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';

abstract class ProductListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<ProductModel> products;

  ProductListLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductListError extends ProductListState {
  final String message;

  ProductListError({required this.message});

  @override
  List<Object?> get props => [message];
}
