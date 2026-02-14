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
import 'SearchScreen.dart';

class ExperiencesScreen extends StatefulWidget {
  const ExperiencesScreen({super.key});

  @override
  State<ExperiencesScreen> createState() => _ExperiencesScreenState();
}

class _ExperiencesScreenState extends State<ExperiencesScreen>
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
        "image":
            "https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?q=80&w=600&auto=format&fit=crop",
        "tag": "Popular",
        "category": "Water"
      },
      {
        "title": "Blue Hole Secret",
        "rating": "4.8",
        "location": "Ocho Rios",
        "image":
            "https://images.unsplash.com/photo-1544550581-5f7ceaf7f992?q=80&w=600&auto=format&fit=crop",
        "tag": "Trending",
        "category": "Water"
      },
      {
        "title": "Rick's Cafe Cliff",
        "rating": "4.7",
        "location": "Negril",
        "image":
            "https://images.unsplash.com/photo-1596895111956-bf1cf0599ce5?q=80&w=600&auto=format&fit=crop",
        "tag": "Popular",
        "category": "Adventure"
      },
    ];

    // Popular Experiences (Vertical List)
    final List<Map<String, String>> verticalList = [
      {
        "title": "Martha Brae Rafting",
        "rating": "4.7",
        "type": "Relaxation",
        "location": "Falmouth, 10 mi",
        "image":
            "https://images.unsplash.com/photo-1596895111956-bf1cf0599ce5?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Mystic Mountain Bobsled",
        "rating": "4.8",
        "type": "Adventure",
        "location": "Ocho Rios, 1.2 mi",
        "image":
            "https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "YS Falls Park",
        "rating": "4.8",
        "type": "Nature • Swim",
        "location": "St. Elizabeth, 15 mi",
        "image":
            "https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?q=80&w=600&auto=format&fit=crop"
      },
      {
        "title": "Green Grotto Caves",
        "rating": "4.6",
        "type": "History • Tour",
        "location": "Discovery Bay, 5 mi",
        "image":
            "https://images.unsplash.com/photo-1646852205388-84ed2c3f2448?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
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
      ),
      bottomNavigationBar: SlideTransition(
        position: _navBarSlideAnimation,
        child: const NavBar(currentIndex: 0),
      ),
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
              color: Colors.black.withValues(alpha: 0.4),
            ),
          ),

          // Main Content
          SafeArea(
            bottom: false,
            child: NotificationListener<ScrollNotification>(
              onNotification: _onScrollNotification,
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
                            text:
                                "Handpicked experiences. Designed to be felt, not visited.",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.9),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                          ),
                          SizedBox(height: 20.h),

                          // Search Bar (Modern Design)
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SearchScreen(),
                                  transition: Transition.fadeIn);
                            },
                            child: Container(
                              height: 52.h,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search_rounded,
                                    color: Colors.grey[500],
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      "Search for Experiences...",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[400],
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.tune_rounded,
                                    color: const Color(0xFF2E5C38),
                                    size: 22.sp,
                                  ),
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
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 15.w),
                        itemBuilder: (context, index) {
                          return _buildHomeScreenStyleCard(
                              featuredExcursions[index]);
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
                          bool isSelected =
                              filter == "Nature"; // Logic for selected

                          // Define gradients based on filter type
                          List<Color> gradientColors;
                          Color shadowColor;

                          if (filter == "Nature") {
                            gradientColors = [
                              const Color(0xFF2E7D32), // Green 800
                              const Color(0xFF4CAF50), // Green 500
                            ];
                            shadowColor =
                                const Color(0xFF2E7D32).withValues(alpha: 0.4);
                          } else if (filter == "Adventure") {
                            gradientColors = [
                              const Color(0xFFE65100), // Orange 900
                              const Color(0xFFFF9800), // Orange 500
                            ];
                            shadowColor =
                                const Color(0xFFE65100).withValues(alpha: 0.4);
                          } else if (filter == "Water") {
                            gradientColors = [
                              const Color(0xFF1565C0), // Blue 800
                              const Color(0xFF2196F3), // Blue 500
                            ];
                            shadowColor =
                                const Color(0xFF1565C0).withValues(alpha: 0.4);
                          } else {
                            // Default (Tours, etc.) - Teal as before
                            gradientColors = [
                              const Color.fromRGBO(46, 111, 101, 1),
                              const Color.fromRGBO(88, 151, 107, 1),
                            ];
                            shadowColor =
                                const Color.fromRGBO(224, 247, 184, 1);
                          }

                          return GestureDetector(
                            onTap: () {
                              // Add tap logic here
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 12.w,
                                  bottom: 5.h), // Margin for shadow
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(30.r), // Pill Shape

                                // 🟢 Gradient for Selected State or Specific Chips as requested?
                                // User said "add a blue chip for ocean...".
                                // Assuming this means ALWAYS colored for identification, or just when selected?
                                // Standard pattern is color when selected.
                                // However, user might want them to ALWAYS be colored to distinguish categories.
                                // "in the experiences add a blue chip for ocean... green for nature..."
                                // Let's make them colored if selected, but maybe hint the color if not?
                                // For now, let's stick to the 'isSelected' render logic to avoid breaking the UI pattern,
                                // BUT update the gradient to be category-specific.

                                gradient: isSelected
                                    ? LinearGradient(
                                        colors: gradientColors,
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      )
                                    : null,

                                // 🟢 Color for Unselected State
                                color: isSelected ? null : Colors.white,

                                // 🟢 Solid Shadow (Hard Shadow)
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: shadowColor,
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Text(
                                filter,
                                style: GoogleFonts.poppins(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
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
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 15.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(color: Colors.amber, width: 2),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.red),
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
                                  padding: EdgeInsets.only(
                                      bottom: 15.h), // Gap between cards
                                  child: _buildVerticalCard(item),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

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

  // 3D Horizontal Card
  Widget _buildHomeScreenStyleCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Experiencedetailsscreen(),
            transition: Transition.fadeIn);
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.r)),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Row(
                        children: [
                          item["tag"] == "Trusted"
                              ? Image.asset("assets/images/icon/trusted.png",
                                  height: 12.sp,
                                  width: 12.sp,
                                  fit: BoxFit.contain)
                              : item["tag"] == "Top Rated"
                                  ? Image.asset(
                                      "assets/images/icon/favorite.png",
                                      height: 12.sp,
                                      width: 12.sp,
                                      fit: BoxFit.contain)
                                  : item["tag"] == "Weekly Pick"
                                      ? Image.asset(
                                          "assets/images/icon/7-days.png",
                                          height: 12.sp,
                                          width: 12.sp,
                                          fit: BoxFit.contain)
                                      : item["tag"] == "Trending"
                                          ? Image.asset(
                                              "assets/images/icon/trend.png",
                                              height: 12.sp,
                                              width: 12.sp,
                                              fit: BoxFit.contain)
                                          : item["tag"] == "Popular"
                                              ? Image.asset(
                                                  "assets/images/icon/flame.png",
                                                  height: 12.sp,
                                                  width: 12.sp,
                                                  fit: BoxFit.contain)
                                              : item["tag"] == "New"
                                                  ? Icon(Icons.new_releases,
                                                      color: Colors.orange,
                                                      size: 12.sp)
                                                  : Icon(
                                                      Icons
                                                          .local_fire_department,
                                                      color: Colors.orange,
                                                      size: 12.sp),
                          SizedBox(width: 4.w),
                          Text(item["tag"]!,
                              style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  // New Category Chip
                  if (item.containsKey("category"))
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: item["category"] == "Nature"
                              ? const Color(0xFF2E7D32) // Green
                              : item["category"] == "Water"
                                  ? const Color(0xFF1565C0) // Blue
                                  : const Color(
                                      0xFFE65100), // Orange (Adventure)
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          item["category"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                        _buildStarRating(
                            double.tryParse(item["rating"]!) ?? 0.0,
                            size: 14.sp),
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

  // --- Optimized Vertical Card ---
  Widget _buildVerticalCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Experiencedetailsscreen(),
            transition: Transition.fadeIn);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Side Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r)),
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
                      Icon(Icons.favorite_border,
                          color: Colors.grey, size: 20.sp),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Rating and Type
                  Row(
                    children: [
                      _buildStarRating(double.tryParse(item["rating"]!) ?? 0.0,
                          size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(item["rating"]!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            color: Colors.black,
                          )),
                      SizedBox(width: 8.w),
                      Container(
                        width: 4.w,
                        height: 4.h,
                        decoration: const BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 8.w),
                      Text(item["type"]!,
                          style: GoogleFonts.poppins(
                              color: Colors.grey[600], fontSize: 12.sp)),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: const Color(0xFF357984), size: 14.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          item["location"]!,
                          style: GoogleFonts.poppins(
                              color: Colors.grey[600], fontSize: 12.sp),
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
