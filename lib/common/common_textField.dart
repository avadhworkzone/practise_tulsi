import 'package:flutter/material.dart';

import '../common/common_text_style.dart';

Widget buildTextField({
  required String hint,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  Widget? suffix,
  required ValueChanged<String> onChanged,
}) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyle.inputText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.inputHint,
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF3629B7), width: 1.5),
        ),
      ),
    ),
  );
}