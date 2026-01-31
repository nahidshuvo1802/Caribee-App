import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Internal Imports
import '../../../utils/app_colors/app_colors.dart';
import '../../components/custom_nav_bar/navbar.dart';
import '../../components/custom_netwrok_image/custom_network_image.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  // 🟢 Scroll-aware NavBar Variables
  bool _isNavBarVisible = true;
  late AnimationController _navBarAnimController;
  late Animation<Offset> _navBarSlideAnimation;
  DateTime _lastScrollTime = DateTime.now();

  // 0: Restaurants, 1: Experiences, 2: Events, 3: Visited
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();

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

  // --- Mock Data: Restaurants ---
  final List<Map<String, dynamic>> _restaurantList = [
    {
      "title": "Bistro Moderne",
      "rating": 4.8,
      "category": "French Cuisine",
      "distance": "Downtown, 0.3 mi",
      "image":
          "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "The Jerk Pit",
      "rating": 4.7,
      "category": "Jamaican",
      "distance": "Kingston, 1.2 mi",
      "image":
          "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Ocean View Grill",
      "rating": 4.5,
      "category": "Seafood",
      "distance": "Montego Bay, 0.8 mi",
      "image":
          "https://images.unsplash.com/photo-1508615263227-c5d58c1e5821?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "isFavorite": true,
    },
    {
      "title": "Spice Garden",
      "rating": 4.6,
      "category": "Asian Fusion",
      "distance": "Ocho Rios, 2.5 mi",
      "image":
          "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
  ];

  // --- Mock Data: Experiences ---
  final List<Map<String, dynamic>> _experienceList = [
    {
      "title": "Sunset Catamaran",
      "rating": 4.9,
      "category": "Water Sports",
      "distance": "Negril, 1.0 mi",
      "image":
          "https://plus.unsplash.com/premium_photo-1673002094195-f18084be89ce?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "isFavorite": true,
    },
    {
      "title": "Blue Mountain Hike",
      "rating": 4.8,
      "category": "Adventure",
      "distance": "Portland, 15 mi",
      "image":
          "https://images.unsplash.com/photo-1551632811-561732d1e306?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Dolphin Cove Swim",
      "rating": 4.7,
      "category": "Nature",
      "distance": "Ocho Rios, 3.0 mi",
      "image":
          "https://images.unsplash.com/photo-1703756291794-b4ae96571707?q=80&w=736&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "isFavorite": true,
    },
    {
      "title": "Dunn's River Falls",
      "rating": 4.9,
      "category": "Tour",
      "distance": "Ocho Rios, 4.5 mi",
      "image":
          "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
  ];

  // --- Mock Data: Events ---
  final List<Map<String, dynamic>> _eventList = [
    {
      "title": "Reggae Sumfest",
      "rating": 5.0,
      "category": "Music Festival",
      "distance": "Catherine Hall, 0.5 mi",
      "image":
          "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Carnival Jamaica",
      "rating": 4.9,
      "category": "Cultural",
      "distance": "Kingston, 2.0 mi",
      "image":
          "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Food & Rum Festival",
      "rating": 4.8,
      "category": "Gastronomy",
      "distance": "Falmouth, 10 mi",
      "image":
          "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
  ];

  // --- Mock Data: Visited ---
  final List<Map<String, dynamic>> _visitedList = [
    {
      "title": "Rick's Cafe",
      "rating": 4.7,
      "category": "Bar & Grill",
      "distance": "Negril, 0.2 mi",
      "image":
          "https://plus.unsplash.com/premium_photo-1663932464937-e677ddfc1d55?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "isFavorite": true,
    },
    {
      "title": "Bob Marley Museum",
      "rating": 4.8,
      "category": "Museum",
      "distance": "Kingston, 3.5 mi",
      "image":
          "https://images.unsplash.com/photo-1491156855053-9cdff72c7f85?q=80&w=928&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "isFavorite": true,
    },
    {
      "title": "Doctor's Cave Beach",
      "rating": 4.6,
      "category": "Beach",
      "distance": "Montego Bay, 1.0 mi",
      "image":
          "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
  ];

  // Helper to get the correct list based on selected tab
  List<Map<String, dynamic>> _getCurrentList() {
    if (_selectedTabIndex == 0) return _restaurantList;
    if (_selectedTabIndex == 1) return _experienceList;
    if (_selectedTabIndex == 2) return _eventList;
    return _visitedList; // Index 3
  }

  @override
  Widget build(BuildContext context) {
    final currentList = _getCurrentList();

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: SlideTransition(
        position: _navBarSlideAnimation,
        child: const NavBar(currentIndex: 2),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),

              // --- Header ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      color: Colors.transparent,
                      child: Icon(Icons.arrow_back_ios,
                          size: 20.sp, color: Colors.black),
                    ),
                  ),
                  Text(
                    "Favorites",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.subtitleTextClr,
                    ),
                  ),
                  SizedBox(width: 40.w),
                ],
              ),

              SizedBox(height: 25.h),

              // --- Toggle Tabs (With Gradient) ---
              Container(
                height: 45.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTabButton("Restaurants", 0),
                      SizedBox(width: 10.w),
                      _buildTabButton("Experiences", 1),
                      SizedBox(width: 10.w),
                      _buildTabButton("Events", 2),
                      SizedBox(width: 10.w),
                      _buildTabButton("Visited", 3),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // --- List View ---
              Expanded(
                child: currentList.isEmpty
                    ? Center(
                        child: Text(
                          "No favorites yet!",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      )
                    : NotificationListener<ScrollNotification>(
                        onNotification: _onScrollNotification,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 100.h),
                          itemCount: currentList.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 15.h),
                          itemBuilder: (context, index) {
                            final item = currentList[index];
                            return _buildFavoriteCard(item);
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widget: Tab Button (EXACT SAME AS HOMESCREEN) ---
  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),

          // 🟢 1. Gradient for Selected State (Same as HomeScreen)
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    Color.fromRGBO(46, 111, 101, 1), // Start Color
                    Color.fromRGBO(88, 151, 107, 1), // End Color
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,

          // 🟢 2. Solid Color for Unselected State
          color: isSelected ? null : const Color.fromRGBO(245, 208, 118, 0.64),

          // 🟢 3. Solid Shadow (Same as HomeScreen)
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color:
                        Color.fromRGBO(224, 247, 184, 1), // Solid green shadow
                    offset: Offset(0, 4),
                    blurRadius: 0, // Solid shadow (no blur)
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  // --- Helper Widget: Favorite Card ---
  Widget _buildFavoriteCard(Map<String, dynamic> item) {
    return Container(
      height: 110.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              bottomLeft: Radius.circular(16.r),
            ),
            child: CustomNetworkImage(
              imageUrl: item["image"],
              height: 110.h,
              width: 110.w,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item["title"],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryTitleTextClr,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.favorite,
                        color: AppColors.red,
                        size: 20.sp,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                            5,
                            (index) => Icon(Icons.star,
                                color: Colors.amber, size: 14.sp)),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "${item["rating"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          item["category"],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: AppColors.titleTextClr,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: AppColors.primary, size: 14.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          item["distance"],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: AppColors.titleTextClr,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
