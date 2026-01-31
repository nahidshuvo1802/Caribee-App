import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Custom Components Imports ---
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_netwrok_image/custom_network_image.dart';
import '../../components/custom_nav_bar/navbar.dart';

// --- Utils Imports ---
import '../../../utils/app_colors/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  // 🟢 Scroll-aware NavBar Variables
  bool _isNavBarVisible = true;
  late AnimationController _navBarAnimController;
  late Animation<Offset> _navBarSlideAnimation;
  DateTime _lastScrollTime = DateTime.now();

  // Selected Category Index
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    "All",
    "Restaurants",
    "Experiences",
    "Events"
  ];

  // Mock Data for Locations
  final List<Map<String, dynamic>> _locations = [
    {
      "id": "1",
      "name": "Bistro Moderne",
      "rating": 4.8,
      "type": "French Cuisine",
      "image":
          "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=800",
    },
    {
      "id": "2",
      "name": "Konoko Falls",
      "rating": 4.9,
      "type": "Nature • Waterfall",
      "image":
          "https://images.unsplash.com/photo-1468577760773-139c2f1c335f?q=80&w=600",
    },
    {
      "id": "3",
      "name": "Reggae Sumfest",
      "rating": 5.0,
      "type": "Music Festival",
      "image":
          "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=800",
    },
  ];

  // Page Controller for the bottom list
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);

    // 🟢 Initialize NavBar Animation
    _navBarAnimController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _navBarSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _navBarAnimController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _navBarAnimController.dispose();
    super.dispose();
  }

  // 🟢 Handle Scroll Notification
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SlideTransition(
        position: _navBarSlideAnimation,
        child: const NavBar(currentIndex: 1),
      ),
      body: Stack(
        children: [
          // ------------------------------------------------
          // 1. Map Image Background
          // ------------------------------------------------
          Positioned.fill(
            child: Image.asset(
              'assets/images/Home/map.png',
              fit: BoxFit.cover,
            ),
          ),

          // ------------------------------------------------
          // 2. Top Search & Filters
          // ------------------------------------------------
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Row(
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 4))
                              ]),
                          child: Icon(Icons.arrow_back,
                              color: Colors.black, size: 20.sp),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      // Search Field
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 4))
                              ]),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search here...",
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey, fontSize: 14.sp),
                              prefixIcon:
                                  Icon(Icons.search, color: AppColors.primary),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14.h),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Category Filter Chips
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 8.h),
                          decoration: BoxDecoration(
                              color:
                                  isSelected ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2))
                              ]),
                          child: Text(
                            _categories[index],
                            style: GoogleFonts.poppins(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ------------------------------------------------
          // 3. Bottom Floating Location Cards
          // ------------------------------------------------
          Positioned(
            bottom: 110.h,
            left: 0,
            right: 0,
            height: 140.h, // Height of the card container
            child: NotificationListener<ScrollNotification>(
              onNotification: _onScrollNotification,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _locations.length,
                itemBuilder: (context, index) {
                  return _buildLocationCard(_locations[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper: Location Card ---
  Widget _buildLocationCard(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CustomNetworkImage(
              imageUrl: item["image"],
              height: 120.h,
              width: 110.w,
            ),
          ),
          SizedBox(width: 15.w),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item["name"],
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryTitleTextClr,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      "${item["rating"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.star, color: Colors.amber, size: 14.sp),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        "• ${item["type"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                // Action Buttons
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.directions,
                          color: AppColors.primary, size: 18.sp),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        height: 35.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "View Details",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
