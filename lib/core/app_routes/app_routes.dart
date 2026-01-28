/*
// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import '../../view/screens/splash_screen/splash_screen.dart';
import '../../view/screens/student_part/auth/forgot_password_screen/forgot_password_screen.dart';
import '../../view/screens/student_part/auth/reset_password_screen/reset_password_screen.dart';
import '../../view/screens/student_part/auth/sign_in_screen/sign_in_screen.dart';
import '../../view/screens/student_part/auth/sign_up_screen/sign_up_screen.dart';
import '../../view/screens/student_part/auth/verify_code_screen/verify_code_screen.dart';
import '../../view/screens/student_part/home/all_categories_screen/all_categories_screen.dart';
import '../../view/screens/student_part/home/home_screen/home_screen.dart';
import '../../view/screens/student_part/home/notifications_screen/notifications_screen.dart';
import '../../view/screens/student_part/home/payment_screen/payment_screen.dart';
import '../../view/screens/student_part/home/popular_tutor_screen/popular_tutor_screen.dart';
import '../../view/screens/student_part/home/set_schedule_screen/set_schedule_screen.dart';
import '../../view/screens/student_part/home/tutor_profile_details/tutor_profile_details.dart';
import '../../view/screens/student_part/profile/account_info_screen/account_info_screen.dart';
import '../../view/screens/student_part/profile/account_info_screen/edit_profile_screen.dart';
import '../../view/screens/student_part/profile/booking_history_screen/booking_history_screen.dart';
import '../../view/screens/student_part/profile/help_center_screen/help_center_screen.dart';
import '../../view/screens/student_part/profile/privacy_policy_screen/privacy_policy_screen.dart';
import '../../view/screens/student_part/profile/profile_screen.dart';
import '../../view/screens/student_part/profile/setting_screen/change_language.dart';
import '../../view/screens/student_part/profile/setting_screen/change_password_screen.dart';
import '../../view/screens/student_part/profile/setting_screen/setting_screen.dart';
import '../../view/screens/student_part/profile/terms_conditions_screen/terms_conditions_screen.dart';
import '../../view/screens/student_part/schedule/my_calendar_screen.dart';
import '../../view/screens/teacher_part/auth/teacher_profile_setup_screen/teacher_profile_setup_screen.dart';
import '../../view/screens/teacher_part/auth/teacher_verify_screen/teacher_verify_screen.dart';
import '../../view/screens/teacher_part/profile/availability_screen/teacher_availability_screen.dart';
import '../../view/screens/teacher_part/profile/documents_screen/teacher_documents_screen.dart';
import '../../view/screens/teacher_part/profile/help_center_screen/teacher_help_center_screen.dart';
import '../../view/screens/teacher_part/profile/privacy_policy_screen/teacher_privacy_policy_screen.dart';
import '../../view/screens/teacher_part/profile/teacher_personal_info_screen/edit_teacher_personal_info_screen.dart';
import '../../view/screens/teacher_part/profile/teacher_personal_info_screen/teacher_personal_info_screen.dart';
import '../../view/screens/teacher_part/profile/teacher_profile_setting/teacher_profile_setting.dart';
import '../../view/screens/teacher_part/profile/teacher_setting_screen/teacher_change_language.dart';
import '../../view/screens/teacher_part/profile/teacher_setting_screen/teacher_change_password_screen.dart';
import '../../view/screens/teacher_part/profile/teacher_setting_screen/teacher_setting_screen.dart';
import '../../view/screens/teacher_part/profile/terms_conditions_screen/teacher_terms_conditions_screen.dart';
import '../../view/screens/teacher_part/schedule/teacher_schedule_screen.dart';
import '../../view/screens/teacher_part/teacher_home_screen/teacher_home_screen.dart';
import '../../view/screens/teacher_part/wallet/teacher_wallet_screen.dart';

class AppRoutes {
  ///=========================== Student Part ===============
  static const String splashScreen = "/SplashScreen";
  static const String signInScreen = "/SignInScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String verifyCodeScreen = "/VerifyCodeScreen";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String homeScreen = "/HomeScreen";
  static const String allCategoriesScreen = "/AllCategoriesScreen";
  static const String profileScreen = "/ProfileScreen";
  static const String accountInfoScreen = "/AccountInfoScreen";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String bookingHistoryScreen = "/BookingHistoryScreen";
  static const String settingScreen = "/SettingScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String changeLanguage = "/ChangeLanguage";
  static const String helpCenterScreen = "/HelpCenterScreen";
  static const String termsConditionsScreen = "/TermsConditionsScreen";
  static const String privacyPolicyScreen = "/PrivacyPolicyScreen";
  static const String tutorProfileDetails = "/TutorProfileDetails";
  static const String setScheduleScreen = "/SetScheduleScreen";
  static const String paymentScreen = "/PaymentScreen";
  static const String myCalendarScreen = "/MyCalendarScreen";
  static const String popularTutorScreen = "/PopularTutorScreen";
  static const String notificationsScreen = "/NotificationsScreen";


  ///=================== Teacher Part ======================
  static const String teacherHomeScreen ="/TeacherHomeScreen";
  static const String teacherProfileSetting ="/TeacherProfileSetting";
  static const String teacherPersonalInfoScreen ="/TeacherPersonalInfoScreen";
  static const String editTeacherPersonalInfoScreen ="/EditTeacherPersonalInfoScreen";
  static const String teacherAvailabilityScreen ="/TeacherAvailabilityScreen";
  static const String teacherDocumentsScreen ="/TeacherDocumentsScreen";
  static const String teacherSettingScreen ="/TeacherSettingScreen";
  static const String teacherChangePasswordScreen ="/TeacherChangePasswordScreen";
  static const String teacherChangeLanguage ="/TeacherChangeLanguage";
  static const String teacherHelpCenterScreen ="/TeacherHelpCenterScreen";
  static const String teacherPrivacyPolicyScreen ="/TeacherPrivacyPolicyScreen";
  static const String teacherTermsConditionsScreen ="/TeacherTermsConditionsScreen";
  static const String teacherWalletScreen ="/TeacherWalletScreen";
  static const String teacherScheduleScreen ="/TeacherScheduleScreen";
  static const String teacherVerifyScreen ="/TeacherVerifyScreen";
  static const String teacherProfileSetupScreen ="/TeacherProfileSetupScreen";



  static List<GetPage> routes = [
    ///=========================== Student Part ==============
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: signInScreen, page: () => SignInScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: verifyCodeScreen, page: () => VerifyCodeScreen()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(name: resetPasswordScreen, page: () => ResetPasswordScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: allCategoriesScreen, page: () => AllCategoriesScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: accountInfoScreen, page: () => AccountInfoScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: bookingHistoryScreen, page: () => BookingHistoryScreen()),
    GetPage(name: settingScreen, page: () => SettingScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(name: changeLanguage, page: () => ChangeLanguage()),
    GetPage(name: helpCenterScreen, page: () => HelpCenterScreen()),
    GetPage(name: termsConditionsScreen, page: () => TermsConditionsScreen()),
    GetPage(name: privacyPolicyScreen, page: () => PrivacyPolicyScreen()),
    GetPage(name: tutorProfileDetails, page: () => TutorProfileDetails()),
    GetPage(name: setScheduleScreen, page: () => SetScheduleScreen()),
    GetPage(name: paymentScreen, page: () => PaymentScreen()),
    GetPage(name: myCalendarScreen, page: () => MyCalendarScreen()),
    GetPage(name: popularTutorScreen, page: () => PopularTutorScreen()),
    GetPage(name: notificationsScreen, page: () => NotificationsScreen()),


    ///===================== Teacher Part================
    GetPage(name: teacherHomeScreen, page: () => TeacherHomeScreen()),
    GetPage(name: teacherProfileSetting, page: () => TeacherProfileSetting()),
    GetPage(name: teacherPersonalInfoScreen, page: () => TeacherPersonalInfoScreen()),
    GetPage(name: editTeacherPersonalInfoScreen, page: () => EditTeacherPersonalInfoScreen()),
    GetPage(name: teacherAvailabilityScreen, page: () => TeacherAvailabilityScreen()),
    GetPage(name: teacherDocumentsScreen, page: () => TeacherDocumentsScreen()),
    GetPage(name: teacherSettingScreen, page: () => TeacherSettingScreen()),
    GetPage(name: teacherChangePasswordScreen, page: () => TeacherChangePasswordScreen()),
    GetPage(name: teacherChangeLanguage, page: () => TeacherChangeLanguage()),
    GetPage(name: teacherHelpCenterScreen, page: () => TeacherHelpCenterScreen()),
    GetPage(name: teacherPrivacyPolicyScreen, page: () => TeacherPrivacyPolicyScreen()),
    GetPage(name: teacherTermsConditionsScreen, page: () => TeacherTermsConditionsScreen()),
    GetPage(name: teacherWalletScreen, page: () => TeacherWalletScreen()),
    GetPage(name: teacherScheduleScreen, page: () => TeacherScheduleScreen()),
    GetPage(name: teacherVerifyScreen, page: () => TeacherVerifyScreen()),
    GetPage(name: teacherProfileSetupScreen, page: () => TeacherProfileSetupScreen()),


  ];
}
*/
