import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';

class BoldNormalText extends StatelessWidget {
  final String label;
  final String value;
  final double? size;

  const BoldNormalText({
    super.key,
    required this.label,
    required this.value,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: size,
            fontWeight: FontWeight.bold,
            color: AppColors.mainBlackColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: size,
              fontWeight: FontWeight.normal,
              color: AppColors.mainBlackColor,
            ),
          ),
        ),
      ],
    );
  }
}
