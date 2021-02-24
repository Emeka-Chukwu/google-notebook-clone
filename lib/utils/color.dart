import 'package:flutter/material.dart';

Color categoryColor(int index) {
  Color color;
  switch (index) {
    case 1:
      color = Colors.purple;
      break;
    case 2:
      color = Colors.orange;
      break;
    case 3:
      color = Colors.blue;
      break;
    case 4:
      color = Colors.yellow[900];
      break;
    case 5:
      color = Colors.green;
      break;
    default:
      color = Colors.purple;
      break;
  }

  return color;
}
