import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caribee_app/view/screens/BussinessScreen/BussinessPromotionScreen.dart';
import 'package:caribee_app/view/screens/profile/view/help_and_support.dart';
import 'package:caribee_app/view/screens/profile/view/settings/aboutUs.dart';
import 'package:caribee_app/view/screens/profile/view/settingsScreen.dart';

// Custom Components
import '../../../components/custom_nav_bar/navbar.dart';
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_text_field/custom_text_field.dart';
import '../../Authentication/view/LoginScreen.dart';

// Other Screens
import 'editProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
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
        child: const NavBar(currentIndex: 3),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // -------- Background --------
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/profile/profilebg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // -------- Content --------
          SafeArea(
            bottom: false,
            child: NotificationListener<ScrollNotification>(
              onNotification: _onScrollNotification,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    // -------- Profile Header --------
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFFD54F),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 35.r,
                            backgroundImage: const NetworkImage(
                              "https://i.pravatar.cc/300?img=11",
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        CustomText(
                          text: "Alex Morgan",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),

                    // -------- eSIM Banner --------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        // 🟢 1. Outer Container: Holds the Image
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/Home/fire.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          // 🟢 2. Inner Container: Holds the Gradient Overlay & Content
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                // Left Color: rgba(255, 98, 0, 1) -> with Opacity
                                const Color.fromRGBO(255, 98, 0, 1)
                                    .withValues(alpha: 0.85),
                                // Right Color: rgba(107, 28, 29, 1) -> with Opacity
                                const Color.fromRGBO(107, 28, 29, 1)
                                    .withValues(alpha: 0.85),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // 🟢 UPDATED: Using Asset Image instead of Icon
                                  Image.asset(
                                    "assets/images/profile/fastfood.png",
                                    height: 30.h,
                                    width: 30.w,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Exclusive offer By",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                        "Caribee",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => BusinessPromotionScreen(),
                                    transition: Transition.fadeIn,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFC107),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    "See Offer",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // -------- Menu Items --------

                    // 🟢 1. Edit Profile -> Icons.manage_accounts
                    _buildProfileMenuItem(
                      icon: Icons.manage_accounts,
                      title: "Edit Profile",
                      onTap: () {
                        Get.to(() => const EditProfileScreen(),
                            transition: Transition.fadeIn);
                      },
                    ),
                    SizedBox(height: 15.h),

                    // 🟢 2. Account Settings -> Icons.settings
                    _buildProfileMenuItem(
                      icon: Icons.settings,
                      title: "Account Settings",
                      onTap: () {
                        Get.to(() => const AccountSettingsScreen(),
                            transition: Transition.fadeIn);
                      },
                    ),
                    SizedBox(height: 15.h),

                    // 🟢 3. Help & Support -> Icons.headset_mic
                    _buildProfileMenuItem(
                      icon: Icons.headset_mic,
                      title: "Help & support",
                      onTap: () {
                        Get.to(() => const SupportScreen(),
                            transition: Transition.fadeIn);
                      },
                    ),
                    SizedBox(height: 15.h),

                    // 🟢 4. About -> Icons.info
                    _buildProfileMenuItem(
                      icon: Icons.info,
                      title: "About",
                      onTap: () {
                        Get.to(() => const AboutUsScreen(),
                            transition: Transition.fadeIn);
                      },
                    ),
                    SizedBox(height: 15.h),

                    // 🟢 5. Log Out -> Icons.power_settings_new
                    _buildProfileMenuItem(
                      icon: Icons.power_settings_new_outlined,
                      title: "Log out",
                      onTap: () {
                        // Loading Dialog
                        Get.dialog(
                          const Center(
                            child: CircularProgressIndicator(
                              color: Colors.green,
                            ),
                          ),
                          barrierDismissible: false,
                        );

                        // Snackbar (2 seconds)
                        Get.snackbar(
                          "Success",
                          "Logout successfully",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(16),
                          borderRadius: 8,
                          duration: const Duration(seconds: 2),
                        );

                        // After 2 seconds → Login
                        Future.delayed(const Duration(seconds: 2), () {
                          Get.back(); // close loader
                          Get.offAll(() => const LoginScreen());
                        });
                      },
                    ),

                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------- Menu Tile Widget --------
  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return CustomTextField(
      readOnly: true,
      onTap: onTap,
      fillColor: Colors.white.withValues(alpha: 0.85),
      fieldBorderRadius: 12,
      fieldBorderColor: Colors.transparent,
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF2E5C38),
        size: 24.sp,
      ),
      suffixIcon: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16.sp,
      ),
      hintText: title,
      hintStyle: const TextStyle(
        color: Color(0xFF4F4F59),
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      textEditingController: TextEditingController(),
    );
  }
}
