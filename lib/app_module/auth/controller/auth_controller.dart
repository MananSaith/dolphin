import 'package:dolphin/shared/app_imports/app_imports.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  /// Controllers for Login
  final emailControllerLogin = TextEditingController();
  final passwordControllerLogin = TextEditingController();

  /// Controllers for Signup
  final emailControllerSignUp = TextEditingController();
  final passwordControllerSignUp = TextEditingController();
  final confirmPasswordControllerSignUp = TextEditingController();
  final nameController = TextEditingController();

  /// Loading States
  final isLoginLoading = false.obs;
  final isSignUpLoading = false.obs;

  /// LOGIN METHOD
  Future<void> login() async {
    isLoginLoading.value = true;
    try {
      final user = await _authService.login(
        emailControllerLogin.text,
        passwordControllerLogin.text,
      );
      if (user != null) {
        Get.snackbar("Success", "Login successful");
        Get.offNamed(AppRoutes.mainScreen);
      }
    } catch (e) {
      Get.snackbar(
        "Login Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoginLoading.value = false;
    }
  }

  /// SIGNUP METHOD
  Future<void> signUp() async {
    if (passwordControllerSignUp.text != confirmPasswordControllerSignUp.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSignUpLoading.value = true;
    try {
      final user = await _authService.signUp(
        name: nameController.text.trim(),
        email: emailControllerSignUp.text.trim(),
        password: passwordControllerSignUp.text.trim(),
      );
      if (user != null) {
        Get.snackbar("Success", "Account created successfully");
        Get.offNamed(AppRoutes.mainScreen);
      }
    } catch (e) {
      Get.snackbar(
        "Sign Up Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSignUpLoading.value = false;
    }
  }

  /// LOGOUT METHOD
  Future<void> logout() async {
    await _authService.logout();
    Get.snackbar("Success", "Logged out successfully");
    // Navigate to login screen
  }

  @override
  void onClose() {
    emailControllerLogin.dispose();
    passwordControllerLogin.dispose();
    emailControllerSignUp.dispose();
    passwordControllerSignUp.dispose();
    confirmPasswordControllerSignUp.dispose();
    nameController.dispose();
    super.onClose();
  }
}
