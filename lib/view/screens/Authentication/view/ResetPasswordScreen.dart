import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom Components
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_text/custom_text.dart';
import 'LoginScreen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Loading State
  bool isLoading = false;

  // Colors
  final Color _primaryGreen = const Color(0xFF437C68);
  final Color _containerWhite = const Color(0xFFFFFFFF).withOpacity(0.85);
  final Color _linkColor = const Color(0xFF2C6E8F);

  // ✅ 1. DEFINE GRADIENT
  final Gradient _primaryGradient = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF437C68),
      Color(0xFF65A58D),
    ],
  );

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Update Password Action with Loading
  Future<void> _handleUpdatePassword() async {
    if (isLoading) return;

    // Validation
    if (_newPasswordController.text.isEmpty ||
        _newPasswordController.text != _confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match or are empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: EdgeInsets.all(10.w),
      );
      return;
    }

    FocusScope.of(context).unfocus(); // Hide Keyboard

    setState(() {
      isLoading = true; // Start Loading
    });

    // Simulate Network Request
    print("Password Updated");
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false; // Stop Loading
    });

    // Success Snackbar
    Get.snackbar(
      "Success",
      "Password updated successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: _primaryGreen,
      colorText: Colors.white,
      margin: EdgeInsets.all(10.w),
      duration: const Duration(seconds: 2),
    );

    // Navigate back to Login
    Get.offAll(
          () => const LoginScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  // Back to Login Action with Loading
  Future<void> _handleBackToLogin() async {
    if (isLoading) return;

    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true; // Start Loading
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false; // Stop Loading
    });

    Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: CustomImage(
              imageSrc: "assets/images/LoginScreen/homescreen.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              imageType: ImageType.png,
            ),
          ),

          // 2. Dark Overlay & Content
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      _buildLogo(),
                      SizedBox(height: 40.h),
                      _buildFormCard(),
                      SizedBox(height: 30.h),

                      // Update Password Button (Shows Loader if loading)
                      isLoading
                          ? Center(
                        child: CircularProgressIndicator(
                          color: _primaryGreen,
                        ),
                      )
                      // ✅ 2. APPLY GRADIENT
                          : CustomButton(
                        onTap: _handleUpdatePassword,
                        title: "Update Password",
                        gradient: _primaryGradient, // Use gradient here
                        textColor: Colors.white,
                        borderRadius: 30.r,
                        height: 56.h,
                        fontSize: 18.sp,
                      ),

                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widgets ---

  Widget _buildLogo() {
    return Column(
      children: [
        CustomImage(
          imageSrc: "assets/images/splashscreens/splashicon.png",
          scale: 20,
          height: 70.h,
          width: 160.w,
          fit: BoxFit.cover,
          imageType: ImageType.png,
          imageColor: Colors.black,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: _containerWhite,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Center(
            child: Text(
              "SET A NEW PASSWORD",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Subtitle
          Center(
            child: Text(
              "Password must have 6-8\ncharacters.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),

          SizedBox(height: 25.h),

          // --- New Password Field ---
          CustomText(
            text: "New Password",
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            textEditingController: _newPasswordController,
            hintText: "Enter password",
            isPassword: true,
            prefixIcon: Icon(Icons.lock_rounded,
                color: Colors.grey[600], size: 20.sp),
            fillColor: Colors.white,
            fieldBorderRadius: 12.r,
          ),

          SizedBox(height: 16.h),

          // --- Confirm New Password Field ---
          CustomText(
            text: "Confirm New Password",
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            textEditingController: _confirmPasswordController,
            hintText: "Enter password",
            isPassword: true,
            prefixIcon: Icon(Icons.lock_rounded,
                color: Colors.grey[600], size: 20.sp),
            fillColor: Colors.white,
            fieldBorderRadius: 12.r,
          ),

          SizedBox(height: 25.h),

          // Back to Login Link
          Center(
            child: GestureDetector(
              onTap: _handleBackToLogin,
              child: Text(
                "Back to Login",
                style: GoogleFonts.poppins(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}