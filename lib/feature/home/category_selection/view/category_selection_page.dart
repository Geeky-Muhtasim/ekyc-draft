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
      create: (_) => CategorySelectionBloc()
        ..add(LoadSubCategoriesEvent(categoryType: categoryType)),
      child: CategorySelectionPage(categoryType: categoryType),
    );
  }

  void _navigateToProducts(BuildContext context, String subCategoryKey) {
    int productTypeId = subCategoryKey == 'Fixed' ? 1 : 2;

    // Save selected product type globally
    ProductSelectionState().setProductTypeId(productTypeId);

    Navigator.pushNamed(
      context,
      AppRoute.productList,
      arguments: {
        'serviceTypeId': ProductSelectionState().serviceTypeId,
        'productTypeId': productTypeId,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.foreground,
      appBar: AppBar(
        title: Text(
          '${categoryType[0].toUpperCase()}${categoryType.substring(1)} Products',
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppStyle.paddingAllMedium,
          child: BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
            builder: (context, state) {
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        leading: Icon(
                          subCategory.icon,
                          color: ColorConstant.primary,
                        ),
                        title: Text(
                          subCategory.name,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.primary,
                              ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ),
                        onTap: () => _navigateToProducts(context, subCategory.key),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No subcategories found.'));
              }
            },
          ),
        ),
      ),
    );
  }
}
