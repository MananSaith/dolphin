import 'package:dolphin/shared/app_imports/app_imports.dart';
import 'package:dolphin/shared/widgets/loading_overly.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final formKey = GlobalKey<FormState>();
    return Obx(() {
      return LoadingOverlay(
        isLoading: controller.isSignUpLoading.value,
        child: Scaffold(
          backgroundColor: const Color(0xFF0A0018),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Logo and App Name
                    Center(
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.logo,
                            height: 100.w,
                            width: 100.w,
                          ),
                          3.horizontalSpace,
                          Text(
                            "DolphinCoin",
                            style: GoogleFonts.poppins(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Welcome to\nDolphinCoin",
                      style: GoogleFonts.poppins(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "Dive into the crypto game!",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyText,
                      ),
                    ),
                    10.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.loginScreen);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white10,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),

                    /// Name
                    _buildTextField(
                      controller.nameController,
                      "Name",
                      Icons.person_outline,
                      TextInputType.name,
                      (value) => value!.isEmpty ? "Name is required" : null,
                    ),
                    SizedBox(height: 10.h),
                    _buildTextField(
                      controller.emailControllerSignUp,
                      "Email Address",
                      Icons.email_outlined,
                      TextInputType.emailAddress,
                      (value) => value!.isEmpty ? "Email is required" : null,
                    ),

                    SizedBox(height: 10.h),

                    /// Password
                    _buildTextField(
                      controller.passwordControllerSignUp,
                      "Password",
                      Icons.lock_outline,
                      TextInputType.visiblePassword,
                      (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                      obscureText: false,
                    ),

                    SizedBox(height: 10.h),

                    _buildTextField(
                      controller.confirmPasswordControllerSignUp,
                      "Confirm Password",
                      Icons.lock_outline,
                      TextInputType.visiblePassword,
                      (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm Password is required";
                        } else if (value !=
                            controller.passwordControllerSignUp.text.trim()) {
                          return "Passwords do not match";
                        }
                        return null; // no error
                      },
                      obscureText: false,
                    ),
                    SizedBox(height: 24.h),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.signUp();
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF007A), Color(0xFF9A00FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    /// OR Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.darkPurple,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            "OR",
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: AppColors.greyText,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.darkPurple,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // /// Connect Wallet
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     width: double.infinity,
                    //     padding: EdgeInsets.symmetric(vertical: 10.h),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12.r),
                    //       border: Border.all(color: Colors.white24, width: 1),
                    //     ),
                    //     child: Center(
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Icon(
                    //             Icons.account_balance_wallet_outlined,
                    //             color: AppColors.white,
                    //           ),
                    //           SizedBox(width: 8.w),
                    //           Text(
                    //             "Connect Wallet",
                    //             style: GoogleFonts.poppins(
                    //               fontSize: 16.sp,
                    //               fontWeight: FontWeight.w500,
                    //               color: AppColors.white,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: AppColors.greyText,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            "Log in",
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.pink,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon,
    TextInputType inputType,
    String? Function(String?) validator, {
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      style: GoogleFonts.poppins(color: AppColors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: AppColors.greyText),
        prefixIcon: Icon(icon, color: AppColors.white),
        filled: true,
        fillColor: AppColors.darkPurple.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.white24, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.pink, width: 1.2),
        ),
      ),
      validator: validator,
    );
  }
}
