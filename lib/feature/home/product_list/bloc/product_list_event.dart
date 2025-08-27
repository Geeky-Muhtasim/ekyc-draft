// import 'package:equatable/equatable.dart';

// abstract class ProductListEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class LoadProductListEvent extends ProductListEvent {
//   final String serviceTypeId; // "I" or "C"
//   final int productTypeId;    // 1 or 2

//   LoadProductListEvent({
//     required this.serviceTypeId,
//     required this.productTypeId,
//   });

//   @override
//   List<Object?> get props => [serviceTypeId, productTypeId];
// }
import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProductListEvent extends ProductListEvent {
  final String serviceTypeId; // "I" or "C"
  final int productTypeId;    // 1 or 2

  LoadProductListEvent({
    required this.serviceTypeId,
    required this.productTypeId,
  });

  @override
  List<Object?> get props => [serviceTypeId, productTypeId];
}
