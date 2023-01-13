import 'package:arrivo_flutter/controllers/user.controller.dart';
import 'package:arrivo_flutter/widgets/post-list.page.dart';
import 'package:arrivo_flutter/providers/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  static const String route = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = Navigator.of(context);
    final loginController = ref.read(userControllerProvider);

    // ref.listen(userProvider, (previous, next) {
    //   if (next != null) {
    //     navigator.pushReplacementNamed(PostList.route);
    //   }
    // });

    return Scaffold(
        appBar: AppBar(
          title: const Text("Arrivo"),
        ),
        body: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: () async {
                final user = await loginController.loginAndGetUser();
                if (user != null) {
                  navigator.pushReplacementNamed(PostList.route);
                }
              },
              child: const Text("Login"),
            ),
          ),
        ));
  }
}
