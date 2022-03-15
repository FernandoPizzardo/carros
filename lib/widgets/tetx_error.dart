import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  final String error;
  Function()? onPressed;
  TextError(this.error, {this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          error,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
