import 'package:arrivo_flutter/api/category.model.dart';
import 'package:arrivo_flutter/controllers/category.controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryFutureProvider = FutureProvider<List<Category>>((ref) async {
  try {
    final categoryController = ref.read(categoryControllerProvider);
    final category = await categoryController.getCategory();
    return category;
  } catch (e) {
    return List.empty();
  }
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryNotifier(List<Category> category) : super(category);
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  final category = ref.watch(categoryFutureProvider);
  return category.when(
    loading: () => CategoryNotifier(List.empty()),
    error: (err, stack) => CategoryNotifier(List.empty()),
    data: (data) => CategoryNotifier(data),
  );
});
