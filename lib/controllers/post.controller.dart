import 'package:arrivo_flutter/api/api.dart';
import 'package:arrivo_flutter/api/post.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final postControllerProvider = Provider((ref) {
  return PostController(ref);
});

class PostController {
  final Ref ref;
  final client = RestClient(Dio());

  PostController(this.ref);

  Future<List<PostResponse>> getPosts() async {
    final prefs = await SharedPreferences.getInstance();
    return await client.getPosts(prefs.getString('token')!);
  }

  Future<PostResponse> getPost(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return await client.getPostById(prefs.getString('token')!, id);
  }

  Future<PostResponse> createPost({
    required String title,
    required String body,
    required String categoryId,
    required String status,
    required String label,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return await client.createPost(
      prefs.getString('token')!,
      CreatePostRequest(
        title: title,
        body: body,
        categoryId: categoryId,
        status: status,
        label: label,
      ),
    );
  }

  Future<PostResponse> patchPost(
    String postId, {
    String? title,
    String? body,
    String? categoryId,
    String? status,
    String? label,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return await client.patchPost(
      prefs.getString('token')!,
      postId,
      PatchPostRequest(
        title: title,
        body: body,
        categoryId: categoryId,
        status: status,
        label: label,
      ),
    );
  }
}
