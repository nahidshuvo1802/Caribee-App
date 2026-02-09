// Glassmorphism
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_image/custom_image.dart';
import '../../../Authentication/view/LoginScreen.dart';

// --------------------------------------------------------
// CONTROLLER
// --------------------------------------------------------
class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAll(() => const LoginScreen(), transition: Transition.fadeIn);
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void skip() {
    Get.offAll(() => const LoginScreen(), transition: Transition.fadeIn);
  }
}

// --------------------------------------------------------
// MAIN SCREEN UI
// --------------------------------------------------------
class MainOnboardingScreen extends StatelessWidget {
  const MainOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ---------------------------------------------------
          // 1. PAGE VIEW
          // ---------------------------------------------------
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildPage(
                imagePath: "assets/images/splashscreens/splash2.png",
                title: "Discover the\nReal Caribbean",
                subtitle:
                    "Curated, authentic, and trusted\nexperiences for you to explore.",
                featureItems: [
                  {
                    "icon": "assets/images/icon/locationicon.png",
                    "text": "Stay connected with seamless eSim access"
                  },
                  {
                    "icon": Icons.favorite,
                    "text": "Support and guidance when you need it"
                  },
                  {
                    "icon": Icons.explore,
                    "text": "A smarter, more confident way to travel"
                  },
                ],
              ),
              _buildPage(
                imagePath: "assets/images/splashscreens/splash3.png",
                title: "Travel With\nConfidence",
                subtitle:
                    "Secure payments and 24/7 support\nmake your journey worry-free.",
                featureItems: [
                  {
                    "icon": "assets/images/icon/locationicon.png",
                    "text": "Smart navigation & nearby essentials"
                  },
                  {
                    "icon": Icons.favorite,
                    "text": "Exclusive, handpicked experiences"
                  },
                  {
                    "icon": Icons.explore,
                    "text": "Trusted guides with insider knowledge"
                  },
                ],
              ),
              _buildPage(
                imagePath: "assets/images/splashscreens/splash4.png",
                title: "We're With You\nEvery Step of the Way",
                subtitle:
                    "Caribee helps you stay connected,\nsupported, and travel with ease.",
                featureItems: [
                  {
                    "icon": Icons.sim_card_rounded,
                    "text": "Stay connected with seamless eSim access"
                  },
                  {
                    "icon": Icons.favorite,
                    "text": "Support and guidance when you need it"
                  },
                  {
                    "icon": Icons.explore,
                    "text": "A smarter, more confident way to travel"
                  },
                ],
              ),
            ],
          ),

          // ---------------------------------------------------
          // 2. TOP BAR (DOTS & SKIP)
          // ---------------------------------------------------
          Positioned(
            top: 60.h,
            left: 24.w,
            right: 24.w,
            child: SizedBox(
              height: 40.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // --- Pagination Dots ---
                  Obx(() => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(3, (index) {
                          return _buildDot(
                            isActive: index == controller.currentPage.value,
                          );
                        }),
                      )),

                  // --- Skip Button ---
                  Positioned(
                    right: 0,
                    child: Obx(() {
                      return controller.currentPage.value != 2
                          ? GestureDetector(
                              onTap: controller.skip,
                              child: Container(
                                padding: EdgeInsets.all(5.w),
                                color: Colors.transparent,
                                child: Text(
                                  "Skip",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
                  ),
                ],
              ),
            ),
          ),

          // ---------------------------------------------------
          // 3. BOTTOM BUTTON (3-LAYER VISIBLE GRADIENT)
          // ---------------------------------------------------
          Positioned(
            bottom: 40.h,
            left: 24.w,
            right: 24.w,
            child: Obx(() => Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    // 🟢 3-Layer Gradient for High Visibility
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.0, 0.5, 1.0], // Defines where each color sits
                      colors: [
                        Color(0xFF1B4D3E), // 1. Deep Jungle Green (Darkest)
                        Color(0xFF2E7D58), // 2. Primary Green (Middle)
                        Color(0xFF66C285), // 3. Vivid Emerald (Lightest/Bright)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2E7D58).withValues(alpha: 0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    onPressed: controller.nextPage,
                    child: Text(
                      controller.currentPage.value == 2
                          ? "Get Started"
                          : "Next",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // HELPER: PAGE BUILDER
  // =========================================================
  Widget _buildPage({
    required String imagePath,
    required String title,
    String? subtitle,
    required List<Map<String, dynamic>> featureItems,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomImage(imageSrc: imagePath, fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.1),
                Colors.black.withValues(alpha: 0.5),
                Colors.black.withValues(alpha: 0.95),
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 100.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 34.sp, color: Colors.white, height: 1.2),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 16.h),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.5),
                  ),
                ],
                const Spacer(),
                _buildFeatureBox(featureItems),
                SizedBox(height: 120.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // HELPER: FEATURE BOX
  // =========================================================
  Widget _buildFeatureBox(List<Map<String, dynamic>> items) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 38.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withValues(alpha: 0.01)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _buildFeatureItem(items[i]['icon'], items[i]['text']),
            if (i != items.length - 1) SizedBox(height: 15.h),
          ]
        ],
      ),
    );
  }

  Widget _buildFeatureItem(dynamic iconSrc, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: iconSrc is String
              ? Image.asset(
                  iconSrc,
                  height: 20.sp,
                  width: 20.sp,
                  fit: BoxFit.contain,
                )
              : Icon(
                  iconSrc,
                  color: const Color(0xFFFFC107),
                  size: 20.sp,
                ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  // 🟢 3-Layer Gradient also applied to Active Dots
  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: isActive ? 24.w : 8.w,
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
                colors: [
                  Color(0xFF1B4D3E), // Dark
                  Color(0xFF2E7D58), // Mid
                  Color(0xFF66C285), // Light
                ],
              )
            : null,
        color: isActive ? null : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
