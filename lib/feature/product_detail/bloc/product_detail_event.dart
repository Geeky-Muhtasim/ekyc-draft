abstract class ProductDetailEvent {}

class LoadProductDetailEvent extends ProductDetailEvent {
  final int productId;

  LoadProductDetailEvent({required this.productId});
}