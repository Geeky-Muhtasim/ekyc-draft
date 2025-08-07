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
//   final String categoryType;
//   final String subCategoryType;

//   const ProductListPage({
//     super.key,
//     required this.categoryType,
//     required this.subCategoryType,
//   });

//   static Widget builder(BuildContext context, String categoryType, {required String categoryType, required String subCategoryType}) {
//     return BlocProvider(
//       create: (_) => ProductListBloc()..add(LoadProductListEvent(categoryType: categoryType, subCategoryType: subCategoryType)),
//       child: ProductListPage(categoryType: categoryType, subCategoryType: subCategoryType),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$subCategoryType Products'),
//         backgroundColor: ColorConstant.primary,
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: AppStyle.paddingAllMedium,
//           child: BlocBuilder<ProductListBloc, ProductListState>(
//             builder: (context, state) {
//               if (state is ProductListLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is ProductListLoaded) {
//                 return ListView.builder(
//                   itemCount: state.products.length,
//                   itemBuilder: (context, index) {
//                     final product = state.products[index];
//                     return ProductCardWidget(product: product);
//                   },
//                 );
//               } else if (state is ProductListError) {
//                 return Center(child: Text(state.message));
//               } else {
//                 return const Center(child: Text('No data found.'));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/home/product_list/bloc/product_list_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/home/product_list/bloc/product_list_event.dart';
import 'package:bangladesh_finance_ekyc/feature/home/product_list/bloc/product_list_state.dart';
import 'package:bangladesh_finance_ekyc/widget/common/product_card_widget.dart';
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  static Widget builder(BuildContext context) {
    final selection = ProductSelectionState();

    // Fallback check
    if (selection.serviceTypeId == null || selection.productTypeId == null) {
      return const Scaffold(
        body: Center(child: Text("Missing selection info. Please go back.")),
      );
    }

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

  @override
  Widget build(BuildContext context) {
    final selection = ProductSelectionState();
    final typeLabel = selection.productTypeId == 1 ? 'Fixed' : 'Monthly';

    return WillPopScope(
      onWillPop: () async {
        // Don't reset singleton state on back
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('$typeLabel Deposit Products'),
          backgroundColor: ColorConstant.primary,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: AppStyle.paddingAllMedium,
            child: BlocBuilder<ProductListBloc, ProductListState>(
              builder: (context, state) {
                if (state is ProductListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductListLoaded) {
                  if (state.products.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductCardWidget(product: product);
                    },
                  );
                } else if (state is ProductListError) {
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
}
