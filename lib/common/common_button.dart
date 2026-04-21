import 'package:flutter/material.dart';

import '../common/common_text_style.dart';
import '../common/responsive.dart';
import '../config/appColor.dart';

Widget buildElevatedButton({
  required BuildContext context,
  Key? key,
  required String text,
  required VoidCallback? onPressed,
  bool isLoading = false,
  Color? backgroundColor,
  Color? disabledBackgroundColor,
  EdgeInsetsGeometry? padding,
  BorderRadiusGeometry? borderRadius,
  TextStyle? textStyle,
}) {
  final scale = context.responsiveScale;
  return SizedBox(
    height: 50 * scale,
    child: ElevatedButton(
      key: key,
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.symmetric(vertical: 12 * scale),
        backgroundColor: backgroundColor ?? const Color(0xFF3629B7),
        disabledBackgroundColor: disabledBackgroundColor ?? AppColor.cF2F1F9,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(18 * scale),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 20 * scale,
              width: 20 * scale,
              child: const CircularProgressIndicator(
                strokeWidth: 2.2,
                color: Colors.white,
              ),
            )
          : Text(
              text,
              style: textStyle ?? AppTextStyle.buttonLabel.copyWith(fontSize: context.sp(16)),
            ),
    ),
  );
}