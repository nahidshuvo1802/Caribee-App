import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom Components Imports
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text_field/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // Controllers for the text fields
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Design Color
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
      // Prevents resizing when keyboard appears
      resizeToAvoidBottomInset: false,
      // Extends body behind AppBar for transparent look
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ------------------------------------------------
          // 1. Background Image
          // ------------------------------------------------
          Positioned.fill(
            child: Image.asset(
              "assets/images/profile/profilebg.png",
              fit: BoxFit.cover,
            ),
          ),

          // ------------------------------------------------
          // 2. Content Overlay
          // ------------------------------------------------
          SafeArea(
            child: Column(
              children: [
                // --- Custom App Bar ---
                const CustomRoyelAppbar(
                  titleName: "Change Password",
                  leftIcon: true,
                  color: Colors.white, // Title and icon color
                  backgroundColor: Colors.transparent,
                ),

                SizedBox(height: 40.h),

                // --- Form Container with Glassmorphism Effect ---
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85), // Semi-transparent white
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              // --- Old Password Field ---
                              CustomTextField(
                                textEditingController: oldPasswordController,
                                hintText: "Old Password",
                                isPassword: true, // Shows eye icon
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: primaryGreen,
                                  size: 22.sp,
                                ),
                                fillColor: Colors.white,
                              ),
                              SizedBox(height: 20.h),

                              // --- New Password Field ---
                              CustomTextField(
                                textEditingController: newPasswordController,
                                hintText: "New Password",
                                isPassword: true,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: primaryGreen,
                                  size: 22.sp,
                                ),
                                fillColor: Colors.white,
                              ),
                              SizedBox(height: 20.h),

                              // --- Confirm Password Field ---
                              CustomTextField(
                                textEditingController: confirmPasswordController,
                                hintText: "Confirm Password",
                                isPassword: true,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: primaryGreen,
                                  size: 22.sp,
                                ),
                                fillColor: Colors.white,
                              ),
                              SizedBox(height: 15.h),

                              // --- Forgot Password Button ---
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Add Forgot Password logic here
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    "Forgot Password?",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1D1F24).withOpacity(0.6),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),

                              // --- Update Password Button ---
                              CustomButton(
                                onTap: () {
                                  // Show Success Snackbar
                                  Get.snackbar(
                                    "Success",
                                    "Password Updated Successfully",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: primaryGreen,
                                    colorText: Colors.white,
                                    margin: EdgeInsets.all(20.w),
                                    borderRadius: 12.r,
                                    duration: const Duration(seconds: 2),
                                    icon: const Icon(Icons.check_circle, color: Colors.white),
                                  );

                                  // Optional: Navigate back after a delay
                                  // Future.delayed(const Duration(seconds: 2), () => Get.back());
                                },
                                title: "Update Password",
                                height: 56.h,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
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
}