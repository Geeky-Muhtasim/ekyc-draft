// class ProductModel {
//   final String id;
//   final String name;
//   final String description;
//   final List<String> features;

//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.features,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id']?.toString() ?? '',
//       name: json['name']?.toString() ?? '',
//       description: json['description']?.toString() ?? '',
//       features: (json['features'] as List<dynamic>?)
//               ?.map((item) => item.toString())
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'features': features,
//     };
//   }
// }
// class ProductModel {
//   final String id;
//   final String name;
//   final String description;
//   final List<String> features;

//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.features,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id']?.toString() ?? '',
//       name: json['name']?.toString() ?? '',
//       description: json['description']?.toString() ?? '',
//       features: (json['features'] as List<dynamic>?)
//               ?.map((e) => e.toString())
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'features': features,
//     };
//   }
// }


class ProductModel {
  final int productCode;
  final int productType;
  final String serviceTypeId;
  final String name;
  final String description;

  ProductModel({
    required this.productCode,
    required this.productType,
    required this.serviceTypeId,
    required this.name,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productCode: (json['product_code'] as int?) ?? 0,
      productType: (json['product_type'] as int?) ?? 0,
      serviceTypeId: json['service_type_id']?.toString() ?? '',
      name: json['productname']?.toString() ?? '',
      description: json['productdesc']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_code': productCode,
      'product_type': productType,
      'service_type_id': serviceTypeId,
      'productname': name,
      'productdesc': description,
    };
  }
}
