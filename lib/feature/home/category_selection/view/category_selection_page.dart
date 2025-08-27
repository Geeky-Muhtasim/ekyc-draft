// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';

// import 'package:bangladesh_finance_ekyc/feature/home/category_selection/bloc/category_selection_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/category_selection/bloc/category_selection_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/category_selection/bloc/category_selection_state.dart';
// import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';

// class CategorySelectionPage extends StatelessWidget {
//   final String categoryType;
//   const CategorySelectionPage({super.key, required this.categoryType});

//   static Widget builder(BuildContext context, String categoryType) {
//     return BlocProvider(
//       create: (_) => CategorySelectionBloc()
//         ..add(LoadSubCategoriesEvent(categoryType: categoryType)),
//       child: CategorySelectionPage(categoryType: categoryType),
//     );
//   }

//   void _onTapSubCategory(BuildContext context, String key) {
//     final productTypeId = key == 'Fixed' ? 1 : 2;

//     // Pre-dispatch debug
//     debugPrint('🟡 [CategorySelectionPage] Tap: $key → productTypeId=$productTypeId');
//     debugPrint('🟡 [CategorySelectionPage] BEFORE SaveProductTypeEvent: ${ProductSelectionState()}');

//     // Persist via BLoC
//     context.read<CategorySelectionBloc>().add(SaveProductTypeEvent(productTypeId: productTypeId));
//     debugPrint('🟡 [CategorySelectionPage] Dispatched SaveProductTypeEvent($productTypeId)');

//     // Navigate to ProductList; no need to pass args—state is global
//     Navigator.pushNamed(context, AppRoute.productList);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CategorySelectionBloc, CategorySelectionState>(
//       listener: (context, state) {
//         if (state is CategorySelectionLoading) {
//           debugPrint('🔄 [CategorySelectionPage] Loading subcategories…');
//         } else if (state is CategorySelectionLoaded) {
//           debugPrint('✅ [CategorySelectionPage] Loaded ${state.subCategories.length} subcategories '
//               'for ${categoryType.toUpperCase()}');
//           _dumpSelection();
//         } else if (state is CategorySelectionProductTypeSelected) {
//           debugPrint('✅ [CategorySelectionPage] Selected productTypeId=${state.selectedProductType}');
//           _dumpSelection();
//         } else if (state is CategorySelectionError) {
//           debugPrint('❌ [CategorySelectionPage] ${state.message}');
//         }
//       },
//       child: Scaffold(
//         backgroundColor: ColorConstant.foreground,
//         appBar: AppBar(
//           title: Text('${categoryType[0].toUpperCase()}${categoryType.substring(1)} Products'),
//           centerTitle: true,
//           backgroundColor: ColorConstant.primary,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.bug_report_outlined),
//               tooltip: 'Print selection',
//               onPressed: () {
//                 debugPrint('🔎 [CategorySelectionPage] Manual dump of ProductSelectionState:');
//                 _dumpSelection();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Printed ProductSelectionState to console')),
//                 );
//               },
//             )
//           ],
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: AppStyle.paddingAllMedium,
//             child: BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
//               builder: (context, state) {
//                 if (state is CategorySelectionLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is CategorySelectionLoaded) {
//                   return ListView.separated(
//                     itemCount: state.subCategories.length,
//                     separatorBuilder: (_, __) => const SizedBox(height: 12),
//                     itemBuilder: (context, index) {
//                       final sub = state.subCategories[index];
//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         elevation: 2,
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                           leading: Icon(sub.icon, color: ColorConstant.primary),
//                           title: Text(
//                             sub.name,
//                             style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: ColorConstant.primary,
//                                 ),
//                           ),
//                           trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
//                           onTap: () => _onTapSubCategory(context, sub.key),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is CategorySelectionError) {
//                   return Center(child: Text(state.message));
//                 } else {
//                   return const Center(child: Text('No subcategories found.'));
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   static void _dumpSelection() {
//     final s = ProductSelectionState();
//     debugPrint('— serviceTypeId: ${s.serviceTypeId} (I/C)');
//     debugPrint('— productTypeId: ${s.productTypeId} (1=Fixed, 2=Monthly)');
//     debugPrint('— productId: ${s.productId}');
//     debugPrint('— productName: ${s.productName}');
//     debugPrint('— schemeId (monthly): ${s.schemeId} (1=Installment, 2=On-time)');
//     debugPrint('— tenureLockedMonths: ${s.tenureLockedMonths}');
//     debugPrint('— tenureMonths (effective=${s.effectiveTenureMonths}): ${s.tenureMonths}');
//     debugPrint('— fixedAmount: ${s.fixedAmount}');
//     debugPrint('— monthlyPrincipalAmount: ${s.monthlyPrincipalAmount}');
//     debugPrint('— monthlyInstallmentAmount: ${s.monthlyInstallmentAmount}');
//     debugPrint('— selectedAmount (auto): ${s.selectedAmount}');
//     debugPrint('— FULL: $s');
//   }
// }
// lib/feature/home/category_selection/view/category_selection_page.dart
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/feature/home/category_selection/bloc/category_selection_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/home/category_selection/bloc/category_selection_event.dart';
import 'package:bangladesh_finance_ekyc/feature/home/category_selection/bloc/category_selection_state.dart';
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelectionPage extends StatelessWidget {
  final String categoryType;

  const CategorySelectionPage({super.key, required this.categoryType});

  static Widget builder(BuildContext context, String categoryType) {
    return BlocProvider(
      create: (_) =>
          CategorySelectionBloc()..add(LoadSubCategoriesEvent(categoryType: categoryType)),
      child: CategorySelectionPage(categoryType: categoryType),
    );
  }

  void _navigateToProducts(BuildContext context, String subCategoryKey) {
    final productTypeId = subCategoryKey == 'Fixed' ? 1 : 2;
    ProductSelectionState().setProductTypeId(productTypeId);

    Navigator.pushNamed(context, AppRoute.productList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.foreground,
      appBar: AppBar(
        title: Text('${categoryType[0].toUpperCase()}${categoryType.substring(1)} Products'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ColorConstant.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppStyle.paddingAllMedium,
          child: BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
            builder: (context, state) {
              // 🔁 If we find the page back in Initial (e.g., after back),
              // schedule a reload with the same categoryType.
              if (state is CategorySelectionInitial) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  debugPrint('[CategorySelection] 🔁 Re-dispatching LoadSubCategoriesEvent("$categoryType")');
                  context
                      .read<CategorySelectionBloc>()
                      .add(LoadSubCategoriesEvent(categoryType: categoryType));
                });
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CategorySelectionLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategorySelectionLoaded) {
                return ListView.separated(
                  itemCount: state.subCategories.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final subCategory = state.subCategories[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        leading: Icon(subCategory.icon, color: ColorConstant.primary),
                        title: Text(
                          subCategory.name,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.primary,
                              ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                        onTap: () => _navigateToProducts(context, subCategory.key),
                      ),
                    );
                  },
                );
              } else if (state is CategorySelectionError) {
                return Center(child: Text(state.message));
              }

              return const Center(child: Text('No subcategories found.'));
            },
          ),
        ),
      ),
    );
  }
}
