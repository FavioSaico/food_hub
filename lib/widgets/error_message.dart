import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {

  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {

    return Center(
      heightFactor: 4,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cancel,color: Colors.deepOrange, size: 60,),
          const SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}