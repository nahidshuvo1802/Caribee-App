import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_app/view/screens/profile/view/settings/privacy&policy.dart';
import 'package:tutor_app/view/screens/profile/view/settings/termsOfServicesScreen.dart';

// Custom Components Imports
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../../utils/app_colors/app_colors.dart';
import 'settings/changePasswordScreen.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // --- AppBar Updated (iOS Back Button) ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:
              Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
        ),
        title: Text(
          "Account Settings",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          // ------------------------------------------------
          // 1. Background Image
          // ------------------------------------------------
          Positioned.fill(
            child: CustomImage(
              imageSrc: "assets/images/profile/profilebg.png",
              imageType: ImageType.png,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),

          // ------------------------------------------------
          // 2. Content Body
          // ------------------------------------------------
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20.h), // AppBar এর নিচে স্পেস

                // --- Settings List Container ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSettingsItem(
                          title: "Change Password",
                          onTap: () {
                            Get.to(() => const ChangePasswordScreen(),
                                transition: Transition.fadeIn);
                          },
                        ),
                        _buildDivider(),
                        _buildSettingsItem(
                          title: "Terms of Services",
                          onTap: () {
                            Get.to(() => const TermsOfServicesScreen(),
                                transition: Transition.fadeIn);
                          },
                        ),
                        _buildDivider(),
                        _buildSettingsItem(
                          title: "Privacy Policy",
                          onTap: () {
                            Get.to(() => const PrivacyPolicyScreen(),
                                transition: Transition.fadeIn);
                          },
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

  // --- Helper Widget: Settings Item ---
  Widget _buildSettingsItem({
    required String title,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: isLast
            ? BorderRadius.vertical(bottom: Radius.circular(16.r))
            : BorderRadius.vertical(top: Radius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black_80,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: AppColors.black_80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widget: Divider ---
  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: AppColors.black.withOpacity(0.1),
      indent: 20.w,
      endIndent: 20.w,
    );
  }
}
