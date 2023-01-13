import 'package:json_annotation/json_annotation.dart';

part 'payment.model.g.dart';

@JsonSerializable()
class PaymentResponse {
  String paymentUrl;

  PaymentResponse({required this.paymentUrl});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => _$PaymentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}
