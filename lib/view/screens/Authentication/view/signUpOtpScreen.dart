import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom Components
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_pin_code/custom_pin_code.dart';

// Import the Login Screen
import 'LoginScreen.dart';

class signUpOtpSreen extends StatefulWidget {
  const signUpOtpSreen({super.key});

  @override
  State<signUpOtpSreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<signUpOtpSreen> {
  final TextEditingController _otpController = TextEditingController();

  // Loading State
  bool isLoading = false;

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

  Timer? _timer;
  int _start = 30;
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

  // Verify with Loading for Snackbar too
  Future<void> _handleVerify() async {
    if (isLoading) return;

    FocusScope.of(context).unfocus(); // Hide keyboard

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    if (_otpController.text.length != 4) {
      Get.snackbar(
        "Error",
        "Please enter the 4-digit code",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10.w),
      );
    } else {
      _showSuccessDialog();
    }
  }

  // Back to Login with Loading
  Future<void> _handleBackToLogin() async {
    if (isLoading) return;

    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    Get.offAll(
      () => const LoginScreen(),
      transition: Transition.noTransition,
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: Colors.white.withOpacity(0.95),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00C57F),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 35.sp),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Your Account Is Ready!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF101828),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Your account has been created\nsuccessfully.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp, color: Colors.grey[600], height: 1.5),
                ),
                SizedBox(height: 30.h),
                // ✅ 2. APPLY GRADIENT TO DIALOG BUTTON
                CustomButton(
                  onTap: () {
                    Get.back();
                    Get.offAll(
                      () => const LoginScreen(),
                      transition: Transition.noTransition,
                    );
                  },
                  title: "Back to Login",
                  gradient: _primaryGradient, // Use gradient here
                  textColor: Colors.white,
                  borderRadius: 30.r,
                  height: 50.h,
                  fontSize: 16.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomImage(
              imageSrc: "assets/images/LoginScreen/homescreen.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              imageType: ImageType.png,
            ),
          ),
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

                      // Verify Button (Shows Loader even if Error occurs later)
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: _primaryGreen,
                              ),
                            )
                          // ✅ 3. APPLY GRADIENT TO MAIN BUTTON
                          : CustomButton(
                              onTap: _handleVerify,
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
            imageColor: Colors.black),
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
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                spreadRadius: 2)
          ]),
      child: Column(
        children: [
          Text("VERIFY OTP",
              style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 0.5)),
          SizedBox(height: 12.h),
          Text("Enter the 4-digit code sent to\nyour email and phone number.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14.sp, color: Colors.grey[600], height: 1.5)),
          SizedBox(height: 25.h),
          CustomPinCode(controller: _otpController),
          SizedBox(height: 20.h),
          if (!_isResendEnabled)
            Text("Resend code in $timerText",
                style: GoogleFonts.poppins(
                    fontSize: 14.sp, color: Colors.grey[600])),
          if (_isResendEnabled)
            Text("Code Expired",
                style: GoogleFonts.poppins(
                    fontSize: 14.sp, color: Colors.redAccent)),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: _handleBackToLogin, // ✅ Uses loading function
            child: Text("Back to Login",
                style: GoogleFonts.poppins(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Didn't receive the code? ",
            style: GoogleFonts.poppins(color: Colors.black87, fontSize: 14.sp)),
        GestureDetector(
          onTap: _isResendEnabled
              ? () {
                  startTimer();
                }
              : null,
          child: Text("Resend",
              style: GoogleFonts.poppins(
                  color: _isResendEnabled ? _linkColor : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp)),
        ),
      ],
    );
  }
}
