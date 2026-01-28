import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Custom Components ---
// তোমার প্রজেক্টের পাথ অনুযায়ী ইমপোর্টগুলো ঠিক রেখো
import '../../components/custom_image/custom_image.dart';
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_nav_bar/navbar.dart';
import '../../components/custom_netwrok_image/custom_network_image.dart';

// --- Screens ---
import 'EventDetailsScreen.dart';
import 'NotificationScreen.dart';
import 'SearchScreen.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Mock Data ---

    final List<Map<String, dynamic>> categories = [
      {"icon": Icons.music_note, "name": "Music Festivals"},
      {"icon": Icons.restaurant, "name": "Seafood"},
      {"icon": Icons.beach_access, "name": "Beach Party"},
    ];

    final List<Map<String, String>> upcomingEvents = [
      {
        "title": "Konoko Falls Tour",
        "rating": "4.8",
        "type": "Nature & Adventure",
        "location": "Ocho Rios, 0.3 mi",
        "image": "https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Authentic Jerk Centre",
        "rating": "4.9",
        "type": "Jamaican Cuisine",
        "location": "Montego Bay, 1.2 mi",
        "image": "https://images.unsplash.com/photo-1599305445671-ac291c95aaa9?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Kingston Night Market",
        "rating": "4.6",
        "type": "Arts & Culture",
        "location": "Kingston • 1.5 km",
        "image": "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=600&auto=format&fit=crop"
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
          style: GoogleFonts.inter(
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
              imageSrc: "assets/images/Home/eventsbg.png",
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
                  // --- Body Content ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Categories Header ---
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            CustomText(
                              text: "Events",
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 5.h),
                            CustomText(
                              text: "Where the island comes alive",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.9),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),

                      // --- Categories List (Updated to match Image) ---
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: categories.map((cat) {
                            bool isSelected = cat["name"] == "Music Festivals";

                            // Define your gradient colors here
                            Color color1 = const Color.fromRGBO(46, 111, 101, 1);
                            Color color2 = const Color.fromRGBO(88, 151, 107, 1);

                            // Keep a solid color fallback for the inactive icons/text if needed
                            Color themeSolid = color1;

                            return Container(
                              margin: EdgeInsets.only(right: 12.w),
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                // RULE: If gradient is provided, color must be null
                                color: isSelected ? null : Colors.white,
                                gradient: isSelected
                                    ? LinearGradient(
                                  colors: [color1, color2],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                )
                                    : null,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Row(
                                children: [
                                  // Icon Container (Circle)
                                  Container(
                                    padding: EdgeInsets.all(8.r),
                                    decoration: BoxDecoration(
                                      // Inverted logic: White circle if selected, Solid Green circle if not
                                      color: isSelected ? Colors.white : themeSolid,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      cat["icon"],
                                      // Inverted logic: Gradient Color (or solid) if selected, White if not
                                      color: isSelected ? themeSolid : Colors.white,
                                      size: 18.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  // Text
                                  Text(
                                    cat["name"],
                                    style: GoogleFonts.poppins(
                                      color: isSelected ? Colors.white : const Color(0xFF323B4B),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 25.h),

                      // --- Search Bar ---
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: GestureDetector(
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
                        ),


                      SizedBox(height: 25.h),

                      // --- Featured Events Header ---
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomText(
                          text: "Featured Events",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // --- Filters (Updated Gradient & Shadow) ---
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            _buildFilterChip("All", true),
                            _buildFilterChip("Today", false),
                            _buildFilterChip("This Weekend", false),
                            _buildFilterChip("Free", false),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // --- Big Featured Card ---
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const Eventdetailsscreen(), transition: Transition.rightToLeft);
                              },
                              child: Container(
                                height: 180.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  image: const DecorationImage(
                                    image: NetworkImage("https://images.unsplash.com/photo-1493225255756-d9584f8606e9?q=80&w=800"),
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
                                          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 15.h, left: 15.w,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.r),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.local_fire_department, color: Colors.orange, size: 14.sp),
                                            SizedBox(width: 4.w),
                                            Text("Popular", style: GoogleFonts.poppins(fontSize: 10.sp, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 15.h, left: 15.w, right: 15.w,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Reggae Sumfest 2026",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                ),
                                              ),
                                              Text(
                                                "July 19-23 2026",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12.sp,
                                                    color: Colors.white70
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFC107),
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            child: Text(
                                              "Book Now",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 10.h),

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
                          ],
                        ),
                      ),

                      // --- Upcoming Events Header ---
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomText(
                          text: "Upcoming Events",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // --- Upcoming Events List ---
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: upcomingEvents.length,
                          itemBuilder: (context, index) {
                            return _buildEventCard(upcomingEvents[index]);
                          },
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

  // --- Helper Widgets ---

  // 🟢 Updated Filter Chip with Gradient, Opacity & Solid Shadow
  Widget _buildFilterChip(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 12.w, bottom: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),

          // Gradient for Selected
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

          // Color for Unselected (Opacity)
          color: isSelected
              ? null
              : Colors.white,

          // Solid Shadow logic
          boxShadow: isSelected
              ? [
            const BoxShadow(
              color: Color.fromRGBO(224, 247, 184, 1),
              offset: Offset(0, 4),
              blurRadius: 0,
            ),
          ]
              : [],
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Eventdetailsscreen(), transition: Transition.rightToLeft);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)),
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
                          style: GoogleFonts.poppins(fontSize: 15.sp, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.favorite, color: Colors.red, size: 20),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Row(children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber, size: 12.sp))),
                      SizedBox(width: 5.w),
                      Text(item["rating"]!, style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8.w),
                      Text(item["type"]!, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 11.sp)),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: const Color(0xFF357984), size: 14.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          item["location"]!,
                          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12.sp),
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