import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// তোমার প্রজেক্টের পাথ অনুযায়ী ইমপোর্ট ঠিক রেখো
import 'package:tutor_app/view/components/custom_image/custom_image.dart';
import '../../components/custom_nav_bar/navbar.dart';

class Eventdetailsscreen extends StatefulWidget {
  const Eventdetailsscreen({Key? key}) : super(key: key);

  @override
  State<Eventdetailsscreen> createState() => _EventdetailsscreenState();
}

class _EventdetailsscreenState extends State<Eventdetailsscreen>
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
      extendBody: true,
      bottomNavigationBar: SlideTransition(
        position: _navBarSlideAnimation,
        child: const NavBar(currentIndex: 0),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: CustomScrollView(
          slivers: [
            // ------------------------------------------------
            // Sliver App Bar (Sticky Header)
            // ------------------------------------------------
            SliverAppBar(
              expandedHeight: 250.h,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,

              // --- Leading Icon ---
              leading: Container(
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: 18.sp),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // --- Title (Sticky) ---
              centerTitle: true,
              title: Text(
                'Event Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              // --- Flexible Background Image ---
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Hero Image
                    Container(
                      color: Colors.grey[300],
                      child: Image.asset(
                        'assets/images/Home/eventdetail.png', // Replace with your asset
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFE0E0E0),
                            child: Icon(Icons.event,
                                size: 80.sp, color: Colors.grey[400]),
                          );
                        },
                      ),
                    ),
                    // Gradient Overlay
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                            Colors.black.withOpacity(0.4),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ------------------------------------------------
            // Main Body Content
            // ------------------------------------------------
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    _buildHeaderSection(),

                    Divider(height: 1.h, thickness: 1, color: Colors.grey[200]),

                    // Information Section (Updated with Gradient Icons)
                    _buildInformationSection(),

                    // Map Section (Updated with Gradient Button)
                    _buildMapSection(),

                    // Reviews Section
                    _buildReviewsSection(),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildHeaderSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Summer Beats Music Fest',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.favorite_border, size: 24.sp, color: Colors.black),
                  SizedBox(width: 16.w),
                  Icon(Icons.share_outlined, size: 24.sp, color: Colors.black),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Tags
          Row(
            children: [
              _buildTag('Jamaican Music', const Color(0xFFFFE8E8)),
              SizedBox(width: 8.w),
            ],
          ),
          SizedBox(height: 12.h),

          // Rating
          Row(
            children: [
              Text(
                'Event',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8.w),
              ...List.generate(
                5,
                (index) => Icon(
                  index < 4 ? Icons.star : Icons.star_half,
                  color: Colors.amber,
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '4.8',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '(124)',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Hours
          Row(
            children: [
              Icon(Icons.access_time, size: 16.sp, color: Colors.grey[600]),
              SizedBox(width: 4.w),
              Text(
                'Open until 11 PM',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Description
          Text(
            'Experience authentic flavors blended with Caribbean warmth, using locally sourced ingredients and refined presentation.',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xFFD32F2F),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInformationSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Information',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(height: 16.h),
          _buildInfoItem(Icons.attach_money, '\$', 'Upscale dining'),
          SizedBox(height: 12.h),
          _buildInfoItem(
              Icons.access_time, 'Open until 11:00 PM', 'Mon-Sun: 5PM - 11PM'),
          SizedBox(height: 12.h),
          _buildInfoItem(
              Icons.location_on, 'Downtown District', '123 Main Street'),
        ],
      ),
    );
  }

  // 🟢 Updated Info Item with Gradient Background
  Widget _buildInfoItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // 🟢 Gradient added here
            gradient: const LinearGradient(
              colors: [
                Color(0xFF66B290), // Light Green
                Color(0xFF4C846C), // Medium Green
                Color(0xFF2E5C38), // Dark Green
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
              SizedBox(height: 2.h),
              Text(subtitle,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMapSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Container(
            height: 180.h,
            decoration: BoxDecoration(
              color: const Color(0xFFB8D4D1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                Center(
                  child: CustomImage(
                    imageSrc: 'assets/images/Home/map.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                Center(
                    child: Icon(Icons.location_on,
                        size: 50.sp, color: const Color(0xFFE53935))),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // 🟢 Gradient "View Details" Button
          Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF66B290),
                  Color(0xFF4C846C),
                  Color(0xFF2E5C38),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 5,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text(
                'View Details',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reviews',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text('See all',
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFFE57373),
                      fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(height: 16.h),
          _buildReviewItem(),
        ],
      ),
    );
  }

  Widget _buildReviewItem() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.grey[300],
                  child:
                      Icon(Icons.person, size: 24.sp, color: Colors.grey[600])),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sarah Mitchell',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    SizedBox(height: 2.h),
                    Row(
                        children: List.generate(
                            5,
                            (index) => Icon(Icons.star,
                                color: Colors.amber, size: 14.sp))),
                  ],
                ),
              ),
              Text('2 days ago',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            ],
          ),
          SizedBox(height: 12.h),
          Text('Absolutely stunning experience!',
              style: TextStyle(
                  fontSize: 14.sp, color: Colors.grey[700], height: 1.4)),
        ],
      ),
    );
  }
}
