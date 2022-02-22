import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  AppButton({
    Key? key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) return Colors.indigo;
          return Colors.indigo;
        })),
        child: Text(
          text!,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        onPressed: onPressed!(),
      ),
    );
  }
}
