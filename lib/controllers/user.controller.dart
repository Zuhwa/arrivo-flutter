import 'package:arrivo_flutter/api/api.dart';
import 'package:arrivo_flutter/api/user.model.dart';
import 'package:arrivo_flutter/providers/user.provider.dart';
import 'package:auth0_flutter_web/auth0_flutter_web.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userControllerProvider = Provider((ref) {
  return UserController(ref);
});

class UserController {
  final Ref ref;
  final client = RestClient(Dio());

  UserController(this.ref);

  Future<String> getAccessToken() async {
    Auth0 auth0 = await createAuth0Client(Auth0ClientOptions(
      domain: "dev-trv811e3dq6xv1zm.us.auth0.com",
      client_id: "WJZkqyAidlRINvYXywuQsSwtJ5C6iPA3",
    ));

    final token = await auth0.getTokenWithPopup(options: GetTokenWithPopupOptions());
    final response = await client.login(LoginRequest(token: token));

    final prefs = await SharedPreferences.getInstance();
    final bearerToken = "Bearer ${response.accessToken}";
    await prefs.setString('token', bearerToken);

    return bearerToken;
  }

  Future<User?> loginAndGetUser() async {
    await getAccessToken();
    final user = await getCurrentUser();
    if (user != null) {
      ref.read(userProvider.notifier).set(user);
    }
    return user;
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await client.getCurrentUser(prefs.getString('token')!);
    return response;
  }

  void logout() async {
    Auth0 auth0 = await createAuth0Client(Auth0ClientOptions(
      domain: "dev-trv811e3dq6xv1zm.us.auth0.com",
      client_id: "WJZkqyAidlRINvYXywuQsSwtJ5C6iPA3",
    ));

    auth0.logout();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
