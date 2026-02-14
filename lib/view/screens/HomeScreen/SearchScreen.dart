import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String searchQuery = '';
  int selectedLocationIndex = 0;

  // Recent searches data
  final List<String> recentSearches = [
    "Dunn's River Falls, Ocho Rios",
    "Negril Seven Mile Beach, Negril",
    "Bob Marley Museum, Kingston",
  ];

  // Categories data with icons
  final List<Map<String, dynamic>> categories = [
    {
      "icon": Icons.restaurant,
      "label": "Food & Dining",
      "color": Color(0xFFFF9800)
    },
    {
      "icon": Icons.beach_access,
      "label": "Beach & Nature",
      "color": Color(0xFF2196F3)
    },
    {
      "icon": Icons.celebration,
      "label": "Nightlife & Entertainment",
      "color": Color(0xFFE91E63)
    },
    {
      "icon": Icons.account_balance,
      "label": "Culture & Heritage",
      "color": Color(0xFFE53935)
    },
    {
      "icon": Icons.hiking,
      "label": "Adventures & Tours",
      "color": Color(0xFF4CAF50)
    },
    {
      "icon": Icons.spa,
      "label": "Wellness & Relaxation",
      "color": Color(0xFFFF5722)
    },
  ];

  // Location filter options
  final List<String> locationOptions = [
    "My Location",
    "Kingston",
    "Montego Bay",
  ];

  void _clearSearch() {
    setState(() {
      _controller.clear();
      searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Search',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),

                    // --- Search Bar ---
                    Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.search,
                            color: Colors.grey[500],
                            size: 22.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search destinations',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: Colors.grey[400],
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: _clearSearch,
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF2E5C38),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // --- Recent Searches Section ---
                    Text(
                      'Recent Searches',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Recent Searches Card
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: recentSearches.map((search) {
                          return _buildRecentSearchItem(search);
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // --- Popular Categories Section ---
                    Text(
                      'Popular Categories',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Categories Card
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: categories.map((category) {
                          return _buildCategoryItem(
                            icon: category["icon"],
                            label: category["label"],
                            color: category["color"],
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),

          // --- Bottom Location Filter ---
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(locationOptions.length, (index) {
                    final isSelected = selectedLocationIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLocationIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.grey[100] : Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: isSelected
                                ? Colors.grey[300]!
                                : Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (index == 0)
                              Icon(
                                Icons.location_on,
                                size: 14.sp,
                                color: const Color(0xFFE53935),
                              ),
                            if (index == 0) SizedBox(width: 4.w),
                            Text(
                              locationOptions[index],
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Recent Search Item Widget ---
  Widget _buildRecentSearchItem(String text) {
    return InkWell(
      onTap: () {
        _controller.text = text;
        setState(() {
          searchQuery = text;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 20.sp,
              color: Colors.grey[400],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Category Item Widget ---
  Widget _buildCategoryItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        // Navigate to category
        print("Selected category: $label");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: color,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
