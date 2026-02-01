import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CaribeeHomeScreen extends StatefulWidget {
  const CaribeeHomeScreen({super.key});

  @override
  State<CaribeeHomeScreen> createState() => _CaribeeHomeScreenState();
}

class _CaribeeHomeScreenState extends State<CaribeeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Caribee",
          style: GoogleFonts.poppins(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w)
            .copyWith(bottom: 30.h, top: 10.h),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Title: Travel Confidently with Caribee
            Text(
              "Travel Confidently with Caribee",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Stay informed, supported, and at ease while exploring the beautiful Caribbean with our trusted local insights.",
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),

            // 2. Banner: Green Status
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: const Color(0xFF2E5C38), // Fallback color
                image: const DecorationImage(
                  image: AssetImage("assets/images/Home/homepagebg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4C846C).withOpacity(0.9),
                      const Color(0xFF2E5C38).withOpacity(0.95),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: const BoxDecoration(
                          color: Colors.white24, shape: BoxShape.circle),
                      child: Image.asset(
                        "assets/images/icon/yellowtick.png",
                        height: 36.h,
                        width: 36.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Everything calm across you area today",
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "No unusual alerts. Enjoy your trip!",
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25.h),

            // 3. Real-Time Travel Alerts
            Text(
              "Real-Time Travel Alerts",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Stay informed, supported, and at ease while exploring the beautiful Caribbean with our trusted local insights.",
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),

            // Weather & Hydration Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Weather Row
                  Row(
                    children: [
                      Image.asset("assets/images/icon/sun.png",
                          height: 32.h, width: 32.w),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "Sunny Weather Warning",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD54F),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "View Details",
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child:
                        Divider(color: Colors.grey.withOpacity(0.1), height: 1),
                  ),
                  // Hydration Row
                  Row(
                    children: [
                      Image.asset("assets/images/icon/leaf.png",
                          height: 28.h, width: 28.w),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "Stay Hydrated. Seek Shade",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Text(
                        "Updated Just Now",
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Safety Card
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: Image.asset("assets/images/icon/shield.png",
                        height: 24.h, width: 24.w),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "Travel Confidently & Safe with Caribee",
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD54F),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "Explore More",
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            // 4. Nearby Essentials
            Text(
              "Nearby Essentials",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNearbyCard(
                  title: "Police Station",
                  distance: "0.4 km",
                  imagePath: "assets/images/icon/policelogo.png",
                ),
                _buildNearbyCard(
                  title: "Hospital",
                  distance: "0.4 km",
                  imagePath: "assets/images/icon/policelogo.png",
                ),
                _buildNearbyCard(
                  title: "Public Toilet",
                  distance: "0.4 km",
                  imagePath: "assets/images/icon/policelogo.png",
                ),
              ],
            ),

            SizedBox(height: 25.h),

            // 5. Real-Time Travel Alerts (Second Section)
            Text(
              "Real-Time Travel Alerts",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Stay informed, supported, and at ease while exploring the beautiful Caribbean with our trusted local insights.",
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),

            // We're Here With You Card
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "We’re Here With You",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSupportButton(
                        title: "Live\nSupport",
                        iconPath: "assets/images/icon/customercare.png",
                      ),
                      _buildSupportButton(
                        title: "Report a\nproblem",
                        iconPath: "assets/images/icon/warning.png",
                      ),
                      _buildSupportButton(
                        title: "FAQs\n",
                        iconPath: "assets/images/icon/warningbubble.png",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyCard({
    required String title,
    required String distance,
    required String imagePath,
  }) {
    return Container(
      width: 105.w,
      height: 140.h, // Fixed height to make all cards same
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Distribute space evenly
        children: [
          Image.asset(imagePath, height: 30.h, width: 30.w),
          Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                distance,
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "Direction",
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Colors.orange[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportButton(
      {required String title, required String iconPath}) {
    return Column(
      children: [
        Image.asset(iconPath, height: 40.h, width: 40.w),
        SizedBox(height: 8.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
