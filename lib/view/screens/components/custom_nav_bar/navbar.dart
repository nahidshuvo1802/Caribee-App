/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_icons/app_icons.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../../screens/student_part/favorites/favorites_screen.dart';
import '../../screens/student_part/home/home_screen/home_screen.dart';
import '../../screens/student_part/message/messages_list_page.dart';
import '../../screens/student_part/profile/profile_screen.dart';
import '../../screens/student_part/schedule/my_calendar_screen.dart';
import '../custom_text/custom_text.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<NavBar> {
  late int bottomNavIndex;
  final List<String> navbarNameList = [
    "home".tr,
    "message".tr,
    "schedule".tr,
    "favorites".tr,
    "profile".tr,
  ];
  final List<String> selectedIcon = [
    AppIcons.homeS,
    AppIcons.messageS,
    AppIcons.scheduleS,
    AppIcons.favoriteS,
    AppIcons.profileS,
  ];
  final List<String> unselectedIcon = [
    AppIcons.homeU,
    AppIcons.messageU,
    AppIcons.scheduleU,
    AppIcons.favoriteU,
    AppIcons.profileU,
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: Color(0xffFEFEFE),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        border: Border.all(color: AppColors.grey_03,width: .2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(3, 0),
          ),
        ]
      ),
      height: 85.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          selectedIcon.length,
              (index) => InkWell(
            onTap: () => onTap(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 6.h,),
                Container(
                  height: 40.h,
                  width: 40.w,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    index == bottomNavIndex ? selectedIcon[index] : unselectedIcon[index],
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                CustomText(
                  text: navbarNameList[index],
                  color: index == bottomNavIndex ? AppColors.primary : AppColors.grey_03,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index != bottomNavIndex) {
      setState(() {
        bottomNavIndex = index;
      });

      switch (index) {
        case 0:
          Get.offAll(() => HomeScreen());
          break;
        case 1:
          Get.to(() => MessageListScreen());
          break;
        case 2:
          Get.to(() => MyCalendarScreen());
          break;
        case 3:
          Get.to(() => FavoritesScreen());
          break;
        case 4:
          Get.to(() => ProfileScreen());
          break;
      }
    }
  }
}
*/
