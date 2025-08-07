// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/model/product_model.dart';
// import 'package:flutter/material.dart';

// class ProductCardWidget extends StatelessWidget {
//   final ProductModel product;

//   const ProductCardWidget({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         title: Text(
//           product.name,
//           style: Theme.of(context).textTheme.labelLarge,
//         ),
//         trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
//         onTap: () {
//           Navigator.pushNamed(
//             context,
//             AppRoute.productDetail,
//             arguments: product,
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          product.name,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        onTap: () {
          // Save selection globally
          ProductSelectionState().setProductDetails(
            id: product.productCode, // product_code as string
            name: product.name,
            description: product.description,
          );

          Navigator.pushNamed(
            context,
            AppRoute.productDetail,
            arguments: product,
          );
        },
      ),
    );
  }
}
