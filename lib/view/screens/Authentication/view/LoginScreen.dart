import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom Components
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_text/custom_text.dart';

// Links to other screens
import '../../HomeScreen/homeScreen.dart';
import 'ForgotPasswordScreen.dart';
import 'signUpOtpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --- State to handle Toggle ---
  bool isSignIn = true; // true = Sign In, false = Create Account
  bool isLoading = false; // Loading State

  // --- Controllers (Sign In) ---
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // --- Controllers & Variables (Create Account) ---
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _personalizeController = TextEditingController();

  // Dropdown Values
  String? selectedCountry;
  String? selectedAgeRange;
  String? selectedGender;

  // Travel Style Logic
  final List<String> travelStyles = [
    "Relaxed & familiar",
    "Adventurous",
    "Culture & heritage",
    "Nightlife & social",
    "Off the beaten path"
  ];
  List<String> selectedTravelStyles = [];

  // Colors
  final Color _primaryGreen = const Color(0xFF437C68);
  final Color _containerWhite = const Color(0xFFFFFFFF).withOpacity(0.90);
  final Color _labelColor = Colors.black87;

  // ✅ 1. DEFINE THE GREEN GRADIENT
  final Gradient _primaryGradient = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF437C68), // Original Primary Green
      Color(0xFF65A58D), // A lighter shade for the gradient effect
    ],
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _confirmPasswordController.dispose();
    _personalizeController.dispose();
    super.dispose();
  }

  // --- Helper to toggle Travel Styles (Max 2) ---
  void _toggleTravelStyle(String style) {
    setState(() {
      if (selectedTravelStyles.contains(style)) {
        selectedTravelStyles.remove(style);
      } else {
        if (selectedTravelStyles.length < 2) {
          selectedTravelStyles.add(style);
        } else {
          Get.snackbar("Limit Reached", "You can select max 2 styles",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange,
              colorText: Colors.white,
              duration: const Duration(seconds: 1));
        }
      }
    });
  }

  // --- Handle Auth Action (Login / Sign Up) ---
  Future<void> _handleAuthAction() async {
    if (isLoading) return; // Prevent double click

    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    if (isSignIn) {
      print("Login Successful");
      Get.offAll(() => const HomeScreen());
    } else {
      print("Create Account Successful");
      Get.to(() => const signUpOtpSreen());
    }
  }

  // Forgot Password Action with Loading
  Future<void> _handleForgotPassword() async {
    if (isLoading) return;

    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    Get.to(() => const ForgotPasswordScreen());
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
                      SizedBox(height: 10.h),
                      _buildLogo(),
                      SizedBox(height: 20.h),
                      _buildToggleSwitch(),
                      SizedBox(height: 20.h),
                      _buildFormContainer(),
                      SizedBox(height: 30.h),

                      // Main Button with Loading State
                      isLoading
                          ? Center(
                        child: CircularProgressIndicator(
                          color: _primaryGreen,
                        ),
                      )
                      // ✅ 2. APPLY GRADIENT TO BUTTON
                          : CustomButton(
                        onTap: _handleAuthAction,
                        title: isSignIn ? "Sign In" : "Create Account",
                        gradient: _primaryGradient, // Use gradient here
                        textColor: Colors.white,
                        borderRadius: 30.r,
                        height: 56.h,
                        fontSize: 18.sp,
                      ),

                      SizedBox(height: 20.h),
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
          height: 60.h,
          width: 140.w,
          fit: BoxFit.contain,
          imageType: ImageType.png,
          imageColor: Colors.black,
        ),
      ],
    );
  }

  Widget _buildToggleSwitch() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: const Color(0xFFB0C6D1).withOpacity(0.6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isSignIn ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: (MediaQuery.of(context).size.width - 48.w) / 2,
              margin: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                // ✅ 3. APPLY GRADIENT TO TOGGLE SWITCH
                gradient: _primaryGradient,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              _buildToggleOption("Sign In", true),
              _buildToggleOption("Create Account", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleOption(String title, bool isSignInTab) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            isSignIn = isSignInTab;
          });
        },
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: (isSignIn == isSignInTab) ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
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
      child: isSignIn ? _buildSignInForm() : _buildCreateAccountForm(),
    );
  }

  // ... (Rest of your form widgets: _buildSignInForm, _buildCreateAccountForm, etc. remain unchanged) ...

  // --- 1. Sign In Form ---
  Widget _buildSignInForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("Email or Phone"),
        SizedBox(height: 8.h),
        CustomTextField(
          textEditingController: _emailController,
          hintText: "Enter email or phone number",
          prefixIcon: Icon(Icons.email_sharp, color: Colors.grey[600], size: 20.sp),
          fillColor: Colors.white,
          fieldBorderRadius: 12.r,
        ),
        SizedBox(height: 16.h),
        _label("Password"),
        SizedBox(height: 8.h),
        CustomTextField(
          textEditingController: _passwordController,
          hintText: "Enter password",
          isPassword: true,
          prefixIcon: Icon(Icons.lock_rounded, color: Colors.grey[600], size: 20.sp),
          fillColor: Colors.white,
          fieldBorderRadius: 12.r,
        ),
        SizedBox(height: 20.h),
        Center(
          child: GestureDetector(
            onTap: isLoading ? null : _handleForgotPassword,
            child: CustomText(
              text: "Forgot Password?",
              color: Colors.blueAccent ,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        )
      ],
    );
  }

  // --- 2. Create Account Form ---
  Widget _buildCreateAccountForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("Full Name"),
        SizedBox(height: 8.h),
        CustomTextField(
          textEditingController: _fullNameController,
          hintText: "Enter your name",
          prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.grey[600], size: 20.sp),
          fillColor: Colors.white,
          fieldBorderRadius: 12.r,
        ),
        SizedBox(height: 15.h),
        _label("Email / Phone"),
        SizedBox(height: 8.h),
        CustomTextField(
          textEditingController: _emailController,
          hintText: "Enter email or phone number",
          prefixIcon: Icon(Icons.email_sharp, color: Colors.grey[600], size: 20.sp),
          fillColor: Colors.white,
          fieldBorderRadius: 12.r,
        ),
        SizedBox(height: 15.h),
        _label("Password"),
        SizedBox(height: 8.h),
        CustomTextField(
          textEditingController: _passwordController,
          hintText: "Create a strong password",
          isPassword: true,
          prefixIcon: Icon(Icons.lock_rounded, color: Colors.grey[600], size: 20.sp),
          fillColor: Colors.white,
          fieldBorderRadius: 12.r,
        ),
        SizedBox(height: 15.h),
        _label("Country selector"),
        SizedBox(height: 8.h),
        _buildDropdown(
          hint: "Where are you traveling from?",
          value: selectedCountry,
          items: ["USA", "Canada", "UK", "Bangladesh", "Jamaica"],
          onChanged: (val) => setState(() => selectedCountry = val),
        ),
        SizedBox(height: 15.h),
        _label("Age range"),
        SizedBox(height: 8.h),
        _buildDropdown(
          hint: "Select your age range",
          value: selectedAgeRange,
          items: ["18-25", "26-35", "36-50", "50+"],
          onChanged: (val) => setState(() => selectedAgeRange = val),
        ),
        SizedBox(height: 15.h),
        _label("Travel style (Multi-select, max 2)"),
        SizedBox(height: 10.h),
        _buildTravelStyleSelector(),
        SizedBox(height: 15.h),
        _label("Gender"),
        SizedBox(height: 8.h),
        _buildDropdown(
          hint: "Select your gender",
          value: selectedGender,
          items: ["Male", "Female", "Other"],
          onChanged: (val) => setState(() => selectedGender = val),
        ),
        SizedBox(height: 15.h),
        _label("Confirm Password"),
        SizedBox(height: 8.h),
        CustomTextField(
          textEditingController: _confirmPasswordController,
          hintText: "Retype password",
          isPassword: true,
          prefixIcon: Icon(Icons.lock_rounded, color: Colors.grey[600], size: 20.sp),
          fillColor: Colors.white,
          fieldBorderRadius: 12.r,
        ),
        SizedBox(height: 15.h),
        _label("Personalize your experience"),
        SizedBox(height: 8.h),
        CustomTextField(
          textEditingController: _personalizeController,
          hintText: "Used to personalise your Caribee experience.",
          fillColor: Colors.white,
          fieldBorderRadius: 12.r,
          maxLines: 4,
          isPrefixIcon: false,
        ),
      ],
    );
  }

  Widget _label(String text) {
    return CustomText(
      text: text,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: _labelColor,
      textAlign: TextAlign.left,
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.transparent),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          isExpanded: true,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black87),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildTravelStyleSelector() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: travelStyles.map((style) {
          bool isSelected = selectedTravelStyles.contains(style);
          return GestureDetector(
            onTap: () => _toggleTravelStyle(style),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                children: [
                  Container(
                    height: 20.w,
                    width: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? _primaryGreen : Colors.grey,
                        width: 2,
                      ),
                      color: isSelected ? _primaryGreen : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                        : null,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      style,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.poppins(color: Colors.black87, fontSize: 12.sp, height: 1.5),
          children: [
            const TextSpan(text: "By continuing, you agree to Global Jump's "),
            TextSpan(
              text: "Terms",
              style: GoogleFonts.poppins(color: const Color(0xFF2C6E8F), fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: " and "),
            TextSpan(
              text: "Privacy Policy",
              style: GoogleFonts.poppins(color: const Color(0xFF2C6E8F), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}