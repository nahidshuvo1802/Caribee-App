import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Custom Components ---
// Ensure these paths match your project structure
import '../../components/custom_image/custom_image.dart';
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_nav_bar/navbar.dart';
import '../../components/custom_netwrok_image/custom_network_image.dart';

// --- Screens Import ---
import '../BussinessScreen/BussinessPromotionScreen.dart';
import 'EventScreen.dart';
import 'ExperienceScreen.dart';

import 'RestaurantScreen.dart';
import 'RestaurantDetailsScreen.dart';
import 'EventDetailsScreen.dart';
import 'ExperienceDetailsScreen.dart';
import 'safeWithCaribee.dart';
import '../eSimfunction/view/eSimfunction.dart';
// Added based on context usage

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // 🟢 Static variable to track if the offer has been shown in this session
  static bool hasShownOffer = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // 🟢 Scroll-aware NavBar Variables
  bool _isNavBarVisible = true;
  late AnimationController _navBarAnimController;
  late Animation<Offset> _navBarSlideAnimation;
  DateTime _lastScrollTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    // 🟢 Initialize NavBar Animation
    _navBarAnimController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _navBarSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _navBarAnimController,
      curve: Curves.easeInOut,
    ));

    // 🟢 Check if offer is already shown
    if (!HomeScreen.hasShownOffer) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          _showSpecialOffersModal(context);
          // 🟢 Mark as shown so it doesn't appear again in this session
          HomeScreen.hasShownOffer = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _navBarAnimController.dispose();
    super.dispose();
  }

  // 🟢 Handle Scroll Notification (Matching EventDetailsScreen)
  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      _lastScrollTime = DateTime.now();
      if (_isNavBarVisible) {
        setState(() => _isNavBarVisible = false);
        _navBarAnimController.forward();
      }
      _checkScrollStopped();
    }
    return false;
  }

  void _checkScrollStopped() async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (DateTime.now().difference(_lastScrollTime).inMilliseconds >= 150) {
      if (!_isNavBarVisible && mounted) {
        setState(() => _isNavBarVisible = true);
        _navBarAnimController.reverse();
      }
    }
  }

  // --- 🟢 SPECIAL OFFERS POPUP FUNCTION ---
  void _showSpecialOffersModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: false,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Special Offers",
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Curated promotions from trusted local partners.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildOfferCard(
                        title: "Blue Mountain Bistro",
                        location: "Ocho Rios",
                        offerText: "Enjoy 15% off authentic Jamaican cuisine",
                        imageUrl:
                            "https://images.unsplash.com/photo-1555126634-323283e090fa?q=80&w=1000&auto=format&fit=crop",
                        onTap: () {
                          Get.back();
                          Get.to(() => BusinessPromotionScreen());
                        }),
                    SizedBox(height: 15.h),
                    _buildOfferCard(
                        title: "Dolphin Cove Adventure",
                        location: "Ocho Rios",
                        offerText: "Buy 1 Get 1 Free on Swim adventures",
                        imageUrl:
                            "https://images.unsplash.com/photo-1570481662006-a3a1374699e8?q=80&w=600&auto=format&fit=crop",
                        onTap: () {
                          Get.back();
                          Get.to(() => BusinessPromotionScreen());
                        }),
                    SizedBox(height: 15.h),
                    _buildOfferCard(
                        title: "Heritage Craft Village",
                        location: "Kingston",
                        offerText:
                            "Guided artisan tour with exclusive workshop",
                        imageUrl: "assets/images/Home/heritage_craft.png",
                        onTap: () {
                          Get.back();
                          Get.to(() => BusinessPromotionScreen());
                        }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),

              // 🟢 GRADIENT BUTTON IMPLEMENTATION STARTS HERE
              Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 30.h, top: 10.h),
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF66B290), // Light Green
                        Color(0xFF4C846C), // Your Original Green
                        Color(0xFF2E5C38), // Dark Green
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Important: Transparent
                      shadowColor: Colors.transparent, // Important: No shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Skip for now",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              // 🟢 GRADIENT BUTTON ENDS HERE
            ],
          ),
        );
      },
    );
  }

  Widget _buildOfferCard({
    required String title,
    required String location,
    required String offerText,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          image: DecorationImage(
            image: imageUrl.startsWith('http')
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    location,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    offerText,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE65100), Color(0xFFA52A2A)],
                      ),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Text(
                      "Explore More",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    // --- Mock Data ---

    final List<Map<String, String>> weeklyFeatured = [
      {
        "title": "Sunset Catamaran Cruise",
        "rating": "4.9",
        "location": "Negril • 2.5 km",
        "image":
            "https://images.unsplash.com/photo-1544644181-1484b3fdfc62?q=80&w=600&auto=format&fit=crop",
        "tag": "Top Rated"
      },
      {
        "title": "Mystic Mountain",
        "rating": "4.7",
        "location": "Ocho Rios • 1.0 km",
        "image":
            "https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?q=80&w=600&auto=format&fit=crop",
        "tag": "Weekly Pick"
      },
    ];

    final List<Map<String, String>> restaurants = [
      {
        "title": "Ochos Rios Jerk Centre",
        "rating": "4.5",
        "location": "Ochos Rios • 0.4 km",
        "image":
            "https://images.unsplash.com/photo-1594041680534-e8c8cdebd659?q=80&w=600&auto=format&fit=crop",
        "tag": "Trusted"
      },
      {
        "title": "Miss T's Kitchen",
        "rating": "4.7",
        "location": "Ocho Rios • 0.8 km",
        "image":
            "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=600&auto=format&fit=crop",
        "tag": "Popular"
      },
    ];

    final List<Map<String, String>> experience = [
      {
        "title": "Mountain Peak Adventure Hiking",
        "rating": "4.8",
        "location": "Ochos Rios • 0.5 km",
        "image":
            "https://images.unsplash.com/photo-1501555088652-021faa106b9b?q=80&w=600&auto=format&fit=crop",
        "tag": "Popular"
      },
      {
        "title": "Dolphin Cove",
        "rating": "4.7",
        "location": "Ochos Rios • 2.0 km",
        "image":
            "https://images.unsplash.com/photo-1570481662006-a3a1374699e8?q=80&w=600&auto=format&fit=crop",
        "tag": "Trending"
      },
    ];

    final List<Map<String, String>> events = [
      {
        "title": "Reggae Sumfest",
        "rating": "4.9",
        "location": "Montego Bay • 5.0 km",
        "image":
            "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=600&auto=format&fit=crop",
        "tag": "Live"
      },
      {
        "title": "Carnival in Jamaica",
        "rating": "4.8",
        "location": "Kingston • 3.0 km",
        "image": "assets/images/Home/carnival.png",
        "tag": "Upcoming"
      },
      {
        "title": "Rebel Salute",
        "rating": "5.0",
        "location": "Plantation Cove • 10 km",
        "image":
            "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=600&auto=format&fit=crop",
        "tag": "Featured"
      },
    ];

    return Scaffold(
      extendBody: true,
      // 🟢 1. Extend Body behind AppBar
      extendBodyBehindAppBar: true,
      bottomNavigationBar: SlideTransition(
        position: _navBarSlideAnimation,
        child: const NavBar(currentIndex: 0),
      ),

      // 🟢 2. Added Transparent AppBar with Title and Notification
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false, // Title stays left aligned like original
        automaticallyImplyLeading: false, // Removes default back button
        title: Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: CustomText(
            text: "Caribee",
            fontSize: 36.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFD15C),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const CaribeeHomeScreen()),
            child: Container(
              margin: EdgeInsets.only(right: 20.w),
              child: CustomImage(
                imageSrc: "assets/images/icon/security.png",
                imageType: ImageType.png,
                height: 35.h,
                width: 35.w,
              ),
            ),
          )
        ],
      ),

      body: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: Stack(
          children: [
            // Background with Reduced Opacity
            Positioned.fill(
              child: CustomImage(
                imageSrc: "assets/images/Home/homepagebg.png",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                imageType: ImageType.png,
              ),
            ),

            SafeArea(
              bottom: false,
              // 🟢 3. Adjusted padding to account for AppBar (no manual header row anymore)
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 110.h, top: 10.h),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🟢 Manual "Caribee" Header Row Removed

                    // --- Tagline ---
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: CustomText(
                        text: "Discover Jamaica Beyond The\nBeaches",
                        fontSize: 18
                            .sp, // ✅ This .sp now works correctly without double scaling
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFAEFD6),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: CustomText(
                        text:
                            "Curated experiences,real culture,trusted guidance",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFAEFD6),
                        textAlign: TextAlign.left,
                        top: 5.h,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // --- Filter Chips ---
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: Row(
                          children: [
                            _buildFilterChip("All", true),
                            SizedBox(width: 10.w),
                            _buildFilterChip("Restaurants", false, onTap: () {
                              Get.to(() => const RestaurantScreen());
                            }),
                            SizedBox(width: 10.w),
                            _buildFilterChip("Experiences", false, onTap: () {
                              Get.to(() => const ExperiencesScreen());
                            }),
                            SizedBox(width: 10.w),
                            _buildFilterChip("Events", false, onTap: () {
                              Get.to(() => const EventScreen());
                            }),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // --- Map Widget (With Glassmorphism Overlay) ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        height: 140.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/Home/map.png"),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // ✅ Updated Full-Width Glassmorphism Header
                            Positioned(
                              top: 0,
                              left: 0,
                              right:
                                  0, // বাম এবং ডান দুই পাশেই 0 দিলে এটি পুরো জায়গা নিবে
                              child: ClipRRect(
                                // শুধুমাত্র ওপরের কর্নারগুলো প্যারেন্ট কন্টেইনারের মতো রাউন্ড হবে
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10.0,
                                      sigmaY: 10.0), // 🔹 Blur Effect
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFBF4E4).withValues(
                                          alpha:
                                              0.7), // ইমেজের মতো হালকা ক্রিম/সাদা কালার
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                color: const Color(0xFF2E5C38),
                                                size: 20.sp),
                                            SizedBox(width: 8.w),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Kingston",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "  ·  Nearby Excursion",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.sp,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.arrow_forward_ios,
                                            color: const Color(0xFF2E5C38),
                                            size: 16.sp),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h),

                    // --- eSIM Banner ---
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Container(
                        // 🟢 1. Background Image in Outer Container
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                            image:
                                const AssetImage("assets/images/Home/esim.png"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              const Color(0xFF2E5C38).withValues(alpha: 0.2),
                              BlendMode.multiply,
                            ),
                          ),
                        ),
                        // 🟢 2. Gradient Overlay in Inner Container
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 8.h), // 🟢 Reduced height
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white.withValues(
                                    alpha: 0.3), // বাম পাশে হালকা সাদা ভাব
                                Colors.transparent, // ডান পাশে ট্রান্সপারেন্ট
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // 🟢 3. REPLACED ICON WITH NEW ASSET IMAGE & RESIZED
                                  Container(
                                    height: 35.h, // Smaller height
                                    width: 28.w, // Proportional width
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/Home/simicon1.png"), // New Logo
                                        fit: BoxFit.contain,
                                      ),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),

                                  SizedBox(width: 8.w),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Stay Connected with",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 12.sp)), // Smaller font
                                      Text("Caribee",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 20.sp, // Smaller font
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const EsimScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 5.h), // Smaller Button
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFC107),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    "Learn More",
                                    style: GoogleFonts.poppins(
                                        fontSize: 10.sp, // Smaller font
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // --- Section 1: Weekly Featured ---
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: _buildSectionHeader("Weekly Featured"),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child:
                          _buildHorizontalList(weeklyFeatured, onTap: (item) {
                        Get.to(() => const Experiencedetailsscreen());
                      }),
                    ),

                    SizedBox(height: 25.h),

                    // --- Section 2: Featured Restaurant ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _buildSectionHeader(
                        "Featured Restaurants",
                        onTap: () => Get.to(() => const RestaurantScreen()),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: _buildHorizontalList(restaurants,
                            onTap: (item) =>
                                Get.to(() => const RestaurantDetailsPage()))),

                    SizedBox(height: 25.h),

                    // --- Section 3: Featured Experience ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _buildSectionHeader(
                        "Featured Experiences",
                        onTap: () => Get.to(() => const ExperiencesScreen()),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: _buildHorizontalList(experience,
                            onTap: (item) =>
                                Get.to(() => const Experiencedetailsscreen()))),

                    SizedBox(height: 25.h),

                    // --- Section 4: Featured Events ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _buildSectionHeader(
                        "Featured Events",
                        onTap: () => Get.to(() => const EventScreen()),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: _buildHorizontalList(events,
                            onTap: (item) =>
                                Get.to(() => const Eventdetailsscreen()))),

                    SizedBox(height: 25.h),

                    // --- Footer Banner ---
                    // --- Footer Banner ---
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: ClipRRect(
                        // 🟢 1. ব্লার ইফেক্টকে বর্ডারের ভেতরে রাখার জন্য ClipRRect
                        borderRadius: BorderRadius.circular(16.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 1.0,
                              sigmaY: 1.0), // 🟢 2. হালকা ব্লার (Light Blur)
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 15.w),
                            decoration: BoxDecoration(
                              // 🟢 3. ব্যাকগ্রাউন্ডে হালকা কালো শেড (যাতে টেক্সট ফুটে ওঠে)
                              color: Colors.black.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                  color: Colors.amber.withValues(alpha: 0.4)),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/icon/safetyicon.png",
                                  height: 30
                                      .sp, // আগের আইকনের সাইজ অনুযায়ী রাখা হয়েছে
                                  width: 38.sp,
                                  fit: BoxFit.contain,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Travel Confidently &",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 12.sp)),
                                    Text("Safe with Caribee",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const CaribeeHomeScreen());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFC107),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      "Explore More",
                                      style: GoogleFonts.poppins(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Star Rating Helper ---
  Widget _buildStarRating(double rating, {double size = 12}) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      IconData icon;
      if (rating >= i) {
        icon = Icons.star;
      } else if (rating >= i - 0.5) {
        icon = Icons.star_half;
      } else {
        icon = Icons.star_border;
      }
      stars.add(Icon(icon, color: Colors.amber, size: size));
    }
    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }

  // 👇 Modified Widget to make chips look elevated (3D)
  Widget _buildFilterChip(String text, bool isSelected, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),

          // 🟢 1. Gradient for Selected State
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    Color.fromRGBO(46, 111, 101, 1), // Start Color
                    Color.fromRGBO(88, 151, 107, 1), // End Color
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null, // Unselected state এ কোনো gradient থাকবে না

          // 🟢 2. Solid Color for Unselected State
          // (Gradient থাকলে color অবশ্যই null হতে হবে)
          color: isSelected
              ? null
              : const Color.fromRGBO(
                  245, 208, 118, 0.64), // Non-selected opacity color

          // 🟢 3. Solid Shadow logic
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: Color.fromRGBO(224, 247, 184, 1), // Shadow Color
                    offset: Offset(0, 4), // নিচে নামবে
                    blurRadius:
                        0, // 👈 এটাই সলিড শ্যাডো তৈরি করে (কোনো ঝাপসা ভাব নেই)
                    spreadRadius: 0,
                  ),
                ]
              : [], // Unselected অবস্থায় শ্যাডো দিইনি (ক্লিন লুকের জন্য), চাইলে এখানেও হালকা শ্যাডো দিতে পারো
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            // Selected হলে সাদা টেক্সট, না হলে কালো
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          textAlign: TextAlign.left,
        ),
        if (onTap != null)
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: const Color(0xFFFFD15C),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "View All",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFFD15C),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10.sp,
                    color: const Color(0xFFFFD15C),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHorizontalList(List<Map<String, String>> items,
      {required Function(Map<String, String>) onTap}) {
    return SizedBox(
      height: 240.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(width: 15.w),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => onTap(item),
            child: Container(
              width: 250.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: item["image"]!.startsWith('http')
                      ? NetworkImage(item["image"]!)
                      : AssetImage(item["image"]!) as ImageProvider,
                  fit: BoxFit.cover,
                  opacity: 0.15,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        item["image"]!.startsWith('http')
                            ? CustomNetworkImage(
                                imageUrl: item["image"]!,
                                width: double.infinity,
                                height: double.infinity,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.r)),
                              )
                            : Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r)),
                                  image: DecorationImage(
                                    image: AssetImage(item["image"]!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Positioned(
                          top: 8.h,
                          left: 8.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Row(
                              children: [
                                // 🟢 CUSTOM ICON LOGIC FOR TRUSTED TAG
                                item["tag"] == "Trusted"
                                    ? Image.asset(
                                        "assets/images/icon/trusted.png",
                                        height: 12.sp,
                                        width: 12.sp,
                                        fit: BoxFit.contain,
                                      )
                                    : item["tag"] == "Top Rated"
                                        ? Image.asset(
                                            "assets/images/icon/favorite.png",
                                            height: 12.sp,
                                            width: 12.sp,
                                            fit: BoxFit.contain,
                                          )
                                        : item["tag"] == "Weekly Pick"
                                            ? Image.asset(
                                                "assets/images/icon/7-days.png",
                                                height: 12.sp,
                                                width: 12.sp,
                                                fit: BoxFit.contain,
                                              )
                                            : item["tag"] == "Trending"
                                                ? Image.asset(
                                                    "assets/images/icon/trend.png",
                                                    height: 12.sp,
                                                    width: 12.sp,
                                                    fit: BoxFit.contain,
                                                  )
                                                : item["tag"] == "Live"
                                                    ? Image.asset(
                                                        "assets/images/icon/live-stream.png",
                                                        height: 12.sp,
                                                        width: 12.sp,
                                                        fit: BoxFit.contain,
                                                      )
                                                    : item["tag"] == "Upcoming"
                                                        ? Image.asset(
                                                            "assets/images/icon/upcoming.png",
                                                            height: 12.sp,
                                                            width: 12.sp,
                                                            fit: BoxFit.contain,
                                                          )
                                                        : item["tag"] ==
                                                                "Featured"
                                                            ? Image.asset(
                                                                "assets/images/icon/featured.png",
                                                                height: 12.sp,
                                                                width: 12.sp,
                                                                fit: BoxFit
                                                                    .contain,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .local_fire_department,
                                                                color: Colors
                                                                    .orange,
                                                                size: 12.sp,
                                                              ),
                                SizedBox(width: 4.w),
                                Text(item["tag"]!,
                                    style: GoogleFonts.poppins(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item["title"]!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp)),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              _buildStarRating(
                                  double.tryParse(item["rating"]!) ?? 0.0,
                                  size: 12.sp),
                              SizedBox(width: 4.w),
                              Text(
                                item["rating"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 12.h,
                                width: 1.w,
                                color: Colors.grey,
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                              ),
                              Icon(Icons.location_on,
                                  color: Colors.red, size: 14.sp),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  item["location"]!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12.sp, color: Colors.grey[700]),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
