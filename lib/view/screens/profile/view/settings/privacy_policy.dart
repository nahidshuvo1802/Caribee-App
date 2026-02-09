import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// Custom Components Imports
import '../../../components/custom_image/custom_image.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
        ),
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomImage(
              imageSrc: "assets/images/profile/profilebg.png",
              imageType: ImageType.png,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildPolicyItem("1", "We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means."),
                          SizedBox(height: 15.h),
                          _buildPolicyItem("2", "We do not share any personally identifying information publicly or with third-parties, except when required to by law."),
                          SizedBox(height: 15.h),
                          _buildPolicyItem("3", "You are free to refuse our request for your personal information, with the understanding that we may not be able to provide you with some of your desired services."),
                          SizedBox(height: 15.h),
                          _buildPolicyItem("4", "Your continued use of our website will be regarded as acceptance of our practices around privacy and personal information."),
                          SizedBox(height: 15.h),
                          _buildPolicyItem("5", "Lorem ipsum dolor sit amet consectetur. Imperdiet iaculis convallis bibendum massa id elementum consectetur neque mauris."),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyItem(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$number.",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: const Color(0xFF333333),
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}