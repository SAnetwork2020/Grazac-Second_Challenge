import 'package:flutter/material.dart';
TextField customNumText(String text, TextEditingController controller) {
  return TextField(
    keyboardType: const TextInputType.numberWithOptions(decimal:
    true),
    controller: controller,
    decoration:  InputDecoration(
      labelText: text,
    ),
  );
}
TextField customText(String text, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
    ),
  );
}
