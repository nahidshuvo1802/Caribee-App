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

class _FavouriteScreenState extends State<FavouriteScreen> {
  // 0: Restaurants, 1: Experiences, 2: Events, 3: Visited
  int _selectedTabIndex = 0;

  // --- Mock Data: Restaurants ---
  final List<Map<String, dynamic>> _restaurantList = [
    {
      "title": "Bistro Moderne",
      "rating": 4.8,
      "category": "French Cuisine",
      "distance": "Downtown, 0.3 mi",
      "image": "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "The Jerk Pit",
      "rating": 4.7,
      "category": "Jamaican",
      "distance": "Kingston, 1.2 mi",
      "image": "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Ocean View Grill",
      "rating": 4.5,
      "category": "Seafood",
      "distance": "Montego Bay, 0.8 mi",
      "image": "https://images.unsplash.com/photo-1550966871-3ed3c6221741?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Spice Garden",
      "rating": 4.6,
      "category": "Asian Fusion",
      "distance": "Ocho Rios, 2.5 mi",
      "image": "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=600&auto=format&fit=crop",
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
      "image": "https://images.unsplash.com/photo-1544551763-46a42a45745b?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Blue Mountain Hike",
      "rating": 4.8,
      "category": "Adventure",
      "distance": "Portland, 15 mi",
      "image": "https://images.unsplash.com/photo-1551632811-561732d1e306?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Dolphin Cove Swim",
      "rating": 4.7,
      "category": "Nature",
      "distance": "Ocho Rios, 3.0 mi",
      "image": "https://images.unsplash.com/photo-1570704766299-47c093a62332?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Dunn's River Falls",
      "rating": 4.9,
      "category": "Tour",
      "distance": "Ocho Rios, 4.5 mi",
      "image": "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=600&auto=format&fit=crop",
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
      "image": "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Carnival Jamaica",
      "rating": 4.9,
      "category": "Cultural",
      "distance": "Kingston, 2.0 mi",
      "image": "https://images.unsplash.com/photo-1533174072545-e8d4aa97edf9?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Food & Rum Festival",
      "rating": 4.8,
      "category": "Gastronomy",
      "distance": "Falmouth, 10 mi",
      "image": "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=600&auto=format&fit=crop",
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
      "image": "https://images.unsplash.com/photo-1596627679632-680c19b05d15?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Bob Marley Museum",
      "rating": 4.8,
      "category": "Museum",
      "distance": "Kingston, 3.5 mi",
      "image": "https://images.unsplash.com/photo-1588528271708-cb8c8713df0d?q=80&w=600&auto=format&fit=crop",
      "isFavorite": true,
    },
    {
      "title": "Doctor's Cave Beach",
      "rating": 4.6,
      "category": "Beach",
      "distance": "Montego Bay, 1.0 mi",
      "image": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=600&auto=format&fit=crop",
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
      bottomNavigationBar: const NavBar(currentIndex: 2),
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
                      child: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black),
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
                    : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 100.h),
                  itemCount: currentList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 15.h),
                  itemBuilder: (context, index) {
                    final item = currentList[index];
                    return _buildFavoriteCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widget: Tab Button (WITH GRADIENT) ---
  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          // 🟢 ADDED: Green Gradient logic
          // If selected, apply gradient. If not, gradient is null.
          gradient: isSelected
              ? const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF2E7D58), // Deep Green
              Color(0xFF43A072), // Lighter Green
            ],
          )
              : null,
          // 🟢 Important: Color must be null if gradient is used.
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected ? null : Border.all(color: AppColors.grey_02),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xFF2E7D58).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ]
              : null,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.titleText2Clr,
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
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
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
                        children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber, size: 14.sp)),
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
                      Icon(Icons.location_on, color: AppColors.primary, size: 14.sp),
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