import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom Components
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_pin_code/custom_pin_code.dart';

// Import the Screen to navigate to
import 'ResetPasswordScreen.dart';
import 'LoginScreen.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  // Loading State
  bool isLoading = false;

  // Colors
  final Color _primaryGreen = const Color(0xFF437C68);
  final Color _containerWhite = const Color(0xFFFFFFFF).withValues(alpha: 0.85);
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

  // Timer Variables
  Timer? _timer;
  int _start = 30; // 30 Seconds
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _start = 30;
      _isResendEnabled = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendEnabled = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String get timerText {
    return "00:${_start.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // Verify Action with Loading
  Future<void> _handleVerify() async {
    if (isLoading) return;

    // Validation
    if (_otpController.text.length != 4) {
      Get.snackbar(
        "Error",
        "Please enter the 4-digit code",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    FocusScope.of(context).unfocus(); // Hide keyboard

    setState(() {
      isLoading = true; // Start Loading
    });

    // Simulate Network Request (Wait 2 seconds)
    print("Verify Clicked. Code: ${_otpController.text}");
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false; // Stop Loading
    });

    // Navigate to Reset Password Screen
    Get.to(
      () => const ResetPasswordScreen(),
      transition: Transition.fadeIn,
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

    // Simulate delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false; // Stop Loading
    });

    // Navigate back to Login Screen
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

          // 2. Overlay & Content
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.1),
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

                      // Verify Button (Shows Loader if loading)
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: _primaryGreen,
                              ),
                            )
                          // ✅ 2. APPLY GRADIENT
                          : CustomButton(
                              onTap: _handleVerify, // Calls verify function
                              title: "Verify",
                              gradient: _primaryGradient, // Use gradient here
                              textColor: Colors.white,
                              borderRadius: 30.r,
                              height: 56.h,
                              fontSize: 18.sp,
                            ),

                      SizedBox(height: 30.h),
                      _buildFooter(),
                      SizedBox(height: 20.h),
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: _containerWhite,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "VERIFY OTP",
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Enter the 4-digit code sent to\nyour email and phone number.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          SizedBox(height: 25.h),

          // PIN Code Input
          CustomPinCode(
            controller: _otpController,
          ),

          SizedBox(height: 20.h),

          if (!_isResendEnabled)
            Text(
              "Resend code in $timerText",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),

          if (_isResendEnabled)
            Text(
              "Code Expired",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.redAccent,
              ),
            ),

          SizedBox(height: 20.h),

          GestureDetector(
            // Back to Login calls the loading function
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
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive the code? ",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 14.sp,
          ),
        ),
        GestureDetector(
          onTap: _isResendEnabled
              ? () {
                  print("Resend Code Clicked");
                  startTimer();
                }
              : null,
          child: Text(
            "Resend",
            style: GoogleFonts.poppins(
              color: _isResendEnabled ? _linkColor : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
