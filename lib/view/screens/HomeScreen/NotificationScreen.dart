import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom Components Imports
import '../../components/custom_image/custom_image.dart';
import '../../components/custom_nav_bar/navbar.dart';
import '../../components/custom_royel_appbar/custom_royel_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: SlideTransition(
        position: _navBarSlideAnimation,
        child: const NavBar(currentIndex: 0),
      ),
      body: Stack(
        children: [
          // ---------       ---------------------------------------
          // 1. Background Image
          // ------------------------------------------------
          Positioned.fill(
            child: CustomImage(
              imageSrc: "assets/images/profile/profilebg.png",
              imageType: ImageType.png,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),

          // ------------------------------------------------
          // 2. Content Overlay
          // ------------------------------------------------
          SafeArea(
            child: Column(
              children: [
                // --- Custom App Bar ---
                const CustomRoyelAppbar(
                  titleName: "Notifications",
                  leftIcon: true,
                  color: Colors.white,
                  backgroundColor: Colors.transparent,
                ),

                SizedBox(height: 20.h),

                // --- Content Container (Glassmorphism Style) ---
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                          alpha: 0.9), // আগের স্ক্রিনগুলোর মতো সলিড সাদা ভাব
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    // Notification List
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _onScrollNotification,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: 5, // ডামি ডাটা সংখ্যা
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.withValues(alpha: 0.2),
                          height: 20.h,
                        ),
                        itemBuilder: (context, index) {
                          return _buildNotificationItem(
                            title: "Payment Successful",
                            message:
                                "Your payment for the course 'Web Development' was successful.",
                            time: "2 hours ago",
                            isUnread: index ==
                                0, // প্রথমটি unread হিসেবে দেখানোর জন্য
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget: Single Notification Item ---
  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    bool isUnread = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon Container
        Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
            color: const Color(0xFF2E5C38)
                .withValues(alpha: 0.1), // হালকা গ্রিন ব্যাকগ্রাউন্ড
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications_outlined,
            color: const Color(0xFF2E5C38), // অ্যাপের থিম কালার
            size: 20.sp,
          ),
        ),
        SizedBox(width: 15.w),

        // Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: const Color(0xFF1D1F24), // ডার্ক ব্ল্যাক
                        fontWeight: FontWeight.w600, // সেমি-বোল্ড
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Time
                  Text(
                    time,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: const Color(0xFF666666), // গ্রে কালার
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),

              // Message Body
              Text(
                message,
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: const Color(0xFF666666), // গ্রে কালার
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Unread Indicator Dot (Optional)
        if (isUnread)
          Container(
            margin: EdgeInsets.only(left: 10.w, top: 5.h),
            height: 8.h,
            width: 8.w,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
