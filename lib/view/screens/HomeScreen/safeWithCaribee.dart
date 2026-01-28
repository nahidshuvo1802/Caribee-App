import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../components/custom_button/custom_button.dart';
import '../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../components/custom_text/custom_text.dart';

class CaribeeHomeScreen extends StatelessWidget {
  const CaribeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Using AppColors
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
            child: Icon(Icons.arrow_back_ios)),
        title: Text("Caribee",style: TextStyle(
          fontSize: 26.h,
          color: CupertinoColors.black,
          fontWeight: FontWeight.w600,
        ),
        ),
        centerTitle: true,


      ) ,
      // CustomRoyelAppbar(
      //   titleName: "Caribee",
      //   leftIcon: true,
      //   // Enables the back button
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title Section
            CustomText(
              text: "Travel Confidently with Caribee",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTitleTextClr,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "Stay informed, supported, and at ease while exploring the beautiful Caribbean with our trusted local insights.",
              fontSize: 12.sp,
              color: AppColors.grey_03,
              maxLines: 3,
              textAlign: TextAlign.start,
            ),

            SizedBox(height: 16.h),

            /// Green Status Banner
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                // গ্রেডিয়েন্ট কালার বজায় রাখা হয়েছে
                gradient: const LinearGradient(
                  colors: [AppColors.green, AppColors.primary],
                ),
                // 🟢 ব্যাকগ্রাউন্ড ইমেজ এখানে অ্যাড করা হয়েছে
                image: DecorationImage(
                  image: const AssetImage("assets/images/Home/esim.png"),
                  fit: BoxFit.cover,
                  opacity: 3, // ইমেজটি হালকা করে দেওয়া হয়েছে যাতে টেক্সট পড়া যায়
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: AppColors.green, size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Everything calm across your area today",
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          text: "No unusual alerts. Enjoy your trip!",
                          color: AppColors.white_50,
                          fontSize: 12.sp,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 24.h),

            /// Alerts Section
            CustomText(
              text: "Real-Time Travel Alerts",
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTitleTextClr,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "Stay informed, supported, and at ease while exploring the beautiful Caribbean with our trusted local insights.",
              fontSize: 12.sp,
              color: AppColors.grey_03,
              maxLines: 3,
              textAlign: TextAlign.start,
            ),

            SizedBox(height: 16.h),

            /// Alert Card
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _alertRow(
                    icon: Icons.wb_sunny,
                    title: "Sunny Weather Warning",
                    hasButton: true,
                  ),
                  Divider(color: AppColors.grey_02, height: 20.h),
                  _alertRow(
                    icon: Icons.eco,
                    title: "Stay Hydrated. Seek Shade",
                    subtitle: "Updated Just Now",
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),



            /// Nearby Essentials
            CustomText(
              text: "Nearby Essentials",
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTitleTextClr,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 12.h),

            Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.grey_02),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.local_police, color: AppColors.blue, size: 28.sp),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: "Police Station",
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          text: "0.4 km",
                          fontSize: 10.sp,
                          color: AppColors.grey_03,
                        ),
                        SizedBox(height: 8.h),
                        // Small Custom Button for Direction
                        CustomButton(
                          onTap: (){},
                          title: "Direction",
                          height: 30.h,
                          fontSize: 10.sp,
                          fillColor: AppColors.orange,
                          borderRadius: 20.r,
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 24.h),

            /// Bottom Info Card
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(color: AppColors.black.withOpacity(0.1), blurRadius: 10),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "We’re Here With You",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _BottomItem(icon: Icons.headset_mic),
                      _BottomItem(icon: Icons.warning_amber),
                      _BottomItem(icon: Icons.help_outline),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _alertRow({
    required IconData icon,
    required String title,
    String? subtitle,
    bool hasButton = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.orange, size: 24.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                textAlign: TextAlign.start,
              ),
              if (subtitle != null)
                CustomText(
                  text: subtitle,
                  color: AppColors.grey_03,
                  fontSize: 12.sp,
                  textAlign: TextAlign.start,
                ),
            ],
          ),
        ),
        if (hasButton)
          SizedBox(
            width: 100.w,
            child: CustomButton(
              onTap: (){},
              title: "View Details",
              height: 35.h,
              fontSize: 10.sp,
              fillColor: AppColors.orange,
              borderRadius: 8.r,
            ),
          )
      ],
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  const _BottomItem({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30.sp, color: AppColors.primary),
        SizedBox(height: 4.h),
        CustomText(
          text: "View Details",
          fontSize: 12.sp,
          color: AppColors.grey_03,
        ),
      ],
    );
  }
}