abstract class ProductDetailEvent {}

/// Load product detail by productId (productCode)
class LoadProductDetailEvent extends ProductDetailEvent {
  final int productId;
  LoadProductDetailEvent({required this.productId});
}
