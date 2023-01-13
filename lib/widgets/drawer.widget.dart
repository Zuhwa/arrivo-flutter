import 'package:arrivo_flutter/controllers/payment.controller.dart';
import 'package:arrivo_flutter/controllers/user.controller.dart';
import 'package:arrivo_flutter/widgets/login.page.dart';
import 'package:arrivo_flutter/providers/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userController = ref.read(userControllerProvider);
    final paymentController = ref.read(paymentControllerProvider);
    final user = ref.watch(userProvider);

    final navigator = Navigator.of(context);

    if (user == null) return const SizedBox();

    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome back, ${user.fullName}!"),
                ],
              ),
            ),
          ),
          if (user.membership == "NORMAL" && !user.roles.contains("Admin")) ...[
            ListTile(
              title: const Text('Upgrade To Premium'),
              onTap: () async {
                final url = await paymentController.upgradeMembership();
                final uri = Uri.parse(url);
                launchUrl(uri, webOnlyWindowName: "_self");
              },
            ),
          ],
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              userController.logout();
              navigator.pushNamedAndRemoveUntil(LoginPage.route, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
