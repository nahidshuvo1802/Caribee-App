import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Custom Components Imports ---
import '../../components/custom_text/custom_text.dart';

class Promotionpagedetails extends StatelessWidget {
  const Promotionpagedetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ------------------------------------------------
          // Sliver App Bar (Hero Image Section)
          // ------------------------------------------------
          SliverAppBar(
            expandedHeight: 420.h,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 64.w,

            // --- Back Button ---
            leading: Container(
              margin: EdgeInsets.only(left: 20.w, top: 8.h, bottom: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18.sp),
                onPressed: () => Get.back(),
              ),
            ),

            // --- Flexible Background Image ---
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // 1. Hero Image
                    Image.asset(
                      'assets/images/Home/bussiness.png',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    // 3. "LIMITED TIME" Tag
                    Positioned(
                      top: 60.h,
                      right: 20.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'LIMITED TIME',
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2F6D59),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),

                    // 4. Title & Location
                    Positioned(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sandalwood \nCove Resort', // 🟢 Added \n to force the break
                            maxLines: 2, // 🟢 Ensures it renders up to 2 line
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w500, // Added bold for better visibility
                              color: Colors.black, // Kept your requested color
                              height: 1.2, // 🟢 Adjusted height slightly so lines don't touch
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                           SizedBox(height: 10.h,),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 18.sp, color: Colors.grey),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  'Soufrière, St. Lucia — Caribbean',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.99),
                                        offset: const Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
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

          // ------------------------------------------------
          // Main Body Content
          // ------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- Quote Text ----
                  Text(
                    '"An architectural masterpiece where the emerald Pitons meet the sapphire sea."',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF2F6D59),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ---- Description ----
                  Text(
                    'Discover a sanctuary of unparalleled elegance. Nestled amidst lush, vibrant gardens, our overwater retreats provide a seamless blend of luxury and nature’s raw beauty.',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4B5563),
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // ---- Gradient Button ----
                  GestureDetector(
                    onTap: () {
                      print('Booking');
                    },
                    child: Container(
                      height: 56.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFE65100), // Orange
                            Color(0xFF8B1E1E), // Deep Red/Brown
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE65100).withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'B O O K  W I T H  B E N E F I T',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // ---- Member Exclusive Card ----
                  const _MemberExclusiveCard(
                    title: 'MEMBER EXCLUSIVE',
                    subtitle: 'The Serenity Extended\n Stay',
                    description: 'Enjoy a complimentary 4th night on us.',
                    code: 'CARIBEE24',
                    validDate: 'Valid through Dec 2024. Exclusive to Platinum Members.',
                  ),
                  SizedBox(height: 24.h),

                  // ---- Refinements Section ----
                  const _RefinementsSection(),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------
//                 INTERNAL WIDGETS
// -----------------------------------------------------------
class _MemberExclusiveCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String code;
  final String validDate;

  const _MemberExclusiveCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.code,
    required this.validDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // MEMBER EXCLUSIVE
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.6,
              color: const Color(0xFF4E9F95),
            ),
          ),

          SizedBox(height: 10.h),

          // Title
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),

          SizedBox(height: 8.h),

          // Subtitle
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              color: const Color(0xFF6B7280),
            ),
          ),

          SizedBox(height: 22.h),

          // 🌿 Gradient Coupon Box
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF9AD9CF),
                  Color(0xFF6FB7AD),
                  Color(0xFF4E9F95),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.all(1.5), // gradient border thickness
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'USE CODE',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          color: const Color(0xFF6FB7AD),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        code,
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: const Color(0xFF111827),
                        ),
                      ),
                    ],
                  ),

                  // Copy Button
                  Container(
                    height: 36.h,
                    width: 36.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF9AD9CF),
                          Color(0xFF6FB7AD),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.copy,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 14.h),

          // Validity
          Text(
            validDate,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}


class _RefinementsSection extends StatelessWidget {
  const _RefinementsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'R E F I N E M E N T S',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF9CA3AF),
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              const _RefinementItem(text: 'INFINITY', icon: Icons.pool),
              SizedBox(width: 12.w),
              const _RefinementItem(text: 'AURA SPA', icon: Icons.spa),
              SizedBox(width: 12.w),
              const _RefinementItem(text: 'GOURMET', icon: Icons.restaurant),
              SizedBox(width: 12.w),
              const _RefinementItem(text: 'BEACH CLUB', icon: Icons.beach_access),
            ],
          ),
        ),
      ],
    );
  }
}

// 🟢 Updated: _RefinementItem with 3-Layer Green Gradient
class _RefinementItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const _RefinementItem({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
      decoration: BoxDecoration(
        // 🟢 3-Layer Gradient Applied Here
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2E5C38), // Darkest Green
            Color(0xFF4C846C), // Medium Green
            Color(0xFF66B290), // Lightest Green
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D58).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}