import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For map style
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// --- Custom Components Imports ---
import '../../components/custom_text/custom_text.dart';
import '../../components/custom_netwrok_image/custom_network_image.dart';

// --- Utils Imports ---
import '../../../utils/app_colors/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Controller for Google Map
  final Completer<GoogleMapController> _controller = Completer();

  // Initial Camera Position (Example: Kingston, Jamaica)
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(17.971214, -76.792812), // Kingston coordinates
    zoom: 13.5,
  );

  // Selected Category Index
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ["All", "Restaurants", "Experiences", "Events"];

  // Mock Data for Locations
  final List<Map<String, dynamic>> _locations = [
    {
      "id": "1",
      "name": "Bistro Moderne",
      "rating": 4.8,
      "type": "French Cuisine",
      "lat": 17.9750,
      "lng": -76.7850,
      "image": "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=800",
    },
    {
      "id": "2",
      "name": "Konoko Falls",
      "rating": 4.9,
      "type": "Nature • Waterfall",
      "lat": 17.9650,
      "lng": -76.8000,
      "image": "https://images.unsplash.com/photo-1468577760773-139c2f1c335f?q=80&w=600",
    },
    {
      "id": "3",
      "name": "Reggae Sumfest",
      "rating": 5.0,
      "type": "Music Festival",
      "lat": 17.9800,
      "lng": -76.7900,
      "image": "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=800",
    },
  ];

  // Markers Set
  final Set<Marker> _markers = {};

  // Page Controller for the bottom list
  late PageController _pageController;
  int _prevPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    _loadMarkers();
  }

  // Load Markers onto the map
  void _loadMarkers() {
    for (int i = 0; i < _locations.length; i++) {
      final loc = _locations[i];
      _markers.add(
        Marker(
          markerId: MarkerId(loc["id"]),
          position: LatLng(loc["lat"], loc["lng"]),
          infoWindow: InfoWindow(title: loc["name"], snippet: loc["type"]),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              i == 0 ? BitmapDescriptor.hueRed : BitmapDescriptor.hueAzure
          ),
          onTap: () {
            _onMarkerTapped(i);
          },
        ),
      );
    }
    setState(() {});
  }

  // Handle Marker Tap: Scroll list to the item
  void _onMarkerTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Handle Page Change: Move camera to the location
  void _onPageChanged(int index) async {
    final loc = _locations[index];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(loc["lat"], loc["lng"]), zoom: 15),
      ),
    );
    setState(() {
      _prevPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ------------------------------------------------
          // 1. Google Map Background
          // ------------------------------------------------
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kInitialPosition,
            markers: _markers,
            myLocationEnabled: true,
            zoomControlsEnabled: false, // Hide default zoom buttons
            mapToolbarEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              // Optional: Set Dark Mode Style here
            },
          ),

          // ------------------------------------------------
          // 2. Top Search & Filters
          // ------------------------------------------------
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Row(
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
                              ]
                          ),
                          child: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      // Search Field
                      Expanded(
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
                              ]
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search here...",
                              hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14.sp),
                              prefixIcon: Icon(Icons.search, color: AppColors.primary),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Category Filter Chips
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                          decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                              ]
                          ),
                          child: Text(
                            _categories[index],
                            style: GoogleFonts.poppins(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ------------------------------------------------
          // 3. Bottom Floating Location Cards
          // ------------------------------------------------
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            height: 140.h, // Height of the card container
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _locations.length,
              itemBuilder: (context, index) {
                return _buildLocationCard(_locations[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper: Location Card ---
  Widget _buildLocationCard(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CustomNetworkImage(
              imageUrl: item["image"],
              height: 120.h,
              width: 110.w,
            ),
          ),
          SizedBox(width: 15.w),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item["name"],
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryTitleTextClr,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      "${item["rating"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.star, color: Colors.amber, size: 14.sp),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        "• ${item["type"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                // Action Buttons
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.directions, color: AppColors.primary, size: 18.sp),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        height: 35.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "View Details",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}