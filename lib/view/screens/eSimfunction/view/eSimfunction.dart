import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

// --- Custom Components ---
import '../../../../utils/app_colors/app_colors.dart';
import '../../components/custom_image/custom_image.dart';
import '../../components/custom_netwrok_image/custom_network_image.dart';
import '../../BussinessScreen/BussinessPromotionScreen.dart';

class EsimScreen extends StatelessWidget {
  const EsimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          "eSIM",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
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
              imageSrc: "assets/images/LoginScreen/homescreen.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              imageType: ImageType.png,
            ),
          ),

          // ------------------------------------------------
          // 2. Overlay & Content
          // ------------------------------------------------
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.5),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      // Header Text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Caribee",
                              style: GoogleFonts.poppins(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Stay connected\nFrom the Moment You Land",
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // "What's an eSIM?" Card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              // ---- SIM Icon Image (Updated: Full Fill) ----
                              Container(
                                height: 90.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  // color: const Color(0xFFC5E1A5),
                                  borderRadius: BorderRadius.circular(8.r),
                                  // ইমেজটি ব্যাকগ্রাউন্ড হিসেবে সেট করা হয়েছে যাতে পুরো জায়গা নেয়
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/Home/simicon1.png"),
                                    fit:
                                        BoxFit.cover, // পুরো কন্টেইনার ফিল করবে
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "What's an eSIM?",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      "An eSIM is a digital SIM card embedded in your phone. No physical card needed—just scan a QR code and you're online.",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Colors.grey[700],
                                        height: 1.4,
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

                      // "Why travelers love eSIMs"
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Why travelers love eSIMs:",
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            _buildFeatureRow(Icons.public,
                                "Instant internet on arrival", Colors.green),
                            _buildFeatureRow(
                                Icons.close,
                                "No swapping SIMs or losing your number",
                                Colors.red),
                            _buildFeatureRow(
                                Icons.signal_cellular_alt,
                                "Avoid expensive roaming charges",
                                Colors.green),
                            _buildFeatureRow(
                                Icons.map,
                                "Perfect for maps, ride apps, WhatsApp & safety features",
                                Colors.green),
                            _buildFeatureRow(
                                Icons.network_check,
                                "Fast, reliable data powered by trusted networks",
                                Colors.green),
                          ],
                        ),
                      ),

                      SizedBox(height: 25.h),

                      // Provider Cards (Airalo & Ubigi)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. Airalo Card
                            _buildProviderCard(
                              logoUrl: "assets/images/Home/Airalo_logo.svg.png",
                              name: "Airalo",
                              description: "The world’s first eSIM store",
                              features: [
                                "Coverage in 200+ countries",
                                "Affordable local rates",
                                "Instant activation"
                              ],
                              onTap: () {
                                Get.to(
                                    () => const EsimWebViewScreen(
                                          url:
                                              "https://www.airalo.com/?srsltid=AfmBOorZK91onscjR6-Hkz4rxyWyDQevsSlOret0-T-yp9kwjgTqnQQm",
                                          title: "Airalo",
                                        ),
                                    transition: Transition.fadeIn);
                              },
                            ),
                            SizedBox(width: 15.w),

                            // 2. Ubigi Card with Special Offer Ribbon
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                _buildProviderCard(
                                  logoUrl:
                                      "assets/images/Home/Ubigi-Logo-Travel-eSIM.png",
                                  name: "Ubigi",
                                  description:
                                      "High-end global cellular connectivity",
                                  features: [
                                    "Prepaid data plans",
                                    "Great for business travel",
                                    "Reliable 5G/4G/LTE"
                                  ],
                                  onTap: () {
                                    Get.to(
                                        () => const EsimWebViewScreen(
                                              url:
                                                  "https://cellulardata.ubigi.com/?gad_source=1&gad_campaignid=23023584203&gbraid=0AAAAA9UrVJL2sWKgi4q1oP47hJQE8w8P8&gclid=Cj0KCQiA1czLBhDhARIsAIEc7uipWSY8T8eL0ELpc8q-Sd9WyCid0m4SjVRA4pmx5peg-C9tXDVvux4aAq5GEALw_wcB",
                                              title: "Ubigi",
                                            ),
                                        transition: Transition.fadeIn);
                                  },
                                ),
                                // Premium Ribbon
                                Positioned(
                                  top: -5.h,
                                  right: -5.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ClipPath(
                                      clipper: RibbonClipper(),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFE53935),
                                              Color(0xFFD32F2F),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.local_offer,
                                              color: Colors.white,
                                              size: 12.sp,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              "Special Offer",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
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
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // --- Exclusive Offer Banner (Same as Profile Screen) ---
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/Home/fire.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  const Color.fromRGBO(255, 98, 0, 1)
                                      .withOpacity(0.85),
                                  const Color.fromRGBO(107, 28, 29, 1)
                                      .withOpacity(0.85),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/profile/fastfood.png",
                                      height: 30.h,
                                      width: 30.w,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Exclusive offer By",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14.sp),
                                        ),
                                        Text(
                                          "Caribee",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => BusinessPromotionScreen(),
                                        transition: Transition.fadeIn);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFC107),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      "See Offer",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Footer & "Get My eSIM Now" Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Takes just minutes to install before travel",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),

                            // ---- Button with Background Image ----
                            GestureDetector(
                              onTap: () {
                                print("Get eSIM Clicked");
                              },
                              child: Container(
                                height: 56.h,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/Home/esim.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Text(
                                  "Get My eSIM Now",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30.h),
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

  // --- Helper Widgets ---

  Widget _buildFeatureRow(IconData icon, String text, Color iconColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderCard({
    required String logoUrl,
    required String name,
    required String description,
    required List<String> features,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 240.w,
      height: 260.h, // Fixed height for uniform cards
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Header: Logo & Name
          Row(
            children: [
              // Logo Image
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Container(
                  height: 35.h,
                  width: 35.w,
                  color: Colors.transparent,
                  child: logoUrl.startsWith('http')
                      ? CustomNetworkImage(
                          imageUrl: logoUrl,
                          height: 35.h,
                          width: 35.w,
                        )
                      : Image.asset(
                          logoUrl,
                          height: 35.h,
                          width: 35.w,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Description
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:
                GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey[700]),
          ),
          SizedBox(height: 10.h),

          // Features List
          ...features.map((feature) => Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: _buildCheckItem(feature),
              )),

          const Spacer(), // Push button to bottom

          // ---- Explore More Button with Gradient ----
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 40.h,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                // UPDATED: Using Gradient Green
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2E5C38), // Dark Green
                    Color(0xFF66B290), // Light Green
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Text(
                "Explore More",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline,
            color: const Color(0xFF35704E), size: 14.sp),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
                fontSize: 11.sp, color: Colors.grey[600], height: 1.2),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------------
// WEBVIEW SCREEN Widget (In-app Browser)
// ------------------------------------------------------------------------
class EsimWebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const EsimWebViewScreen({super.key, required this.url, required this.title});

  @override
  State<EsimWebViewScreen> createState() => _EsimWebViewScreenState();
}

class _EsimWebViewScreenState extends State<EsimWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            // Handle error if needed
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.title, style: GoogleFonts.poppins(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: Color(0xFF35704E)),
            ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------------
// RIBBON CLIPPER - Custom Clipper for Special Offer Ribbon
// ------------------------------------------------------------------------
class RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final foldSize = size.height * 0.25;

    // Start from top-left
    path.moveTo(0, 0);
    // Top edge
    path.lineTo(size.width, 0);
    // Right edge
    path.lineTo(size.width, size.height - foldSize);
    // Bottom-right fold
    path.lineTo(size.width - foldSize, size.height);
    // Bottom edge
    path.lineTo(0, size.height);
    // Close path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
