import 'package:flutter/material.dart';

class PaymentDetails extends StatelessWidget {
  final double subtotal;
  // final double shippingCost;

  const PaymentDetails({
    super.key,
    required this.subtotal,
    // required this.shippingCost,
  });

  @override
  Widget build(BuildContext context) {
    // final total = subtotal + shippingCost;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Detalles de pago',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          // const SizedBox(height: 16),
          // _PaymentRow(
          //   label: 'Subtotal',
          //   amount: subtotal,
          // ),
          const SizedBox(height: 8),
          // _PaymentRow(
          //   label: 'Costo de envío',
          //   amount: shippingCost,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 12),
          //   child: Divider(),
          // ),
          _PaymentRow(
            label: 'Total',
            amount: subtotal,
            isBold: true,
          ),
          // const SizedBox(height: 16),
          
        ],
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isBold;

  const _PaymentRow({
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