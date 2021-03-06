import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Function onPressed;
  bool showProgress;
  AppButton(
    this.onPressed, {
    Key? key,
    this.text,
    this.showProgress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) return Colors.red;
          return Colors.red;
        })),
        child: showProgress
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                text.toString(),
                style: const TextStyle(color: Colors.white),
              ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
