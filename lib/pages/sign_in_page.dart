import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practise/common/common_button.dart';
import 'package:practise/common/common_text_field.dart';
import 'package:practise/common/common_text_style.dart';
import 'package:practise/config/appImage.dart';

import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Sign in',
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back',
              style: AppTextStyle.heading.responsive(context),
            ),
            const SizedBox(height: 8),
            Text(
              'Hello there, sign in to continue',
              style: AppTextStyle.subtitle.responsive(context),
            ),
            const SizedBox(height: 28),
            Center(child: Image.asset(AppImages.signInImage,height: 165,)),
            const SizedBox(height: 28),
            buildTextField(
              context: context,
              hint: 'Text input',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => controller.email.value = value,
            ),
            const SizedBox(height: 16),
            Obx(
              () => buildTextField(
                context: context,
                hint: 'Password',
                obscureText: controller.isPasswordHidden.value,
                suffix: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden.value ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
                onChanged: (value) => controller.password.value = value,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  controller.clearFields();
                  Get.toNamed('/forgot-password');
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF3629B7),
                  textStyle: AppTextStyle.caption.responsive(context),
                ),
                child: Text(
                  'Forgot your password ?',
                  style: AppTextStyle.caption.responsive(context),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(()=>
               buildElevatedButton(
                 context: context,
                text: 'Sign in',
                onPressed: controller.canSignIn ? controller.signIn : null,
                isLoading: controller.isLoading.value,
              ),
            ),
            const SizedBox(height: 22),
            Center(
              child: Icon(
                Icons.fingerprint,
                color: Color(0xFF3629B7),
                size: 64,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: AppTextStyle.bodyGray.responsive(context),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/sign-up');
                  },
                  child: Text(
                    'Sign Up',
                    style: AppTextStyle.link.responsive(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




}
