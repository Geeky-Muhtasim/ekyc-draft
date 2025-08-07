class ProductSelectionState {
  static final ProductSelectionState _instance = ProductSelectionState._internal();

  factory ProductSelectionState() => _instance;

  ProductSelectionState._internal();

  String? _serviceTypeId; // "I" or "C"
  int? _productTypeId; // 1 or 2
  int? _productId;
  String? _productName;
  String? _productDescription;

  // Getters
  String? get serviceTypeId => _serviceTypeId;
  int? get productTypeId => _productTypeId;
  int? get productId => _productId;
  String? get productName => _productName;
  String? get productDescription => _productDescription;

  // Setters
  void setServiceTypeId(String value) => _serviceTypeId = value;
  void setProductTypeId(int value) => _productTypeId = value;
  void setProductDetails({required int id, required String name, required String description}) {
    _productId = id;
    _productName = name;
    _productDescription = description;
  }

  // Clear everything
  void reset() {
    _serviceTypeId = null;
    _productTypeId = null;
    _productId = null;
    _productName = null;
    _productDescription = null;
  }

  @override
  String toString() {
    return 'ProductSelectionState('
        'serviceTypeId: $_serviceTypeId, '
        'productTypeId: $_productTypeId, '
        'productId: $_productId, '
        'name: $_productName)';
  }
}
