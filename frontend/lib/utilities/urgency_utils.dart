import 'package:flutter/material.dart';

Color getUrgencyColor(String? urgency) {
  switch (urgency) {
    case "Routine":
      return Colors.green;

    case "Urgent":
      return Colors.orange;

    case "Emergency":
      return Colors.red;

    default:
      return Colors.grey;
  }
}