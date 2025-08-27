// import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/product_list/bloc/product_list_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/product_list/bloc/product_list_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/product_list/bloc/product_list_state.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/product_card_widget.dart';
// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/model/product_model.dart';

// class ProductListPage extends StatelessWidget {
//   const ProductListPage({super.key});

//   static Widget builder(BuildContext context) {
//     final selection = ProductSelectionState();

//     // Fallback check
//     if (selection.serviceTypeId == null || selection.productTypeId == null) {
//       return const Scaffold(
//         body: Center(child: Text("Missing selection info. Please go back.")),
//       );
//     }

//     return BlocProvider(
//       create: (_) => ProductListBloc()
//         ..add(
//           LoadProductListEvent(
//             serviceTypeId: selection.serviceTypeId!,
//             productTypeId: selection.productTypeId!,
//           ),
//         ),
//       child: const ProductListPage(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selection = ProductSelectionState();
//     final typeLabel = selection.productTypeId == 1 ? 'Fixed' : 'Monthly';

//     return WillPopScope(
//       onWillPop: () async {
//         // Don't reset singleton state on back
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('$typeLabel Deposit Products'),
//           backgroundColor: ColorConstant.primary,
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: AppStyle.paddingAllMedium,
//             child: BlocBuilder<ProductListBloc, ProductListState>(
//               builder: (context, state) {
//                 if (state is ProductListLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is ProductListLoaded) {
//                   if (state.products.isEmpty) {
//                     return const Center(child: Text('No products found.'));
//                   }
//                   return ListView.builder(
//                     itemCount: state.products.length,
//                     itemBuilder: (context, index) {
//                       final product = state.products[index];
//                       return ProductCardWidget(product: product);
//                     },
//                   );
//                 } else if (state is ProductListError) {
//                   return Center(child: Text(state.message));
//                 } else {
//                   return const Center(child: Text('No data found.'));
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';

import 'package:bangladesh_finance_ekyc/feature/home/product_list/bloc/product_list_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/home/product_list/bloc/product_list_event.dart';
import 'package:bangladesh_finance_ekyc/feature/home/product_list/bloc/product_list_state.dart';
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:bangladesh_finance_ekyc/widget/common/product_card_widget.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  static Widget builder(BuildContext context) {
    final selection = ProductSelectionState();

    // Fallback check
    if (selection.serviceTypeId == null || selection.productTypeId == null) {
      debugPrint('❗ [ProductListPage] Missing selection. $selection');
      return const Scaffold(
        body: Center(child: Text("Missing selection info. Please go back.")),
      );
    }

    debugPrint('➡️ [ProductListPage] Building with '
        'serviceTypeId=${selection.serviceTypeId}, productTypeId=${selection.productTypeId}');

    return BlocProvider(
      create: (_) => ProductListBloc()
        ..add(
          LoadProductListEvent(
            serviceTypeId: selection.serviceTypeId!,
            productTypeId: selection.productTypeId!,
          ),
        ),
      child: const ProductListPage(),
    );
  }

  void _onTapProduct(BuildContext context, ProductModel product) {
    final s = ProductSelectionState();

    // Persist details immediately
    s.setProductDetails(
      id: product.productCode,
      name: product.name,
      description: product.description,
    );

    // Lock tenure ONLY for Fixed; otherwise ensure no stale lock
    final typeId = s.productTypeId ?? product.productType;
    if (typeId == 1) {
      s.lockTenureFromNameIfPresent();
    } else {
      s.unlockTenure();
    }

    // Debug dump
    debugPrint('🟩 [ProductListPage] Persisted tapped product: code=${product.productCode}, name=${product.name}');
    _dumpSelection();

    // Navigate to detail (detail page also re-persists safely — harmless duplicate)
    Navigator.pushNamed(context, AppRoute.productDetail, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    final selection = ProductSelectionState();
    final typeLabel = selection.productTypeId == 1 ? 'Fixed' : 'Monthly';

    return WillPopScope(
      onWillPop: () async {
        // Do not reset singleton on back
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('$typeLabel Deposit Products'),
          foregroundColor: Colors.white,
          backgroundColor: ColorConstant.primary,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.bug_report_outlined),
              tooltip: 'Print selection',
              onPressed: () {
                debugPrint('🔎 [ProductListPage] Manual dump of ProductSelectionState:');
                _dumpSelection();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Printed ProductSelectionState to console')),
                );
              },
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: AppStyle.paddingAllMedium,
            child: BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
                if (state is ProductListLoading) {
                  debugPrint('🔄 [ProductListPage] Loading…');
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductListLoaded) {
                  debugPrint('✅ [ProductListPage] Loaded ${state.products.length} products.');
                  if (state.products.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      // Wrap card with tap to persist & navigate
                      return InkWell(
                        onTap: () => _onTapProduct(context, product),
                        child: ProductCardWidget(product: product),
                      );
                    },
                  );
                } else if (state is ProductListError) {
                  debugPrint('❌ [ProductListPage] Error: ${state.message}');
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No data found.'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  static void _dumpSelection() {
    final s = ProductSelectionState();
    debugPrint('— serviceTypeId: ${s.serviceTypeId} (I/C)');
    debugPrint('— productTypeId: ${s.productTypeId} (1=Fixed, 2=Monthly)');
    debugPrint('— productId: ${s.productId}');
    debugPrint('— productName: ${s.productName}');
    debugPrint('— schemeId (monthly): ${s.schemeId} (1=Installment, 2=On-time)');
    debugPrint('— tenureLockedMonths: ${s.tenureLockedMonths}');
    debugPrint('— tenureMonths (effective=${s.effectiveTenureMonths}): ${s.tenureMonths}');
    debugPrint('— fixedAmount: ${s.fixedAmount}');
    debugPrint('— monthlyPrincipalAmount: ${s.monthlyPrincipalAmount}');
    debugPrint('— monthlyInstallmentAmount: ${s.monthlyInstallmentAmount}');
    debugPrint('— selectedAmount (auto): ${s.selectedAmount}');
    debugPrint('— FULL: $s');
  }
}
