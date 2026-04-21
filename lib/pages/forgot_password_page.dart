import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practise/common/common_button.dart';
import 'package:practise/common/common_text_field.dart';
import 'package:practise/common/common_text_style.dart';
import 'package:practise/config/appColor.dart';
import 'package:practise/config/appImage.dart';

import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      final phase = controller.forgotPhase.value;
        return AuthScaffold(
          appColor: AppColor.white,
          textColor: AppColor.black,
          title: phase == ForgotPhase.resetPassword ?"Change password": phase==ForgotPhase.success?"": 'Forgot password',
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(35, 24, 35, 24),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if(phase == ForgotPhase.enterPhone || phase == ForgotPhase.enterOtp )...[
                    Text(
                      phase == ForgotPhase.enterPhone
                          ? 'Type your phone number'
                          : phase == ForgotPhase.enterOtp
                              ? 'Type a code'
                              : phase == ForgotPhase.resetPassword
                                  ? ''
                                  : '',
                      style: AppTextStyle.subtitle.copyWith(
                        color:AppColor.c979797,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(height: 15),
                    ],
                    if (phase == ForgotPhase.enterPhone) ...[
                      buildTextField(
                        context: context,
                        key: const ValueKey('forgot-phone'),
                        hint: '(+84) 098882xxxx',
                        keyboardType: TextInputType.phone,
                        onChanged: (value) => controller.phone.value = value,
                        obscureText: false,
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (phase == ForgotPhase.enterOtp) ...[
                      Row(
                        children: [
                          Expanded(
                            child: buildTextField(
                              context: context,
                              key: const ValueKey('forgot-otp'),
                              hint: 'Code',
                              keyboardType: TextInputType.number,
                              onChanged: (value) => controller.otpCode.value = value,
                            ),
                          ),
                          SizedBox(width: 15,),
                          Obx(() =>
                             buildElevatedButton(
                               context: context,
                              text: 'Resend',
                              onPressed: controller.canSendOtp ? controller.sendOtp : null,
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              textStyle: AppTextStyle.whiteTitle.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (phase == ForgotPhase.resetPassword) ...[
                      buildTextField(
                        context: context,
                        label: "Type your new password",
                        key: const ValueKey('forgot-new-password'),
                        hint: 'New password',
                        obscureText: controller.isPasswordHidden.value,
                        suffix: IconButton(
                          icon: Icon(
                            controller.isPasswordHidden.value ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        onChanged: (value) => controller.newPassword.value = value,
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        context: context,
                        label: "Confirm password",
                        key: const ValueKey('forgot-confirm-password'),
                        hint: 'Confirm password',
                        obscureText: controller.isPasswordHidden.value,
                        suffix: IconButton(
                          icon: Icon(
                            controller.isPasswordHidden.value ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        onChanged: (value) => controller.confirmPassword.value = value,
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (phase == ForgotPhase.enterOtp) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: AppTextStyle.body.copyWith(color: AppColor.c898989),
                              children: [
                                const TextSpan(
                                  text: 'We texted you a code to verify your phone number ',

                                ),
                                TextSpan(
                                  text: controller.phone.value.trim(),
                                  style: AppTextStyle.body.copyWith(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'This code will expire 10 minutes after this message. If you don\'t get a message, please try again.',
                            style: AppTextStyle.body.copyWith(color: AppColor.c898989),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                    ],

                    if (phase == ForgotPhase.enterPhone) ...[
                      Column(
                        children: [
                          Text(
                            'We texted you a code to verify your phone number',
                              style: AppTextStyle.bodyGray.copyWith(color: Colors.black,fontSize: 14),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ],
                    if (phase == ForgotPhase.success) ...[
                      Column(
                        children: [
                          Image.asset(AppImages.successImage,height: 216,),
                          const SizedBox(height: 25),
                          Text(
                            'Change password successfully!',
                            style: AppTextStyle.heading.copyWith(fontSize: 16,color: AppColor.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'You have successfully changed your password. Please use the new password when signing in.',
                            style: AppTextStyle.bodyGray.copyWith(color: Colors.black,fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),

                        ],
                      ),
                    ],
                    if (phase != ForgotPhase.success) ...[
                      Obx(
                        () => buildElevatedButton(
                          text: phase == ForgotPhase.enterPhone
                              ? 'Send'
                              : phase == ForgotPhase.enterOtp
                                  ? 'Change password'
                                  : 'Change password',
                          onPressed: phase == ForgotPhase.enterPhone
                              ? (controller.canSendOtp ? controller.sendOtp : null)
                              : phase == ForgotPhase.enterOtp
                                  ? (controller.canVerifyOtp ? controller.verifyOtp : null)
                                  : phase == ForgotPhase.resetPassword
                                      ? (controller.canResetPassword ? controller.resetPassword : null)
                                      : null,
                          isLoading: controller.isLoading.value, context: context,
                        ),
                      ),
                    ],
                    if (phase == ForgotPhase.success) ...[
                      Obx(
                        () =>  buildElevatedButton(
                          context: context,
                          text: 'Ok',
                          onPressed: () {
                            controller.clearFields();
                            Get.offAllNamed('/sign-in');
                          },
                        ),
                      ),
                    ],
                  ],
            ),
          ),
        );
      }
    );
  }
}
