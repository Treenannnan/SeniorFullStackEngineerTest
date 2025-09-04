import 'package:flutter/material.dart';

Widget squareIconButton(IconData icon, VoidCallback onTap, double size,  Color color) {
  return SizedBox(
    width: size,
    height: size,
    child: IconButton(
      color: color,
      icon: Icon(icon),
      onPressed: onTap,
      padding: EdgeInsets.zero, 
      iconSize: 22,
      splashRadius: 18,
    ),
  );
}