import 'package:arrivo_flutter/api/api.dart';
import 'package:arrivo_flutter/api/category.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final categoryControllerProvider = Provider((ref) {
  return CategoryController(ref);
});

class CategoryController {
  final Ref ref;
  final client = RestClient(Dio());

  CategoryController(this.ref);

  Future<List<Category>> getCategory() async {
    return await client.getCategory();
  }
}
