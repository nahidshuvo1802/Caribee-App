import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tutor_app/view/screens/profile/view/profileScreen.dart';

// Custom Components Imports
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../../../../components/custom_text/custom_text.dart'; // Added CustomText import

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final Color primaryGreen = const Color(0xFF2E5C38);

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      // --- AppBar Updated ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:
              Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
        ),
        title: CustomText(
          text: "Change Password",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/profile/profilebg.png",
              fit: BoxFit.cover,
            ),
          ),

          // 2. Content
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align titles to left
                      children: [
                        SizedBox(height: 20.h),

                        // --- 1. Old Password ---
                        _buildFieldTitle("Old Password"),
                        CustomTextField(
                          textEditingController: oldPasswordController,
                          hintText: "Old Password",
                          isPassword: true,
                          prefixIcon: Icon(Icons.lock_outline,
                              color: primaryGreen, size: 22.sp),
                          fillColor: Colors.white.withOpacity(0.9),
                          fieldBorderRadius: 40, // Rounded 40
                        ),
                        SizedBox(height: 20.h),

                        // --- 2. New Password ---
                        _buildFieldTitle("New Password"),
                        CustomTextField(
                          textEditingController: newPasswordController,
                          hintText: "New Password",
                          isPassword: true,
                          prefixIcon: Icon(Icons.lock_outline,
                              color: primaryGreen, size: 22.sp),
                          fillColor: Colors.white.withOpacity(0.9),
                          fieldBorderRadius: 40, // Rounded 40
                        ),
                        SizedBox(height: 20.h),

                        // --- 3. Confirm Password ---
                        _buildFieldTitle("Confirm Password"),
                        CustomTextField(
                          textEditingController: confirmPasswordController,
                          hintText: "Confirm Password",
                          isPassword: true,
                          prefixIcon: Icon(Icons.lock_outline,
                              color: primaryGreen, size: 22.sp),
                          fillColor: Colors.white.withOpacity(0.9),
                          fieldBorderRadius: 40, // Rounded 40
                        ),

                        SizedBox(height: 10.h),

                        // --- Forgot Password Link ---
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: CustomText(
                              text: "Forgot Password?",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors
                                  .white, // Changed to white to be visible on bg
                            ),
                          ),
                        ),

                        SizedBox(height: 40.h),

                        // --- Update Button (Gradient) ---
                        CustomButton(
                          onTap: () {
                            // Logic to update password
                            Get.to(() => const ProfileScreen(),
                                transition: Transition.fadeIn);
                            Get.snackbar(
                              "Success",
                              "Password Updated Successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: primaryGreen,
                              colorText: Colors.white,
                              margin: EdgeInsets.all(20.w),
                              borderRadius: 12.r,
                              duration: const Duration(seconds: 2),
                              icon: const Icon(Icons.check_circle,
                                  color: Colors.white),
                            );
                          },
                          title: "Update Password",
                          height: 56.h,
                          fontSize: 18.sp,
                          borderRadius: 40, // Rounded 40
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF2E5C38), // Dark Green
                              Color(0xFF66B290), // Lighter Green
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for Field Titles
  Widget _buildFieldTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
      child: CustomText(
        text: title,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
