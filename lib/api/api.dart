import 'package:arrivo_flutter/api/category.model.dart';
import 'package:arrivo_flutter/api/payment.model.dart';
import 'package:arrivo_flutter/api/post.model.dart';
import 'package:arrivo_flutter/api/user.model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://g5l4ib2lcd.execute-api.ap-southeast-1.amazonaws.com/dev")
// @RestApi(baseUrl: "http://localhost:3000")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/user/login")
  Future<LoginResponse> login(@Body() LoginRequest body);
  @GET("/user")
  Future<User> getCurrentUser(@Header("Authorization") String token);

  @GET("/post")
  Future<List<PostResponse>> getPosts(@Header("Authorization") String token);
  @GET("/post/{id}")
  Future<PostResponse> getPostById(@Header("Authorization") String token, @Path() String id);
  @POST("/post")
  Future<PostResponse> createPost(@Header("Authorization") String token, @Body() CreatePostRequest body);
  @PATCH("/post/{id}")
  Future<PostResponse> patchPost(
      @Header("Authorization") String token, @Path() String id, @Body() PatchPostRequest body);

  @GET("/category")
  Future<List<Category>> getCategory();

  @POST("/payment")
  Future<PaymentResponse> upgradeToPremium(@Header("Authorization") String token);
}
