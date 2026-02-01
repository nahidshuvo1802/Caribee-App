import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tutor_app/view/screens/BussinessScreen/promotionPageDetails.dart';

// --- Custom Components Imports ---
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_netwrok_image/custom_network_image.dart';

class BusinessPromotionController extends GetxController {
  // 1=Hotels, 2=Experiences, 3=Transport
  final selectedTab = 1.obs;

  void setTab(int index) => selectedTab.value = index;
}

class BusinessPromotionScreen extends StatelessWidget {
  BusinessPromotionScreen({super.key});

  final BusinessPromotionController c =
      Get.put(BusinessPromotionController(), permanent: false);

  // --- 1. Hotels Data ---
  final List<Map<String, String>> _hotelOffers = [
    {
      'image':
          'https://images.unsplash.com/photo-1589990194992-bae914a46927?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Sandalwood Bay Resort',
      'country': 'St. Lucia',
      'tag': 'LIMITED TIME',
      'highlight': '15% Off Authentic Cuisine',
      'details':
          'Experience luxury in our beachfront villas with exclusive seasonal rates.',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=1200&auto=format&fit=crop',
      'title': 'Azure Boutique Hotel',
      'country': 'Barbados',
      'tag': 'BEST SELLER',
      'highlight': '3rd Night Free',
      'details':
          'A hidden gem overlooking the Caribbean Sea. Book 2 nights, get 1 free.',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1582719508461-905c673771fd?q=80&w=1200&auto=format&fit=crop',
      'title': 'Royal Palm Villas',
      'country': 'Jamaica',
      'tag': 'EXCLUSIVE',
      'highlight': 'All-Inclusive Upgrade',
      'details':
          'Complimentary upgrade to the Platinum Plan for stays over 5 nights.',
    },
  ];

  // --- 2. Experiences Data ---
  final List<Map<String, String>> _experienceOffers = [
    {
      'image': 'assets/images/Home/sunset_catamaran.png',
      'title': 'Sunset Catamaran',
      'country': 'Negril',
      'tag': 'MUST DO',
      'highlight': '20% Off Group Booking',
      'details':
          'Sail into the sunset with live music, drinks, and unforgettable views.',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?q=80&w=1200&auto=format&fit=crop',
      'title': 'Rainforest Zipline',
      'country': 'Ocho Rios',
      'tag': 'THRILL',
      'highlight': 'Free Photo Package',
      'details':
          'Soar through the canopy and experience the thrill of the jungle.',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?q=80&w=1200&auto=format&fit=crop',
      'title': 'Blue Mountain Hike',
      'country': 'Kingston',
      'tag': 'ADVENTURE',
      'highlight': 'Early Bird Special',
      'details':
          'Guided sunrise hike to the peak of the famous Blue Mountains.',
    },
  ];

  // --- 3. Transport Data (Optional) ---
  final List<Map<String, String>> _transportOffers = [
    {
      'image':
          'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?q=80&w=1200&auto=format&fit=crop',
      'title': 'Luxury SUV Transfer',
      'country': 'Montego Bay',
      'tag': 'PREMIUM',
      'highlight': '\$20 Off Round Trip',
      'details': 'Arrive in style with our private chauffeur service.',
    },
    {
      'image': 'assets/images/Home/helicopter_tour.png',
      'title': 'Island Helicopter Tour',
      'country': 'All Island',
      'tag': 'VIP',
      'highlight': 'Scenic Route Bonus',
      'details': 'Skip the traffic and enjoy breathtaking aerial views.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F4F8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18.sp),
          onPressed: () => Get.back(),
        ),
        title: CustomText(
          text: 'Exclusive Offers',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 28.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            // ---- Filter Chips (Obx for Tab Selection) ----
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () => Row(
                  children: [
                    _filterChip(
                        'Hotels', c.selectedTab.value == 1, () => c.setTab(1)),
                    SizedBox(width: 10.w),
                    _filterChip('Experiences', c.selectedTab.value == 2,
                        () => c.setTab(2)),
                    SizedBox(width: 10.w),
                    _filterChip('Transport', c.selectedTab.value == 3,
                        () => c.setTab(3)),
                  ],
                ),
              ),
            ),

            SizedBox(height: 18.h),

            // ---- Title section ----
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Exclusive Offers by Caribee',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  CustomText(
                    text: 'SELECTED FOR YOUR COMFORT',
                    fontSize: 12.sp,
                    color: const Color(0xFF6B7280),
                    top: 6.h,
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // ---- Exclusive Offer Cards (Dynamic List via Obx) ----
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(() {
                // Determine which list to show based on selectedTab
                List<Map<String, String>> currentList = [];
                if (c.selectedTab.value == 1) {
                  currentList = _hotelOffers;
                } else if (c.selectedTab.value == 2) {
                  currentList = _experienceOffers;
                } else {
                  currentList = _transportOffers;
                }

                return Column(
                  children: currentList.map((item) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: _largeOfferCard(
                        imageUrl: item['image']!,
                        tagText: item['tag']!,
                        title: item['title']!,
                        country: item['country']!,
                        highlight: item['highlight']!,
                        details: item['details']!,
                        buttonText: 'View Offer',
                        onCardTap: () {},
                        onButtonTap: () {
                          Get.to(() => Promotionpagedetails(),
                              transition: Transition.fadeIn);
                        },
                      ),
                    );
                  }).toList(),
                );
              }),
            ),

            SizedBox(height: 10.h),

            // ---- Seamless Travel (Static Section) ----
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                text: 'Seamless Travel',
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black,
                bottom: 12.h,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _seamlessTravelCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1529070538774-1843cb3265df?q=80&w=1200&auto=format&fit=crop',
                title: 'VIP Airport Transfer',
                subtitle: 'Island-wide • Priority Fast Track',
                priceText: r'$50 Off First Trip',
                buttonText: 'Reserve',
                onCardTap: () {},
                onButtonTap: () {
                  Get.to(() => Promotionpagedetails(),
                      transition: Transition.fadeIn);
                },
              ),
            ),

            SizedBox(height: 24.h),

            // ---- Trip Essentials (Static Section) ----
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                text: 'Trip Essentials',
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black,
                bottom: 12.h,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  _tripEssentialTile(
                    icon: Icons.support_agent,
                    title: 'Island Concierge',
                    subtitle: '24/7 Personal Assistant',
                    badgeText: 'Free 7-Day Trial',
                    onTap: () {
                      Get.to(() => Promotionpagedetails(),
                          transition: Transition.fadeIn);
                    },
                  ),
                  SizedBox(height: 12.h),
                  _tripEssentialTile(
                    icon: Icons.kitesurfing,
                    title: 'Premium Gear Rental',
                    subtitle: 'Snorkel, Scuba & More',
                    badgeText: 'Buy 1 Get 1 Rental',
                    onTap: () {
                      Get.to(() => Promotionpagedetails(),
                          transition: Transition.fadeIn);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- UI PARTS --------------------

  Widget _filterChip(String text, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
        decoration: BoxDecoration(
          // --- CHANGED: Green Gradient when selected ---
          gradient: selected
              ? const LinearGradient(
                  colors: [
                    Color(0xFF43A047), // Vibrant Green
                    Color(0xFF2F6D59), // Darker Theme Green
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: selected ? null : Colors.white,
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(
              color: selected ? Colors.transparent : const Color(0xFFE5E7EB)),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFF2F6D59).withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _largeOfferCard({
    required String imageUrl,
    required String tagText,
    required String title,
    required String country,
    required String highlight,
    required String details,
    required String buttonText,
    required VoidCallback onCardTap,
    required VoidCallback onButtonTap,
  }) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        height: 280.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: Stack(
            children: [
              // image
              Positioned.fill(
                child: imageUrl.startsWith('http')
                    ? CustomNetworkImage(
                        imageUrl: imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                      )
                    : Image.asset(
                        imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),

              // gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.35),
                        Colors.black.withOpacity(0.85),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),

              // tag
              Positioned(
                top: 14.h,
                right: 14.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    tagText,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF2F6D59),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),

              // content
              Positioned(
                left: 16.w,
                right: 16.w,
                bottom: 14.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      country,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      highlight,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      details,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        height: 1.25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.88),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // button (clickable)
                    GestureDetector(
                      onTap: onButtonTap,
                      child: Container(
                        height: 44.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.r),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFE65100),
                              Color(0xFF8B1E1E),
                            ],
                          ),
                        ),
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _seamlessTravelCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required String priceText,
    required String buttonText,
    required VoidCallback onCardTap,
    required VoidCallback onButtonTap,
  }) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 14,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Column(
            children: [
              SizedBox(
                height: 170.h,
                width: double.infinity,
                child: imageUrl.startsWith('http')
                    ? CustomNetworkImage(
                        imageUrl: imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                      )
                    : Image.asset(
                        imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            priceText,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF2F6D59),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: onButtonTap,
                      child: Container(
                        height: 42.h,
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE65100), Color(0xFF8B1E1E)],
                          ),
                        ),
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ---- Trip Essentials tile (matches your screenshot) ----
  Widget _tripEssentialTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String badgeText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // --- CHANGED: Green Gradient Icon Box ---
            Container(
              height: 46.w,
              width: 46.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF43A047), // Vibrant Green
                    Color(0xFF2F6D59), // Darker Theme Green
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(icon, color: Colors.white, size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    badgeText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF2F6D59),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: const Color(0xFF2F6D59), size: 22.sp),
          ],
        ),
      ),
    );
  }
}
