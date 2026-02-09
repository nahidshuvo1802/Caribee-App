import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Custom Components Imports
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_text/custom_text.dart';

class SupportScreen extends GetView {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Light background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:
              Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20.sp),
        ),
        title: Text(
          "Help & Support",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header Text
                  CustomText(
                    text: "We're here to help you every step of your journey.",
                    fontSize: 12,
                    color: Colors.grey,
                    textAlign: TextAlign.left,
                    bottom: 15.h,
                  ),

                  // 2. Top Header Card (Caribee Support Center)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFE9F5F0), // Light Green BG
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Image.asset(
                                "assets/images/profile/supporticon.png",
                                height: 20.h,
                                width: 20.w,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.headset_mic,
                                        color: const Color(0xFF2E7D58),
                                        size: 20.sp),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            CustomText(
                              text: 'Caribee Support Center',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1D1F24),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        CustomText(
                          text:
                              'Get help with the app, report issues, and learn about safety and trusted listings. Our support team is here to ensure you have the best experience.',
                          fontSize: 12,
                          color: const Color(0xFF666666),
                          textAlign: TextAlign.left,
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25.h),

                  // 3. Menu Items List
                  _buildMenuItem(
                    icon: Icons.question_mark_rounded,
                    title: "FAQs",
                    subtitle: "Find answers to common questions",
                    iconColor: const Color(0xFF4C7EFF),
                    iconBg: const Color(0xFFE8F1FF),
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.flag_rounded,
                    title: "Report an issue",
                    subtitle:
                        "Report incorrect info, bugs, or listing problems",
                    iconColor: const Color(0xFFFF8A50),
                    iconBg: const Color(0xFFFFEEE8),
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.email_outlined,
                    title: "Contact Support",
                    subtitle: "Reach our support team directly",
                    iconColor: const Color(0xFF3BB77E),
                    iconBg: const Color(0xFFE9F7F0),
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.shield_outlined,
                    title: "Safety & Trust",
                    subtitle: "Learn how we keep listings reliable",
                    iconColor: const Color(0xFF2E7D58),
                    iconBg: const Color(0xFFDFF3EA),
                    onTap: () {},
                  ),

                  SizedBox(height: 25.h),

                  // 4. FAQ Section
                  CustomText(
                    text: 'Frequently Asked Questions',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.left,
                    bottom: 15.h,
                    color: const Color(0xFF1D1F24),
                  ),

                  // FAQ Container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: const [
                        ExpandableFaq(title: 'How do I use Caribee?'),
                        Divider(height: 1, color: Color(0xFFEEEEEE)),
                        ExpandableFaq(title: 'Why can’t I see some offers?'),
                        Divider(height: 1, color: Color(0xFFEEEEEE)),
                        ExpandableFaq(
                            title: 'How do I report wrong information?'),
                        Divider(height: 1, color: Color(0xFFEEEEEE)),
                        ExpandableFaq(title: 'Is Caribee safe to use?'),
                      ],
                    ),
                  ),

                  // View All FAQs Link
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Row(
                      children: [
                        Text(
                          "View All FAQs",
                          style: TextStyle(
                            color: const Color(0xFF2E7D58),
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(Icons.arrow_forward,
                            size: 16.sp, color: const Color(0xFF2E7D58))
                      ],
                    ),
                  ),

                  SizedBox(height: 15.h),

                  // 5. Report a Problem Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5F2), // Peach/Light Orange
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.flag,
                                color: Color(0xFFE65100), size: 20),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: 'Report a Problem',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1D1F24),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          text:
                              'Help us maintain quality by reporting restaurant issues, event problems, app bugs, or incorrect information.',
                          fontSize: 12,
                          color: const Color(0xFF666666),
                          textAlign: TextAlign.left,
                          maxLines: 4,
                        ),
                        SizedBox(height: 20.h),

                        // Submit Button
                        SizedBox(
                          height: 45.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE65100),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Submit a Report",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 8.w),
                                Icon(Icons.arrow_forward,
                                    color: Colors.white, size: 16.sp),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),
                  const SafetyTrustInfoCard(),
                  SizedBox(height: 30.h),

                  // 7. Bottom "Get Help Now" Button (Gradient Green)
                  Container(
                    width: double.infinity,
                    height: 55.h,
                    decoration: BoxDecoration(
                      // ✅ UPDATED: Green Gradient Background
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2E7D58), // Dark Green
                          Color(0xFF5BD7BC), // Light Green
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E7D58).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // Action: Call or Chat Support
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.headset_mic,
                                color: Colors.white, size: 20.sp),
                            SizedBox(width: 10.w),
                            Text(
                              "Get Help Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper: Menu Item Builder ---
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color iconBg,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  height: 48.w,
                  width: 48.w,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1D1F24)),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 12.sp, color: Colors.grey, height: 1.2),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 14.sp, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Safety & Trust Info Card ---
class SafetyTrustInfoCard extends StatelessWidget {
  const SafetyTrustInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black
                .withValues(alpha: 0.05), // Fixed opacity for cleaner look
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F5F0),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.shield_outlined,
                    color: AppColors.green, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              CustomText(
                text: 'Safety & Trust Information',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryTitleTextClr,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CustomText(
            text:
                'Learn about our trusted listings, user safety measures, and how we maintain the reliability of our platform.',
            fontSize: 12,
            color: AppColors.grey_03,
            textAlign: TextAlign.left,
            maxLines: 5,
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              CustomText(
                text: "Learn more about Safety & Trust",
                color: const Color(0xFF2E7D58),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              SizedBox(width: 5.w),
              Icon(Icons.arrow_forward,
                  size: 16.sp, color: const Color(0xFF2E7D58))
            ],
          ),
        ],
      ),
    );
  }
}

// --- Helper: Expandable FAQ Item ---
class ExpandableFaq extends StatefulWidget {
  final String title;

  const ExpandableFaq({super.key, required this.title});

  @override
  State<ExpandableFaq> createState() => _ExpandableFaqState();
}

class _ExpandableFaqState extends State<ExpandableFaq> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
        childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        trailing: Icon(
          isOpen ? Icons.remove : Icons.add,
          color: isOpen ? const Color(0xFF2E7D58) : Colors.grey,
          size: 20.sp,
        ),
        onExpansionChanged: (value) {
          setState(() {
            isOpen = value;
          });
        },
        children: [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et.",
            style: TextStyle(
                fontSize: 13.sp, color: Colors.grey[600], height: 1.4),
          ),
        ],
      ),
    );
  }
}
