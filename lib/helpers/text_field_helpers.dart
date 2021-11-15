import 'package:flutter/material.dart';

class TextFieldHelpers {
  static InputDecoration decoration({
    required String label,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint ?? "",
    );
  }

  static InputDecoration outlineDecoration({
    required String label,
    String? hint,
  }) {
    return InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      hintText: hint ?? "",
    );
  }
}
