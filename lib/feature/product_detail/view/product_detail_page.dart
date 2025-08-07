// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/model/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart'; // 👈 Add this import at the top

// class ProductDetailPage extends StatelessWidget {
//   final ProductModel product;

//   const ProductDetailPage({super.key, required this.product});

//   static Widget builder(BuildContext context, ProductModel product) {
//     return ProductDetailPage(product: product);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstant.foreground,
//       appBar: AppBar(
//         title: Text(
//           product.name,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: ColorConstant.primary,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: AppStyle.paddingAllMedium,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Html(
//                     data: product.description,
//                     style: {
//                       "body": Style(
//                         fontSize: FontSize(16),
//                         color: Colors.black87,
//                         fontFamily: 'Calibri',
//                       ),
//                       "p": Style(
//                         margin: Margins.only(bottom: 12),
//                       ),
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: ColorConstant.primary),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: const Text(
//                         'Back',
//                         style: TextStyle(
//                           color: ColorConstant.primary,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () =>
//                           Navigator.pushNamed(context, AppRoute.mobileNo),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ColorConstant.primary,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: const Text(
//                         'Proceed',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  static Widget builder(BuildContext context, ProductModel product) {
    // ✅ Save selected product to global state using defined setter
    ProductSelectionState().setProductDetails(
      id: product.productCode,
      name: product.name,
      description: product.description,
    );

    return ProductDetailPage(product: product);
  }

  @override
  Widget build(BuildContext context) {
    // 🔍 Print current selection state (for debug/logging)
    debugPrint("📦 Current ProductSelectionState: ${ProductSelectionState()}");

    return Scaffold(
      backgroundColor: ColorConstant.foreground,
      appBar: AppBar(
        title: Text(
          product.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppStyle.paddingAllMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Html(
                    data: product.description.isNotEmpty
                        ? product.description
                        : "<p>No description provided.</p>",
                    style: {
                      "body": Style(
                        fontSize: FontSize(16),
                        color: Colors.black87,
                        fontFamily: 'Calibri',
                      ),
                      "p": Style(
                        margin: Margins.only(bottom: 12),
                      ),
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorConstant.primary),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: ColorConstant.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoute.mobileNo),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
