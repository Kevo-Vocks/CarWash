// payment_input.dart
import 'package:flutter/material.dart';

class PaymentInput extends StatelessWidget {
  final String? paymentMethod;
  final TextEditingController cardController;
  final TextEditingController mpesaController;

  const PaymentInput({
    Key? key,
    required this.paymentMethod,
    required this.cardController,
    required this.mpesaController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (paymentMethod == 'Visa' || paymentMethod == 'PayPal') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: cardController,
          decoration: InputDecoration(
            labelText: '$paymentMethod Card Number',
            hintText: 'Enter your card number',
            prefixIcon: const Icon(Icons.credit_card, color: Colors.blue),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          keyboardType: TextInputType.number,
        ),
      );
    } else if (paymentMethod == 'Mpesa') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: mpesaController,
          decoration: InputDecoration(
            labelText: 'Mpesa Phone Number',
            hintText: 'Enter your phone number (e.g., 254712345678)',
            prefixIcon: const Icon(Icons.phone, color: Colors.blue),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          keyboardType: TextInputType.phone,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
