import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

enum ForgotPhase { enterPhone, enterOtp, resetPassword, success }

class AuthController extends GetxController {
  final name = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final otpCode = ''.obs;
  final otpSentCode = ''.obs;
  final resetEmail = ''.obs;
  final newPassword = ''.obs;
  final confirmPassword = ''.obs;
  final password = ''.obs;
  final currentUserName = ''.obs;
  final currentUserEmail = ''.obs;
  final isPasswordHidden = true.obs;
  final isTermsAccepted = false.obs;
  final isLoading = false.obs;
  final forgotPhase = ForgotPhase.enterPhone.obs;

  bool get canSignIn {
    final trimmedEmail = email.value.trim();
    final trimmedPassword = password.value.trim();
    return trimmedEmail.isNotEmpty && GetUtils.isEmail(trimmedEmail) && trimmedPassword.length >= 6;
  }

  bool get canSignUp {
    final trimmedName = name.value.trim();
    final trimmedEmail = email.value.trim();
    final trimmedPhone = phone.value.trim();
    final trimmedPassword = password.value.trim();
    return trimmedName.length > 2 && GetUtils.isEmail(trimmedEmail) && trimmedPhone.length >= 7 && trimmedPassword.length >= 6 && isTermsAccepted.value;
  }

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  void toggleTermsAccepted() {
    isTermsAccepted.toggle();
  }

  Box get userBox => Hive.box('users');
  Box get sessionBox => Hive.box('session');

  @override
  void onInit() {
    super.onInit();
    _restoreSession();
  }

  void _restoreSession() {
    final savedEmail = sessionBox.get('currentUserEmail') as String?;
    if (savedEmail != null && savedEmail.isNotEmpty) {
      final storedUser = _userByEmail(savedEmail);
      if (storedUser != null) {
        currentUserEmail.value = savedEmail;
        currentUserName.value = storedUser['name'] ?? '';
      }
    }
  }

  Map<String, dynamic>? _userByEmail(String emailAddress) {
    final dynamic raw = userBox.get(emailAddress);
    if (raw is Map) {
      return raw.cast<String, dynamic>();
    }
    return null;
  }

  Map<String, dynamic>? _userByPhone(String phoneNumber) {
    for (final dynamic raw in userBox.values) {
      if (raw is Map && raw['phone'] == phoneNumber) {
        return raw.cast<String, dynamic>();
      }
    }
    return null;
  }

  void clearFields() {
    name.value = '';
    email.value = '';
    phone.value = '';
    otpCode.value = '';
    otpSentCode.value = '';
    resetEmail.value = '';
    newPassword.value = '';
    confirmPassword.value = '';
    password.value = '';
    isTermsAccepted.value = false;
    isPasswordHidden.value = true;
    forgotPhase.value = ForgotPhase.enterPhone;
  }

  bool get canSendOtp => phone.value.trim().isNotEmpty;
  bool get canVerifyOtp => otpCode.value.trim().length >= 4;
  bool get canResetPassword {
    final newPass = newPassword.value.trim();
    final confirmPass = confirmPassword.value.trim();
    return newPass.length >= 6 && newPass == confirmPass;
  }

  Future<void> sendOtp() async {
    if (!canSendOtp) return;
    final foundUser = _userByPhone(phone.value.trim());
    if (foundUser == null) {
      Get.snackbar(
        'Not found',
        'No account found for this phone number.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    otpSentCode.value = '8422';
    resetEmail.value = foundUser['email'] ?? '';
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;
    otpCode.value = '';
    newPassword.value = '';
    confirmPassword.value = '';
    forgotPhase.value = ForgotPhase.enterOtp;
    Get.snackbar(
      'OTP sent',
      'A code was sent to ${phone.value.trim()}.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  Future<void> verifyOtp() async {
    if (!canVerifyOtp) return;
    if (otpCode.value.trim() != otpSentCode.value.trim()) {
      Get.snackbar(
        'Invalid code',
        'The code you entered is not correct.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;
    newPassword.value = '';
    confirmPassword.value = '';
    forgotPhase.value = ForgotPhase.resetPassword;
    Get.snackbar(
      'OTP verified',
      'Enter your new password below.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  Future<void> resetPassword() async {
    if (!canResetPassword) return;
    if (resetEmail.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Unable to reset password. Please start again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    final storedUser = _userByEmail(resetEmail.value);
    if (storedUser == null) {
      Get.snackbar(
        'Error',
        'Unable to reset password. User not found.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    final updatedUser = <String, dynamic>{
      ...storedUser,
      'password': newPassword.value.trim(),
    };
    userBox.put(resetEmail.value, updatedUser);

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;
    forgotPhase.value = ForgotPhase.success;
    Get.snackbar(
      'Password changed',
      'Your password has been updated successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  Future<void> signIn() async {
    if (!canSignIn) return;
    final storedUser = _userByEmail(email.value.trim());
    if (storedUser == null || storedUser['password'] != password.value.trim()) {
      Get.snackbar(
        'Sign in failed',
        'Email or password is incorrect.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    currentUserName.value = storedUser['name'] ?? '';
    currentUserEmail.value = email.value.trim();
    sessionBox.put('currentUserEmail', currentUserEmail.value);

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;
    Get.snackbar(
      'Welcome Back',
      'You have successfully signed in.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
    Get.offAllNamed('/home');
  }

  Future<void> signUp() async {
    if (!canSignUp) return;
    final trimmedEmail = email.value.trim();
    final trimmedPhone = phone.value.trim();
    if (_userByEmail(trimmedEmail) != null) {
      Get.snackbar(
        'Account exists',
        'This email is already registered.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }
    if (_userByPhone(trimmedPhone) != null) {
      Get.snackbar(
        'Account exists',
        'This phone number is already registered.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    final userRecord = {
      'name': name.value.trim(),
      'email': trimmedEmail,
      'phone': trimmedPhone,
      'password': password.value.trim(),
    };
    userBox.put(trimmedEmail, userRecord);
    currentUserName.value = name.value.trim();
    currentUserEmail.value = trimmedEmail;
    sessionBox.put('currentUserEmail', currentUserEmail.value);

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;
    Get.snackbar(
      'Account Created',
      'Your account has been registered successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
    Get.offAllNamed('/home');
  }
}
