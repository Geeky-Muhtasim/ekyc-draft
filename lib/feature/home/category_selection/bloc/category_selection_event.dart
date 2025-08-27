// abstract class CategorySelectionEvent {}

// class LoadSubCategoriesEvent extends CategorySelectionEvent {
//   final String categoryType; // "Islamic" or "Conventional"

//   LoadSubCategoriesEvent({required this.categoryType});
// }

// class SaveProductTypeEvent extends CategorySelectionEvent {
//   final int productTypeId; // 1 or 2

//   SaveProductTypeEvent({required this.productTypeId});
// }
abstract class CategorySelectionEvent {}

class LoadSubCategoriesEvent extends CategorySelectionEvent {
  final String categoryType; // "Islamic" or "Conventional"
  LoadSubCategoriesEvent({required this.categoryType});
}

class SaveProductTypeEvent extends CategorySelectionEvent {
  final int productTypeId; // 1 or 2
  SaveProductTypeEvent({required this.productTypeId});
}
