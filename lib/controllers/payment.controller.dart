import 'package:arrivo_flutter/api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final paymentControllerProvider = Provider((ref) {
  return PaymentController(ref);
});

class PaymentController {
  final Ref ref;
  final client = RestClient(Dio());

  PaymentController(this.ref);

  Future<String> upgradeMembership() async {
    final prefs = await SharedPreferences.getInstance();
    final resp = await client.upgradeToPremium(prefs.getString('token')!);
    return resp.paymentUrl;
  }
}
