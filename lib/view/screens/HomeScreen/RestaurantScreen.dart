import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Ensure this import points to your updated details screen
import 'RestaurantDetailsScreen.dart';

// Custom Components
import '../../components/custom_image/custom_image.dart';
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_nav_bar/navbar.dart';
import '../../components/custom_netwrok_image/custom_network_image.dart';

// Screens
import 'NotificationScreen.dart';
import 'SearchScreen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Mock Data ---

    // Categories (Cuisines)
    final List<Map<String, dynamic>> categories = [
      {"icon": Icons.restaurant, "name": "Fine Dining"},
      {"icon": Icons.fastfood, "name": "Fast Food"},
      {"icon": Icons.local_cafe, "name": "Cafes"},
      {"icon": Icons.set_meal, "name": "Seafood"},
    ];

    // Featured Restaurants
    final List<Map<String, String>> featuredRestaurants = [
      {
        "title": "Blue Lagoon",
        "rating": "4.8",
        "reviews": "1.2k",
        "image": "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=800",
        "tag": "Top Rated",
        "location": "Port Antonio"
      },
      {
        "title": "Ocean's 11 Spot",
        "rating": "4.6",
        "reviews": "850",
        "image": "https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=800",
        "tag": "Trending",
        "location": "Ocho Rios"
      },
      {
        "title": "Spice Garden",
        "rating": "4.7",
        "reviews": "500",
        "image": "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=800",
        "tag": "New",
        "location": "Kingston"
      },
    ];

    // Popular Restaurants
    final List<Map<String, String>> restaurants = [
      {
        "title": "The Jerk Pit",
        "rating": "4.9",
        "type": "Caribbean • Spicy",
        "location": "Montego Bay, 0.5 mi",
        "image": "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Pasta Paradise",
        "rating": "4.7",
        "type": "Italian • Pasta",
        "location": "Kingston, 2.1 mi",
        "image": "https://images.unsplash.com/photo-1551183053-bf91b1d545ce?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Ocean View Grill",
        "rating": "4.5",
        "type": "Seafood • Grill",
        "location": "Ocho Rios, 1.0 mi",
        "image": "https://images.unsplash.com/photo-1533777857889-4be7c70b33f7?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Island Spice Grill",
        "rating": "4.6",
        "type": "BBQ • Grill",
        "location": "Negril, 1.5 mi",
        "image": "https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Reggae Pot Lounge",
        "rating": "4.8",
        "type": "Jamaican • Lounge",
        "location": "Kingston, 3.2 mi",
        "image": "https://images.unsplash.com/photo-1544025162-d76690b67f11?q=80&w=600&auto=format&fit=crop"
      },
    ];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const NavBar(currentIndex: 0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: CustomText(
          text: "Caribee",
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const NotificationScreen()),
            child: Container(
              margin: EdgeInsets.only(right: 20.w),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications, color: Colors.white, size: 28),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      height: 16.h,
                      width: 16.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text("3",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: CustomImage(
              imageSrc: "assets/images/Home/resturantbg.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              imageType: ImageType.png,
            ),
          ),

          // Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          // Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 110.h, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Title & Search ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        CustomText(
                          text: "Restaurants",
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 5.h),
                        CustomText(
                          text: "Where great food meets atmosphere, culture, and good company",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.9),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                        SizedBox(height: 20.h),

                        // Search Bar
                        GestureDetector(
                          onTap: () => Get.to(() => SearchScreen(),
                              transition: Transition.fadeIn),
                          child: Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.search),
                                      suffixIcon: const Icon(Icons.cancel),
                                      hintText: "Search for Restaurants",
                                      hintStyle: GoogleFonts.poppins(
                                          color: Colors.grey[400], fontSize: 15.sp),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.h),

                  // --- Categories (Updated with Gradient) ---
                  CustomText(
                    text: "Category",
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    left: 20,
                  ),
                  SizedBox(height: 8.h),

                  // 🟢 FILTER CHIP SECTION
                  // 🟢 FILTER CHIP SECTION
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: categories.map((cat) {
                        bool isSelected = cat["name"] == "Fine Dining"; // Selection Logic

                        return Container(
                          margin: EdgeInsets.only(right: 12.w, bottom: 5.h),
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r), // Pill shape

                            // 1. Updated Orange Gradient
                            gradient: isSelected
                                ? const LinearGradient(
                              colors: [
                                Color(0xFFFF6B35), // Deep Orange (Left side)
                                Color(0xFFFDB05E), // Light Orange/Amber (Right side)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                                : null,

                            // 2. White Background for Unselected
                            color: isSelected ? null : Colors.white,

                            // 3. Updated Shadow (Orange glow instead of Green)
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color: const Color(0xFFFF6B35).withOpacity(0.4),
                                offset: const Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ]
                                : [],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                cat["icon"],
                                // Changed unselected icon color to orange/grey to fit theme better,
                                // or keep your original teal (0xFF357984) if you prefer.
                                color: isSelected ? Colors.white : const Color(0xFF357984),
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                cat["name"],
                                style: GoogleFonts.poppins(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 25.h),

                  // --- Featured Spots ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomText(
                      text: "Featured Restaurants",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15.h),

                  // --- Featured List ---
                  SizedBox(
                    height: 240.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: featuredRestaurants.length,
                      separatorBuilder: (context, index) => SizedBox(width: 15.w),
                      itemBuilder: (context, index) {
                        return _buildHomeScreenStyleCard(featuredRestaurants[index]);
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // --- Map & Popular List ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(color: Colors.amber, width: 2),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  "Show Map View",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 25.h),

                        CustomText(
                          text: "Nearby Resturant",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        SizedBox(height: 15.h),

                        // Vertical List
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            return _buildRestaurantCard(restaurants[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Horizontal Card ---
  Widget _buildHomeScreenStyleCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const RestaurantDetailsPage(), transition: Transition.rightToLeft);
      },
      child: Container(
        width: 250.w,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            image: NetworkImage(item["image"]!),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                    child: CustomNetworkImage(
                      imageUrl: item["image"]!,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Row(
                        children: [
                          Icon(Icons.local_fire_department,
                              color: Colors.orange, size: 12.sp),
                          SizedBox(width: 4.w),
                          Text(item["tag"]!,
                              style: GoogleFonts.poppins(
                                  fontSize: 10.sp, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Bottom Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item["title"]!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 14.sp)),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.star_outlined, color: Colors.amber, size: 18.sp),
                        SizedBox(width: 4.w),
                        Text(item["rating"]!,
                            style: GoogleFonts.poppins(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                        Container(
                          height: 12.h,
                          width: 1.w,
                          color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                        ),
                        Icon(Icons.location_on, color: Colors.red, size: 14.sp),
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
  }

  // --- Vertical Card ---
  Widget _buildRestaurantCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const RestaurantDetailsPage(), transition: Transition.rightToLeft);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r), bottomLeft: Radius.circular(12.r)),
              child: CustomNetworkImage(
                imageUrl: item["image"]!,
                height: 100.h,
                width: 100.w,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item["title"]!,
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.favorite_border, color: Colors.grey, size: 20),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(item["rating"]!,
                          style: GoogleFonts.poppins(
                              fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          "• ${item["type"]}",
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontSize: 11.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: const Color(0xFF357984), size: 14.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          item["location"]!,
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontSize: 12.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}