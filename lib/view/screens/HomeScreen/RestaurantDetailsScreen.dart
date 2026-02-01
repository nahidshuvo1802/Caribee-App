import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/view/components/custom_image/custom_image.dart';
import '../../components/custom_nav_bar/navbar.dart';

class RestaurantDetailsPage extends StatefulWidget {
  const RestaurantDetailsPage({super.key});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage>
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
            // Sliver App Bar (Sticky Header with Rounded Image)
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
                'Restaurant Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              // --- Background Image with Radius ---
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Hero Image
                    Container(
                      color: Colors.grey[300],
                      child: Image.network(
                        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=1200&auto=format&fit=crop',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: const Color(0xFFE0E0E0),
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: const Color(0xFF2F6D59),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFE0E0E0),
                            child: Icon(Icons.restaurant,
                                size: 80.sp, color: Colors.grey[400]),
                          );
                        },
                      ),
                    ),
                    // Gradient overlay
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ------------------------------------------------
            // Main Content
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
                    // Restaurant Header Section
                    _buildHeaderSection(),

                    Divider(height: 1.h, thickness: 1, color: Colors.grey[200]),

                    // Information Section (Updated Icons)
                    _buildInformationSection(),

                    // Map Section (Gradient Button)
                    _buildMapSection(),

                    // Photos from visitors
                    _buildPhotosSection(),

                    // View Menu Button
                    _buildViewMenuButton(),

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
                  'Bella Vista Ristorante',
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
              _buildTag('Seafood', const Color(0xFFFFE8E8)),
              SizedBox(width: 8.w),
              _buildTag('Jamaican Traditional', const Color(0xFFE8F5E9)),
              SizedBox(width: 8.w),
              _buildTag('Italian', const Color(0xFFFFF8E1)),
            ],
          ),
          SizedBox(height: 12.h),

          // Rating
          Row(
            children: [
              Text(
                'Restaurant',
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
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Distance
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: 16.sp, color: Colors.grey[600]),
              SizedBox(width: 4.w),
              Text(
                '0.3 miles away',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
              ),
              SizedBox(width: 16.w),
              Icon(Icons.access_time, size: 16.sp, color: Colors.grey[600]),
              SizedBox(width: 4.w),
              Text(
                'Open until 11 PM',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Text(
            'Experience authentic Italian flavors blended with Caribbean warmth, using locally sourced ingredients and refined presentation.',
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
          color: text == 'Seafood'
              ? const Color(0xFFD32F2F)
              : text == 'Jamaican Traditional'
                  ? const Color(0xFF388E3C)
                  : const Color(0xFFF57C00),
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
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.h),

          // Price Range
          _buildInfoItem(
            Icons.attach_money,
            '\$\$\$',
            'Upscale dining',
          ),
          SizedBox(height: 12.h),

          // Opening Hours
          _buildInfoItem(
            Icons.access_time,
            'Open until 11:00 PM',
            'Mon-Sun: 5:00 PM - 11:00 PM',
          ),
          SizedBox(height: 12.h),

          // Location
          _buildInfoItem(
            Icons.location_on,
            'Downtown District',
            '123 Main Street, City Center',
          ),
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey[600],
                ),
              ),
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
                      size: 50.sp, color: const Color(0xFFE53935)),
                ),
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
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'View Details',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Photos from visitors',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 180.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                // Different restaurant images for each card
                final List<String> visitorPhotos = [
                  'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?q=80&w=800&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=800&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=800&auto=format&fit=crop',
                ];
                return Container(
                  width: 240.w,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      visitorPhotos[index],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: const Color(0xFFE0E0E0),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: const Color(0xFF2F6D59),
                              strokeWidth: 2.5,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFE0E0E0),
                          child: Icon(Icons.photo,
                              size: 60.sp, color: Colors.grey[400]),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewMenuButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFD54F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'View Menu',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF5F4B00),
            ),
          ),
        ),
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
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFFE57373),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildReviewItem(),
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
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 24.sp, color: Colors.grey[600]),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sarah Mitchell',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '2 days ago',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Absolutely stunning experience! The jerk lobster pasta was incredible, and the view at sunset is unmatched. Service was warm and attentive.',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
