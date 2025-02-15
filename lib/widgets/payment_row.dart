import 'package:flutter/material.dart';

class PaymentRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isBold;

  const PaymentRow({
    super.key,
    required this.label,
    required this.amount,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16,
      fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle),
        Text(
          'S/. ${amount.toStringAsFixed(2)}',
          style: textStyle,
        ),
      ],
    );
  }
}