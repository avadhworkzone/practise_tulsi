import 'package:flutter/material.dart';

import '../common/common_text_style.dart';
import '../common/responsive.dart';

Widget buildTextField({
  required BuildContext context,
  Key? key,
  String? label, // optional
  required String hint,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  Widget? suffix,
  required ValueChanged<String> onChanged,
}) {
  final scale = context.responsiveScale;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label != null) ...[
        Text(
          label,
          style: AppTextStyle.inputHint.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: context.sp(13),
          ),
        ),
        SizedBox(height: 6 * scale),
      ],
      SizedBox(
        height: 50 * scale,
        child: TextFormField(
          key: key,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTextStyle.inputText.copyWith(fontSize: context.sp(14)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyle.inputHint.copyWith(fontSize: context.sp(14)),
            suffixIcon: suffix,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16 * scale),
              borderSide: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16 * scale),
              borderSide: const BorderSide(color: Color(0xFF3629B7), width: 1.5),
            ),
          ),
        ),
      ),
    ],
  );
}