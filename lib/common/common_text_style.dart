import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practise/config/appColor.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle get appBarTitle => GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );


  static TextStyle get appBarBlackTitle => GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get heading => GoogleFonts.poppins(
        color: AppColor.primaryColor,
        fontSize: 26,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get title => GoogleFonts.poppins(
    color: AppColor.black,
    fontSize: 14,
  );

  static TextStyle get whiteTitle => GoogleFonts.poppins(
    color: AppColor.white,
    fontSize: 14,
  );

  static TextStyle get subtitle => GoogleFonts.poppins(
        color: const Color(0xFF666E8A),
        fontSize: 13,
      );

  static TextStyle get body => GoogleFonts.poppins(
        color: const Color(0xFF191B28),
        fontSize: 14,
      );

  static TextStyle get bodyGray => GoogleFonts.poppins(
        color: const Color(0xFF666E8A),
        fontSize: 14,
      );

  static TextStyle get buttonLabel => GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get link => GoogleFonts.poppins(
        color: const Color(0xFF3629B7),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        color: const Color(0xFF999EB7),
        fontSize: 12,
      );

  static TextStyle get inputHint => GoogleFonts.poppins(
        color: const Color(0xFF999EB7),
        fontSize: 14,
      );

  static TextStyle get inputText => GoogleFonts.poppins(
        color: const Color(0xFF191B28),
        fontSize: 14,
      );
}
