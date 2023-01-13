// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostRequest _$CreatePostRequestFromJson(Map<String, dynamic> json) =>
    CreatePostRequest(
      title: json['title'] as String,
      body: json['body'] as String,
      label: json['label'] as String,
      status: json['status'] as String,
      categoryId: json['categoryId'] as String,
    );

Map<String, dynamic> _$CreatePostRequestToJson(CreatePostRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'status': instance.status,
      'label': instance.label,
      'categoryId': instance.categoryId,
    };

PatchPostRequest _$PatchPostRequestFromJson(Map<String, dynamic> json) =>
    PatchPostRequest(
      title: json['title'] as String?,
      body: json['body'] as String?,
      label: json['label'] as String?,
      status: json['status'] as String?,
      categoryId: json['categoryId'] as String?,
    );

Map<String, dynamic> _$PatchPostRequestToJson(PatchPostRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'status': instance.status,
      'label': instance.label,
      'categoryId': instance.categoryId,
    };

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      status: json['status'] as String?,
      label: json['label'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'status': instance.status,
      'label': instance.label,
      'category': instance.category,
    };
