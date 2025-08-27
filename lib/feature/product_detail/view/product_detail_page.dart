// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/model/product_model.dart';
// import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';

// class ProductDetailPage extends StatelessWidget {
//   final ProductModel product;

//   const ProductDetailPage({super.key, required this.product});

//   static Widget builder(BuildContext context, ProductModel product) {
//     final selection = ProductSelectionState();

//     // Save selected product info
//     selection.setProductDetails(
//       id: product.productCode,
//       name: product.name,
//       description: product.description,
//     );

//     // 👉 Lock tenure from name ONLY for Fixed Deposit (1 = Fixed, 2 = Monthly)
//     //    We prefer the productType set earlier from subcategory, but if missing
//     //    we fallback to product.productType.
//     final productTypeId = selection.productTypeId ?? product.productType;
//     if (productTypeId == 1) {
//       selection.lockTenureFromNameIfPresent();
//     } else {
//       // Make sure monthly products do NOT carry a stale lock
//       selection.unlockTenure();
//     }

//     return ProductDetailPage(product: product);
//   }

//   @override
//   Widget build(BuildContext context) {
//     debugPrint("📦 ProductSelectionState @Detail: ${ProductSelectionState()}");

//     return Scaffold(
//       backgroundColor: ColorConstant.foreground,
//       appBar: AppBar(
//         title: Text(
//           product.name,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//           overflow: TextOverflow.ellipsis,
//           maxLines: 1,
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
//                     data: product.description.isNotEmpty
//                         ? product.description
//                         : "<p>No description provided.</p>",
//                     style: {
//                       "body": Style(
//                         fontSize: FontSize(16),
//                         color: Colors.black87,
//                         fontFamily: 'Calibri',
//                       ),
//                       "p": Style(margin: Margins.only(bottom: 12)),
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
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
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
//                           Navigator.pushNamed(context, AppRoute.productApply),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ColorConstant.primary,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
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
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;
  const ProductDetailPage({super.key, required this.product});

  /// Called by router with a ProductModel from the list page
  static Widget builder(BuildContext context, ProductModel product) {
    final selection = ProductSelectionState();

    // Persist product data immediately
    selection.setProductDetails(
      id: product.productCode,
      name: product.name,
      description: product.description,
    );

    // Lock tenure ONLY for Fixed; unlock for Monthly to avoid stale locks
    final productTypeId = selection.productTypeId ?? product.productType;
    if (productTypeId == 1) {
      selection.lockTenureFromNameIfPresent();
    } else {
      selection.unlockTenure();
    }

    _dumpSelection('ProductDetailPage::builder (after persist)');
    return ProductDetailPage(product: product);
  }

  static void _dumpSelection(String label) {
    final s = ProductSelectionState();
    debugPrint('🧾 [$label]');
    debugPrint('— serviceTypeId: ${s.serviceTypeId} (I/C)');
    debugPrint('— productTypeId: ${s.productTypeId} (1=Fixed, 2=Monthly)');
    debugPrint('— productId: ${s.productId}');
    debugPrint('— productName: ${s.productName}');
    debugPrint('— tenureLockedMonths: ${s.tenureLockedMonths}');
    debugPrint('— tenureMonths (effective=${s.effectiveTenureMonths}): ${s.tenureMonths}');
    debugPrint('— fixedAmount: ${s.fixedAmount}');
    debugPrint('— monthlyPrincipalAmount: ${s.monthlyPrincipalAmount}');
    debugPrint('— monthlyInstallmentAmount: ${s.monthlyInstallmentAmount}');
    debugPrint('— selectedAmount: ${s.selectedAmount}');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("📦 ProductSelectionState @Detail build: ${ProductSelectionState()}");

    return Scaffold(
      backgroundColor: ColorConstant.foreground,
      
      appBar: AppBar(
        title: Text(
          product.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            tooltip: 'Print selection',
            onPressed: () => _dumpSelection('ProductDetailPage::AppBar action'),
          ),
        ],
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
                      "p": Style(margin: Margins.only(bottom: 12)),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
                      onPressed: () {
                        _dumpSelection('ProductDetailPage::Proceed pressed');
                        Navigator.pushNamed(context, AppRoute.productApply);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
