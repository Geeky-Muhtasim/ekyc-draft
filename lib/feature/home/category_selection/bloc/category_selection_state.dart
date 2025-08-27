// import 'package:flutter/material.dart';

// abstract class CategorySelectionState {}

// class CategorySelectionInitial extends CategorySelectionState {}

// class CategorySelectionLoading extends CategorySelectionState {}

// class CategorySelectionLoaded extends CategorySelectionState {
//   final List<SubCategoryItem> subCategories;

//   CategorySelectionLoaded({required this.subCategories});
// }

// class CategorySelectionError extends CategorySelectionState {
//   final String message;

//   CategorySelectionError({required this.message});
// }

// class CategorySelectionProductTypeSelected extends CategorySelectionState {
//   final int selectedProductType;

//   CategorySelectionProductTypeSelected({required this.selectedProductType});
// }

// class SubCategoryItem {
//   final String key;
//   final String name;
//   final IconData icon;

//   SubCategoryItem({required this.key, required this.name, required this.icon});
// }
import 'package:flutter/material.dart';

abstract class CategorySelectionState {}

class CategorySelectionInitial extends CategorySelectionState {}

class CategorySelectionLoading extends CategorySelectionState {}

class CategorySelectionLoaded extends CategorySelectionState {
  final List<SubCategoryItem> subCategories;
  CategorySelectionLoaded({required this.subCategories});
}

class CategorySelectionError extends CategorySelectionState {
  final String message;
  CategorySelectionError({required this.message});
}

class CategorySelectionProductTypeSelected extends CategorySelectionState {
  final int selectedProductType;
  CategorySelectionProductTypeSelected({required this.selectedProductType});
}

class SubCategoryItem {
  final String key;
  final String name;
  final IconData icon;
  SubCategoryItem({required this.key, required this.name, required this.icon});
}
