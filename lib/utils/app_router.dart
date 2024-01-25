import 'package:drivn_customer/google_places/location_search_screen.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:drivn_customer/views/main_screens/drivers.dart';

class AppRouter {
  static const String initialRoute = "/";
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String getVerified = "/getVerified";
  static const String splash = "/splash";
  static const String otp = "/otp";
  static const String identityDocs = "/identityDocs";
  static const String proofId = "/proofId";
  static const String uploadlicense = "/uploadLicense";
  static const String onboard = "/onboard";
  static const String getStarted = "/getStarted";
  static const String forgotPwd = "/forgotPwd";
  static const String resetPwd = "/resetPwd";
  static const String index = "/index";
  static const String cDetail = "/cDetail";
  static const String cBrand = "/cBrand";
  static const String date = "/date";
  static const String overview = "/overview";
  static const String driver = "/driver";
  static const String places = "/places";

  static List<GetPage> routes = [
    GetPage(name: login, page: () => const LogInView()),
    GetPage(name: getVerified, page: () => const VerifyUserView()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signUp, page: () => const SignUpView()),
    GetPage(name: otp, page: () => const VerificationPage()),
    GetPage(name: identityDocs, page: () => const IdentityDocsView()),
    GetPage(name: proofId, page: () => const ProofOfIdView()),
    GetPage(name: uploadlicense, page: () => const UploadLicenceView()),
    GetPage(name: onboard, page: () => const OnbordingPage()),
    GetPage(name: getStarted, page: () => const GetStartedView()),
    GetPage(name: forgotPwd, page: () => const ForgotPasswordView()),
    GetPage(name: resetPwd, page: () => const ResetPasswordView()),
    GetPage(name: index, page: () => const MainPage()),
    GetPage(name: cBrand, page: () => const CarBrandSearch()),
    // GetPage(name: date, page: () =>  const DateAndTime()),
    GetPage(name: driver, page: () => const DriverScreen()),
    GetPage(name: places, page: () => const SearchLocationScreen()),
  ];
}
