import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CaribeeHomeScreen extends StatefulWidget {
  const CaribeeHomeScreen({super.key});

  @override
  State<CaribeeHomeScreen> createState() => _CaribeeHomeScreenState();
}

class _CaribeeHomeScreenState extends State<CaribeeHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  // Mock 7-day forecast data
  final List<Map<String, dynamic>> _forecastDays = [
    {
      "day": "Mon",
      "icon": Icons.wb_sunny_rounded,
      "high": "30°",
      "low": "24°",
      "color": Color(0xFFFFB300)
    },
    {
      "day": "Tue",
      "icon": Icons.wb_sunny_rounded,
      "high": "31°",
      "low": "25°",
      "color": Color(0xFFFFB300)
    },
    {
      "day": "Wed",
      "icon": Icons.cloud,
      "high": "28°",
      "low": "23°",
      "color": Color(0xFF90A4AE)
    },
    {
      "day": "Thu",
      "icon": Icons.grain,
      "high": "27°",
      "low": "22°",
      "color": Color(0xFF42A5F5)
    },
    {
      "day": "Fri",
      "icon": Icons.wb_sunny_rounded,
      "high": "29°",
      "low": "24°",
      "color": Color(0xFFFFB300)
    },
    {
      "day": "Sat",
      "icon": Icons.wb_cloudy,
      "high": "28°",
      "low": "23°",
      "color": Color(0xFF78909C)
    },
    {
      "day": "Sun",
      "icon": Icons.wb_sunny_rounded,
      "high": "30°",
      "low": "24°",
      "color": Color(0xFFFFB300)
    },
  ];

  bool _showForecast = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.only(left: 12.w, top: 6.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 18.sp),
          ),
        ),
        actions: const [],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            // Background Image - Full screen
            Positioned.fill(
              child: Image.asset(
                "assets/images/Home/caribbean_beach_hero.png",
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay for bottom readability
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      const Color(0xFFF5F0E8).withValues(alpha: 0.3),
                      const Color(0xFFF5F0E8).withValues(alpha: 0.85),
                      const Color(0xFFF5F0E8),
                    ],
                    stops: const [0.0, 0.25, 0.4, 0.55, 0.65],
                  ),
                ),
              ),
            ),
            // Content
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),

                    // ═══════════════════════════════════════════
                    // 📝 TRAVEL CONFIDENTLY SECTION (TOP)
                    // ═══════════════════════════════════════════
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Travel Confidently with Caribee",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black.withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Stay informed, supported, and at ease while exploring the beautiful Caribbean with our trusted local insights.",
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.5,
                          shadows: [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.black.withValues(alpha: 0.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ═══════════════════════════════════════════
                    // 🌴 CARD 1: HERO LOCATION + WEATHER CARD
                    // ═══════════════════════════════════════════
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _buildHeroLocationCard(),
                    ),

                    SizedBox(height: 12.h),

                    // ═══════════════════════════════════════════
                    // 🌤️ CARD 2: WEATHER DETAILS CARD
                    // ═══════════════════════════════════════════
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _buildWeatherDetailsCard(),
                    ),

                    SizedBox(height: 20.h),

                    // ═══════════════════════════════════════════
                    // 🛡️ SAFETY STATUS SECTION
                    // ═══════════════════════════════════════════
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _buildSafetyStatusSection(),
                    ),

                    SizedBox(height: 25.h),

                    // ═══════════════════════════════════════════
                    // 📍 NEARBY HELP SECTION
                    // ═══════════════════════════════════════════
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _buildNearbyHelpSection(),
                    ),

                    SizedBox(height: 25.h),

                    // ═══════════════════════════════════════════
                    // 🆘 SUPPORT SECTION
                    // ═══════════════════════════════════════════
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _buildSupportSection(),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // 🌴 HERO LOCATION CARD
  // ═══════════════════════════════════════════════════════
  Widget _buildHeroLocationCard() {
    return Container(
      height: 240.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                "assets/images/Home/caribbean_beach_hero.png",
                fit: BoxFit.cover,
              ),
            ),
            // Dark gradient overlay for text readability
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.15),
                      Colors.black.withValues(alpha: 0.55),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location name with flag
                  Row(
                    children: [
                      Text(
                        "Ocho Rios",
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black.withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text("🇯🇲", style: TextStyle(fontSize: 20.sp)),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  // Status
                  Text(
                    "All clear today",
                    style: GoogleFonts.poppins(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.1,
                      shadows: [
                        Shadow(
                          blurRadius: 12,
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Weather quick info
                  Row(
                    children: [
                      Icon(Icons.wb_sunny_rounded,
                          color: const Color(0xFFFFD54F), size: 18.sp),
                      SizedBox(width: 4.w),
                      Text(
                        "29°C · Sunny",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.95),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  // Safety text
                  Text(
                    "No safety concerns reported",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Updated 2 mins ago",
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Spacer(),
                  // View Live Map button
                  GestureDetector(
                    onTap: () {
                      // Navigate to map
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.navigation_rounded,
                                  color: Colors.white, size: 16.sp),
                              SizedBox(width: 6.w),
                              Text(
                                "View Live Map",
                                style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // 🌤️ WEATHER DETAILS CARD
  // ═══════════════════════════════════════════════════════
  Widget _buildWeatherDetailsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                "assets/images/Home/sunny_weather_bg.png",
                fit: BoxFit.cover,
              ),
            ),
            // Glassmorphism overlay
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF0D7377).withValues(alpha: 0.65),
                        const Color(0xFF14919B).withValues(alpha: 0.55),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: Temperature + 7-day forecast button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sun icon + Temp
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.wb_sunny_rounded,
                            color: const Color(0xFFFFD54F),
                            size: 36.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "29°C",
                            style: GoogleFonts.poppins(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // 7-day forecast button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showForecast = !_showForecast;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "7-day forecast",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                _showForecast
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // Feels like + Humidity
                  Text(
                    "Feels 31° · Humidity 72%",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Weather tip
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.tips_and_updates_rounded,
                            color: const Color(0xFFFFD54F), size: 16.sp),
                        SizedBox(width: 6.w),
                        Flexible(
                          child: Text(
                            "Hydrate & wear sunscreen",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 7-day forecast expandable
                  if (_showForecast) ...[
                    SizedBox(height: 14.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _forecastDays.map((day) {
                          return Column(
                            children: [
                              Text(
                                day["day"],
                                style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Icon(
                                day["icon"] as IconData,
                                color: day["color"] as Color,
                                size: 20.sp,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                day["high"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                day["low"],
                                style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                  color: Colors.white.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // 🛡️ SAFETY STATUS SECTION
  // ═══════════════════════════════════════════════════════
  Widget _buildSafetyStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Safety Status",
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D2D2D),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Green status dot
              Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "No active safety alerts",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2D2D2D),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Colors.grey[400], size: 16.sp),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════
  // 📍 NEARBY HELP SECTION
  // ═══════════════════════════════════════════════════════
  Widget _buildNearbyHelpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nearby Help",
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D2D2D),
          ),
        ),
        SizedBox(height: 12.h),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildNearbyHelpCard(
                  icon: "assets/images/icon/hospital.png",
                  title: "Hospital",
                  subtitle: "Andrews Memorial",
                  distance: "3 min drive",
                  accentColor: const Color(0xFFE53935),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildNearbyHelpCard(
                  icon: "assets/images/icon/police-station.png",
                  title: "Police",
                  subtitle: "Ocho Rios Station",
                  distance: "5 min drive",
                  accentColor: const Color(0xFF1E88E5),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildNearbyHelpCard(
                  icon: "assets/images/icon/atm.png",
                  title: "ATM / Bank",
                  subtitle: "Scotiabank",
                  distance: "2 min walk",
                  accentColor: const Color(0xFFFF8F00),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyHelpCard({
    required String icon,
    required String title,
    required String subtitle,
    required String distance,
    required Color accentColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Content Group
          Column(
            children: [
              // Icon
              Image.asset(icon, height: 28.h, width: 28.w),
              SizedBox(height: 8.h),
              // Title
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D2D2D),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                distance,
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  color: Colors.grey[400],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          // Directions button
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 7.h),
            margin: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.navigation_rounded, color: accentColor, size: 13.sp),
                SizedBox(width: 4.w),
                Text(
                  "Directions",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: accentColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════
  // 🆘 SUPPORT SECTION
  // ═══════════════════════════════════════════════════════
  Widget _buildSupportSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "We're Here With You",
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
    );
  }

  Widget _buildSupportButton(
      {required String title, required String iconPath}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset(iconPath, height: 28.h, width: 28.w),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
