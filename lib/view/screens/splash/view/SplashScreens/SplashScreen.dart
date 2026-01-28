   import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../components/custom_image/custom_image.dart';
import 'MainOnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // ✅ ৫ সেকেন্ড পর MainOnboardingScreen এ যাবে
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAll(() => const MainOnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image (আপনার আগের ইমেজ)
          const CustomImage(
            imageSrc: "assets/images/splashscreens/splash1.png",
            fit: BoxFit.cover,
          ),

          // 2. Dark Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          // 3. Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: <Widget>[
                  const Spacer(flex: 2),

                  // Logo
                  const CustomImage(imageSrc: "assets/images/splashscreens/splashicon.png"),
                  SizedBox(height: 15.h),

                  // Texts
                  Text(
                      "Discover Jamaica Differently",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      )
                  ),
                  SizedBox(height: 20.h),
                  Text(
                      "Your gateway to Caribbean adventures\nand unforgettable experiences",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter( // ✅ Changed to GoogleFonts.inter
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5

                      )
                  ),

                  const Spacer(flex: 3),

                  // Bottom Loading Section
                  Text(
                      "Preparing your journey",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white60,
                          letterSpacing: 0.5
                      )
                  ),
                  SizedBox(height: 15.h),

                  // ✅ Progress Bar Added Here
                  SizedBox(
                    width: 200.w, // বারের দৈর্ঘ্য
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r), // রাউন্ডেড কর্নার
                      child: LinearProgressIndicator(
                        minHeight: 4.h, // বারের উচ্চতা
                        backgroundColor: Colors.white.withOpacity(0.2), // ব্যাকগ্রাউন্ড কালার
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF2E7D58) // আপনার অ্যাপের গ্রিন থিম কালার
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}