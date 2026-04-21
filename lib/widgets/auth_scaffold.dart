import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:practise/config/appColor.dart';
import 'package:practise/config/appImage.dart';

import '../common/common_text_style.dart';

class AuthScaffold extends StatelessWidget {
  final String title;
  final String? image;
  final Color? appColor;
  final Color? textColor;
  final Widget body;
  final Widget? action;
  final bool showBackButton;

  const AuthScaffold({
    super.key,
    required this.title,
    this.image,
    this.action,
    this.appColor = AppColor.primaryColor,
    this.textColor = AppColor.white,
    this.showBackButton = true,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor:appColor,
        ),
        child: Stack(
          children: [
            Container(
              height: Get.height,
              color: appColor,
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: Row(
                  children: [
                    if (showBackButton)
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios_rounded, color: textColor),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                      ),
                    if(image!=null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12,right: 12),
                        child: CircleAvatar(
                            backgroundColor: AppColor.white,
                            foregroundColor: AppColor.gray,
                            backgroundImage: NetworkImage(image??''),)
                      ),
                    if (showBackButton) const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: textColor == AppColor.black ? AppTextStyle.appBarBlackTitle : AppTextStyle.appBarTitle,
                      ),
                    ),

                   action ?? SizedBox.shrink()
                  ],
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(34),
                    topRight: Radius.circular(34),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 18,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}