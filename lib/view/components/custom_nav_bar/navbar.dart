// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../../../utils/app_colors/app_colors.dart';
// import '../../../utils/app_icons/app_icons.dart';
// import '../../../utils/app_strings/app_strings.dart';
//
// import '../custom_text/custom_text.dart';
//
// class NavBar extends StatefulWidget {
//   final int currentIndex;
//
//   const NavBar({required this.currentIndex, super.key});
//
//   @override
//   State<NavBar> createState() => _UserNavBarState();
// }
//
// class _UserNavBarState extends State<NavBar> {
//   late int bottomNavIndex;
//   final List<String> navbarNameList = [
//     "home".tr,
//     "message".tr,
//     "schedule".tr,
//     "favorites".tr,
//     "profile".tr,
//   ];
//   final List<String> selectedIcon = [
//     AppIcons.homeS,
//     AppIcons.messageS,
//     AppIcons.scheduleS,
//     AppIcons.favoriteS,
//     AppIcons.profileS,
//   ];
//   final List<String> unselectedIcon = [
//     AppIcons.homeU,
//     AppIcons.messageU,
//     AppIcons.scheduleU,
//     AppIcons.favoriteU,
//     AppIcons.profileU,
//   ];
//
//   @override
//   void initState() {
//     bottomNavIndex = widget.currentIndex;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       decoration: BoxDecoration(
//           color: Color(0xffFEFEFE),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.r),
//           topRight: Radius.circular(20.r),
//         ),
//         border: Border.all(color: AppColors.grey_03,width: .2),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withValues(alpha: 0.1),
//             spreadRadius: 1,
//             blurRadius: 0,
//             offset: const Offset(3, 0),
//           ),
//         ]
//       ),
//       height: 85.h,
//       width: MediaQuery.of(context).size.width,
//       alignment: Alignment.centerLeft,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(
//           selectedIcon.length,
//               (index) => InkWell(
//             onTap: () => onTap(index),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(height: 6.h,),
//                 Container(
//                   height: 40.h,
//                   width: 40.w,
//                   alignment: Alignment.center,
//                   child: SvgPicture.asset(
//                     index == bottomNavIndex ? selectedIcon[index] : unselectedIcon[index],
//                     height: 24.h,
//                     width: 24.w,
//                   ),
//                 ),
//                 CustomText(
//                   text: navbarNameList[index],
//                   color: index == bottomNavIndex ? AppColors.primary : AppColors.grey_03,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 12.w,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void onTap(int index) {
//     if (index != bottomNavIndex) {
//       setState(() {
//         bottomNavIndex = index;
//       });
//
//       switch (index) {
//         case 0:
//           Get.offAll(() => HomeScreen());
//           break;
//         case 1:
//           Get.to(() => MessageListScreen());
//           break;
//         case 2:
//           Get.to(() => MyCalendarScreen());
//           break;
//         case 3:
//           Get.to(() => FavoritesScreen());
//           break;
//         case 4:
//           Get.to(() => ProfileScreen());
//           break;
//       }
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Screens Import
import '../../screens/HomeScreen/favouriteScreen.dart';
import '../../screens/HomeScreen/homeScreen.dart'; // Ensure this path is correct
import '../../screens/HomeScreen/mapScreen.dart';
import '../../screens/profile/view/profileScreen.dart'; // Ensure this path is correct

class NavBar extends StatelessWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF151310), // Dark background matching the image
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

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;

    // Colors
    Color selectedColor = const Color(0xFFFFD54F); // Gold/Yellow
    Color unselectedColor = Colors.grey;

    return GestureDetector(
      onTap: () {
        // --- FIX STARTS HERE ---
        // If index is 0 (Home), ALWAYS navigate, regardless of currentIndex
        if (index == 0) {
          Get.offAll(() => const HomeScreen(), transition: Transition.fadeIn);
        }
        // For other tabs, only navigate if it's a different tab
        else if (currentIndex != index) {
          switch (index) {
            case 1:
            Get.to(() => const MapScreen(), transition: Transition.fadeIn);
              print("Navigate to Map");
              break;
            case 2:
            Get.to(() => const FavouriteScreen(), transition: Transition.fadeIn);

              break;
            case 3:
              Get.offAll(() => const ProfileScreen(), transition: Transition.fadeIn);
              break;
          }
        }
        // --- FIX ENDS HERE ---
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 12.w : 0, vertical: 8.h),
        decoration: isSelected
            ? BoxDecoration(
          color: Colors.white.withOpacity(0.05), // Subtle highlight for selected
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