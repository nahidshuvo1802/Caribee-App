import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Custom Components Imports
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../../utils/app_colors/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  String selectedCountryCode = "+880"; // Default phone code

  @override
  void initState() {
    super.initState();
    // Default Data Set
    nameController.text = "Alex Morgan";
    emailController.text = "alex@gmail.com";
    dobController.text = "12/05/1998";
    countryController.text = "Bangladesh";
  }

  // --- Date Picker Function ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2E5C38),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // --- AppBar Updated ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20.sp),
        ),
        title: CustomText(
          text: "Edit Profile",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ------------------------------------------------
          // 1. Full Screen Background Image
          // ------------------------------------------------
          Positioned.fill(
            child: Image.asset(
              "assets/images/profile/profilebg.png",
              fit: BoxFit.cover,
            ),
          ),

          // ------------------------------------------------
          // 2. Content Overlay
          // ------------------------------------------------
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10.h),

                // --- Scrollable Form Area ---
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align titles to start
                      children: [
                        // Profile Image with Camera Icon
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50.r,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage: const NetworkImage("https://i.pravatar.cc/300?img=11"),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2E5C38),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.camera_alt, color: Colors.white, size: 16.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),

                        // --- 1. Full Name Field ---
                        _buildFieldTitle("Full Name"),
                        CustomTextField(
                          textEditingController: nameController,
                          hintText: "Full Name",
                          prefixIcon: Icon(Icons.person_outline, color: const Color(0xFF2E5C38), size: 22.sp),
                          fillColor: Colors.white.withOpacity(0.9),
                          fieldBorderRadius: 40,
                        ),
                        SizedBox(height: 15.h),

                        // --- 2. Email Field ---
                        _buildFieldTitle("Email"),
                        CustomTextField(
                          textEditingController: emailController,
                          hintText: "Email Address",
                          prefixIcon: Icon(Icons.email_outlined, color: const Color(0xFF2E5C38), size: 22.sp),
                          fillColor: Colors.white.withOpacity(0.9),
                          keyboardType: TextInputType.emailAddress,
                          fieldBorderRadius: 40,
                        ),
                        SizedBox(height: 15.h),

                        // --- 3. Date of Birth ---
                        _buildFieldTitle("Date of Birth"),
                        CustomTextField(
                          textEditingController: dobController,
                          hintText: "Date of Birth",
                          readOnly: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          prefixIcon: Icon(Icons.cake_outlined, color: const Color(0xFF2E5C38), size: 22.sp),
                          suffixIcon: IconButton(
                            onPressed: () => _selectDate(context),
                            icon: Icon(Icons.calendar_month, color: const Color(0xFF2E5C38), size: 22.sp),
                          ),
                          fieldBorderRadius: 40,
                        ),
                        SizedBox(height: 15.h),

                        // --- 4. Country Selection Box ---
                        _buildFieldTitle("Country"),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(40.r),
                            border: Border.all(color: const Color(0xFF2E5C38).withOpacity(0.5)),
                          ),
                          child: CountryCodePicker(
                            onChanged: (country) {
                              countryController.text = country.name!;
                            },
                            initialSelection: 'BD',
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: true,
                            alignLeft: true,
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            builder: (country) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.public, color: const Color(0xFF2E5C38), size: 22.sp),
                                        SizedBox(width: 15.w),
                                        SizedBox(
                                          width: 200.w,
                                          child: Text(
                                            country?.name ?? "Select Country",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 15.h),

                        // --- 5. Phone Number with Country Code ---
                        _buildFieldTitle("Phone Number"),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(40.r),
                            border: Border.all(color: const Color(0xFF2E5C38).withOpacity(0.5)),
                          ),
                          child: Row(
                            children: [
                              CountryCodePicker(
                                onChanged: (country) {
                                  setState(() {
                                    selectedCountryCode = country.dialCode!;
                                  });
                                },
                                initialSelection: 'BD',
                                favorite: const ['+880', 'US'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                                padding: EdgeInsets.zero,
                                flagWidth: 25.w,
                              ),
                              Container(
                                height: 25.h,
                                width: 1.w,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40.h),

                        // --- Update Button ---
                        CustomButton(
                          onTap: () {
                            Get.back();
                          },
                          title: "Update Profile",
                          borderRadius: 40,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF2E5C38), // Dark Green
                              Color(0xFF66B290), // Lighter Green
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),

                        SizedBox(height: 30.h),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for Field Titles
  Widget _buildFieldTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
      child: CustomText(
        text: title,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}