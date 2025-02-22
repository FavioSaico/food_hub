import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {

  final String message;

  const EmptyList({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/imagenes/empty_list.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}