import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Custom Components ---
import '../../components/custom_image/custom_image.dart';
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_nav_bar/navbar.dart';
import '../../components/custom_netwrok_image/custom_network_image.dart';

// --- Screens ---
import 'ExperienceDetailsScreen.dart';
import 'NotificationScreen.dart';
import 'SearchScreen.dart';

class ExperiencesScreen extends StatelessWidget {
  const ExperiencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Mock Data ---

    // Categories (Chips)
    final List<String> filters = ["Nature", "Adventure", "Tours", "Water"];

    // Featured Experiences (Horizontal 3D List)
    final List<Map<String, String>> featuredExcursions = [
      {
        "title": "Dunn's River Falls",
        "rating": "4.9",
        "location": "Ocho Rios",
        "image": "https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?q=80&w=600&auto=format&fit=crop",
        "tag": "Must Visit"
      },
      {
        "title": "Blue Hole Secret",
        "rating": "4.8",
        "location": "Ocho Rios",
        "image": "https://images.unsplash.com/photo-1544550581-5f7ceaf7f992?q=80&w=600&auto=format&fit=crop",
        "tag": "Trending"
      },
      {
        "title": "Rick's Cafe Cliff",
        "rating": "4.7",
        "location": "Negril",
        "image": "https://images.unsplash.com/photo-1596895111956-bf1cf0599ce5?q=80&w=600&auto=format&fit=crop",
        "tag": "Popular"
      },
    ];

    // Popular Experiences (Vertical List)
    final List<Map<String, String>> verticalList = [
      {
        "title": "Martha Brae Rafting",
        "rating": "4.7",
        "type": "Relaxation",
        "location": "Falmouth, 10 mi",
        "image": "https://images.unsplash.com/photo-1596895111956-bf1cf0599ce5?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Mystic Mountain Bobsled",
        "rating": "4.8",
        "type": "Adventure",
        "location": "Ocho Rios, 1.2 mi",
        "image": "https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "YS Falls Park",
        "rating": "4.8",
        "type": "Nature • Swim",
        "location": "St. Elizabeth, 15 mi",
        "image": "https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Green Grotto Caves",
        "rating": "4.6",
        "type": "History • Tour",
        "location": "Discovery Bay, 5 mi",
        "image": "https://images.unsplash.com/photo-1519408299519-b7a0274ec315?q=80&w=600&auto=format&fit=crop"
      },
    ];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Caribee",
          style: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const NotificationScreen()),
            child: Container(
              margin: EdgeInsets.only(right: 20.w),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications, color: Colors.white, size: 28),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      height: 14.h,
                      width: 14.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text("2", style: TextStyle(color: Colors.white, fontSize: 8.sp)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const NavBar(currentIndex: 0),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: CustomImage(
              imageSrc: "assets/images/Home/experiencebg.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              imageType: ImageType.png,
            ),
          ),

          // Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // Main Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 110.h, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header & Search ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        CustomText(
                          text: "Experiences",
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 5.h),
                        CustomText(
                          text: "Handpicked experiences. Designed to be felt, not visited.",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.9),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                        SizedBox(height: 20.h),

                        // Search Bar
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SearchScreen(), transition: Transition.fadeIn);
                          },
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
                                // Icon(Icons.search, color: Colors.grey, size: 24.sp),
                                // SizedBox(width: 10.w),
                                Expanded(
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      suffixIcon: Icon(Icons.cancel),

                                      hintText: "Search for Experience",
                                      // hint
                                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 15.sp),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),

                                // Text("Cancel")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25.h),

                  // --- Featured Header ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomText(
                      text: "Featured Experiences",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 15.h),

                  // --- Featured List (Horizontal 3D Cards) ---
                  SizedBox(
                    height: 240.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: featuredExcursions.length,
                      separatorBuilder: (context, index) => SizedBox(width: 15.w),
                      itemBuilder: (context, index) {
                        return _buildHomeScreenStyleCard(featuredExcursions[index]);
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // --- Filter Chips (Updated Gradient & Shadow) ---
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: filters.map((filter) {
                        bool isSelected = filter == "Nature"; // Logic for selected state

                        return GestureDetector(
                          onTap: () {
                            // Add tap logic here
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12.w, bottom: 5.h), // Margin for shadow
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r), // Pill Shape

                              // 🟢 Gradient for Selected State
                              gradient: isSelected
                                  ? const LinearGradient(
                                colors: [
                                  Color.fromRGBO(46, 111, 101, 1),
                                  Color.fromRGBO(88, 151, 107, 1),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                                  : null,

                              // 🟢 Color for Unselected State
                              color: isSelected
                                  ? null
                                  : Colors.white,

                              // 🟢 Solid Shadow (Hard Shadow)
                              boxShadow: isSelected
                                  ? [
                                const BoxShadow(
                                  color: Color.fromRGBO(224, 247, 184, 1),
                                  offset: Offset(0, 4),
                                  blurRadius: 0, // Solid shadow
                                ),
                              ]
                                  : [],
                            ),
                            child: Text(
                              filter,
                              style: GoogleFonts.poppins(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 15.h),

                  // --- Map & Vertical List ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        // Map Button
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
                              Text(
                                "Show Map View",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // --- Vertical List Items (Optimized Generation) ---
                        Column(
                          children: [
                            ...verticalList.map((item) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.h), // Gap between cards
                                child: _buildVerticalCard(item),
                              );
                            }).toList(),
                          ],
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

  // --- Helper Widgets ---

  // 3D Horizontal Card
  Widget _buildHomeScreenStyleCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Experiencedetailsscreen(), transition: Transition.rightToLeft);
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
                    top: 8.h, left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
                      child: Row(
                        children: [
                          Icon(Icons.local_fire_department, color: Colors.orange, size: 12.sp),
                          SizedBox(width: 4.w),
                          Text(item["tag"]!, style: GoogleFonts.poppins(fontSize: 10.sp, fontWeight: FontWeight.bold)),
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
                    Text(
                        item["title"]!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14.sp)
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.star_outlined, color: Colors.amber, size: 18.sp),
                        SizedBox(width: 4.w),
                        Text(item["rating"]!, style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.bold)),
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
                            style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey[700]),
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

  // --- Optimized Vertical Card ---
  Widget _buildVerticalCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Experiencedetailsscreen(), transition: Transition.rightToLeft);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
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
            // Left Side Image
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)),
              child: CustomNetworkImage(
                imageUrl: item["image"]!,
                height: 100.h,
                width: 100.w,
                // fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 15.w),

            // Right Side Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Heart Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item["title"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.favorite_border, color: Colors.grey, size: 20.sp),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Rating and Type
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(
                          item["rating"]!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            color: Colors.black,
                          )
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 4.w, height: 4.h,
                        decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                          item["type"]!,
                          style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12.sp)
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on, color: const Color(0xFF357984), size: 14.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          item["location"]!,
                          style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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