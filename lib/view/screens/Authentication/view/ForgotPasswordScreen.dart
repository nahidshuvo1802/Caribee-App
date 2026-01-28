import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom Components
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_text/custom_text.dart';

// Import the Next Screen
import 'VerifyOtpScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  // Loading State Variable
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
    _emailController.dispose();
    super.dispose();
  }

  // Function to handle Request OTP
  Future<void> _handleRequestOtp() async {
    if (isLoading) return;

    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    Get.to(
          () => const VerifyOtpScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  // Back to Login Function with Loading
  Future<void> _handleBackToLogin() async {
    if (isLoading) return; // Prevent double click

    FocusScope.of(context).unfocus(); // Close keyboard

    setState(() {
      isLoading = true; // Start Loading
    });

    // Simulate delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false; // Stop Loading
    });

    Get.back(); // Navigate back to Login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: CustomImage(
              imageSrc: "assets/images/LoginScreen/homescreen.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              imageType: ImageType.png,
            ),
          ),

          // Content with Overlay
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
                      SizedBox(height: 60.h),
                      _buildFormCard(),
                      SizedBox(height: 30.h),

                      // Request OTP Button (Shows Loader if ANY loading happens)
                      isLoading
                          ? Center(
                        child: CircularProgressIndicator(
                          color: _primaryGreen,
                        ),
                      )
                      // ✅ 2. APPLY GRADIENT
                          : CustomButton(
                        onTap: _handleRequestOtp,
                        title: "Request OTP",
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
              "FORGOT PASSWORD",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Description Text
          Center(
            child: Text(
              "Enter your registered email or\nphone number and we'll send you\na link to reset your password.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),

          SizedBox(height: 30.h),

          // Input Label
          CustomText(
            text: "Email or Phone",
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            textAlign: TextAlign.left,
          ),

          SizedBox(height: 8.h),

          // Custom Input Field
          CustomTextField(
            textEditingController: _emailController,
            hintText: "Enter email or phone number",
            prefixIcon: Icon(Icons.email_sharp,
                color: Colors.grey[600], size: 20.sp),
            fillColor: Colors.white,
            fieldBorderRadius: 12.r,
          ),

          SizedBox(height: 20.h),

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