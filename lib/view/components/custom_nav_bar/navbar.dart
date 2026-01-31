import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Screens Import
import '../../screens/HomeScreen/favouriteScreen.dart';
import '../../screens/HomeScreen/homeScreen.dart';
import '../../screens/HomeScreen/mapScreen.dart';
import '../../screens/profile/view/profileScreen.dart';

/// Standard NavBar widget (no scroll handling)
class NavBar extends StatelessWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return _NavBarContent(currentIndex: currentIndex);
  }
}

/// Scroll-aware NavBar wrapper - wraps your body content
class ScrollAwareScaffold extends StatefulWidget {
  final Widget body;
  final int navBarIndex;
  final PreferredSizeWidget? appBar;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;

  const ScrollAwareScaffold({
    required this.body,
    required this.navBarIndex,
    this.appBar,
    this.extendBody = true,
    this.extendBodyBehindAppBar = true,
    this.resizeToAvoidBottomInset = false,
    this.backgroundColor,
    super.key,
  });

  @override
  State<ScrollAwareScaffold> createState() => _ScrollAwareScaffoldState();
}

class _ScrollAwareScaffoldState extends State<ScrollAwareScaffold>
    with SingleTickerProviderStateMixin {
  bool _isNavBarVisible = true;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  DateTime _lastScrollTime = DateTime.now();
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      // User is actively scrolling
      _lastScrollTime = DateTime.now();
      if (!_isScrolling) {
        _isScrolling = true;
        _hideNavBar();
      }
      // Start timer to show navbar after scroll stops
      _checkScrollStopped();
    }
  }

  void _checkScrollStopped() async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (DateTime.now().difference(_lastScrollTime).inMilliseconds >= 150) {
      _isScrolling = false;
      _showNavBar();
    }
  }

  void _hideNavBar() {
    if (_isNavBarVisible) {
      setState(() => _isNavBarVisible = false);
      _animationController.forward();
    }
  }

  void _showNavBar() {
    if (!_isNavBarVisible) {
      setState(() => _isNavBarVisible = true);
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: widget.appBar,
      bottomNavigationBar: SlideTransition(
        position: _slideAnimation,
        child: _NavBarContent(currentIndex: widget.navBarIndex),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          _onScrollNotification(notification);
          return false;
        },
        child: widget.body,
      ),
    );
  }
}

/// Internal NavBar content widget
class _NavBarContent extends StatelessWidget {
  final int currentIndex;

  const _NavBarContent({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF151310),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(context, Icons.home_filled, "Home", 0),
          _buildNavItem(context, Icons.map_outlined, "Map", 1),
          _buildNavItem(context, Icons.favorite, "Favourite", 2),
          _buildNavItem(context, Icons.menu_rounded, "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;

    Color selectedColor = const Color(0xFFFFD54F);
    Color unselectedColor = Colors.grey;

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Get.offAll(() => const HomeScreen(), transition: Transition.fadeIn);
        } else if (currentIndex != index) {
          switch (index) {
            case 1:
              Get.to(() => const MapScreen(), transition: Transition.fadeIn);
              break;
            case 2:
              Get.to(() => const FavouriteScreen(),
                  transition: Transition.fadeIn);
              break;
            case 3:
              Get.offAll(() => const ProfileScreen(),
                  transition: Transition.fadeIn);
              break;
          }
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 12.w : 0, vertical: 8.h),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20.r),
              )
            : null,
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? selectedColor : unselectedColor,
              size: 24.sp,
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: selectedColor,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
