import 'package:arrivo_flutter/api/category.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.model.g.dart';

@JsonSerializable()
class CreatePostRequest {
  String title;
  String body;
  String status;
  String label;
  String categoryId;

  CreatePostRequest({
    required this.title,
    required this.body,
    required this.label,
    required this.status,
    required this.categoryId,
  });

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) => _$CreatePostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePostRequestToJson(this);
}

@JsonSerializable()
class PatchPostRequest {
  String? title;
  String? body;
  String? status;
  String? label;
  String? categoryId;

  PatchPostRequest({
    this.title,
    this.body,
    this.label,
    this.status,
    this.categoryId,
  });

  factory PatchPostRequest.fromJson(Map<String, dynamic> json) => _$PatchPostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchPostRequestToJson(this);
}

@JsonSerializable()
class PostResponse {
  String id;
  String title;
  String body;
  String? status;
  String label;
  Category category;

  PostResponse(
      {required this.id,
      required this.title,
      required this.body,
      this.status,
      required this.label,
      required this.category});

  factory PostResponse.fromJson(Map<String, dynamic> json) => _$PostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
