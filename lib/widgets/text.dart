import 'package:flutter/material.dart';

Text text(
  String s, {
  double fontSize = 16,
  color = Colors.black,
  bold = false,
}) {
  return Text(
    s,
    textAlign: TextAlign.justify,
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
