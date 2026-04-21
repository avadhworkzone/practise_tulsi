import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practise/common/common_button.dart';
import 'package:practise/common/common_text_field.dart';
import 'package:practise/common/common_text_style.dart';
import 'package:practise/config/appImage.dart';

import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Sign up',
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to us,',
              style: AppTextStyle.heading.responsive(context),
            ),
            const SizedBox(height: 8),
            Text(
              'Hello there, create New account',
              style: AppTextStyle.subtitle.responsive(context),
            ),
            const SizedBox(height: 28),
           Center(child: Image.asset(AppImages.signUpImage,height: 165,)),
            const SizedBox(height: 28),
            buildTextField(
              context: context,
              hint: 'Name',
              onChanged: (value) => controller.name.value = value,
            ),
            const SizedBox(height: 16),
            buildTextField(
              context: context,
              hint: 'Text input',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => controller.email.value = value,
            ),
            const SizedBox(height: 16),
            buildTextField(
              context: context,
              hint: '(+84) 332248402',
              keyboardType: TextInputType.phone,
              onChanged: (value) => controller.phone.value = value,
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
            const SizedBox(height: 16),
            Obx(
              () => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFF3629B7),
                value: controller.isTermsAccepted.value,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (_) => controller.toggleTermsAccepted(),
                title: RichText(
                  text: TextSpan(
                      style: AppTextStyle.body.responsive(context),
                      children: [
                        const TextSpan(
                          text: 'By creating an account you agree to our ',

                        ),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: AppTextStyle.link.responsive(context),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.snackbar(
                                'Terms',
                                'Open terms and conditions.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                        ),
                      ],
                    ),
              ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(()=>
               buildElevatedButton(
                 context: context,
                text: 'Sign up',
                onPressed: controller.canSignUp ? controller.signUp : null,
                isLoading: controller.isLoading.value,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Have one account? ',
                  style: AppTextStyle.bodyGray.responsive(context),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    'Sign in',
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
