// import 'package:bangladesh_finance_ekyc/feature/home/fixed_deposit/view/fixed_deposit_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/home_page/view/home_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/monthly_deposit/view/monthly_deposit_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/login/view/login_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/view/additional_info_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/camera_capture/view/camera_capture_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/final_review/view/FinalReviewPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/liveliness_check_page/view/LivelinessCheckPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/view/mobile_no_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nid_scan/view/nid_scan_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nominee_info/view/nominee_info_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/otp-verification/view/verify_otp_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_capture/view/photo_capture_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_preview_page/view/PhotoPreviewPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/registration_success/view/RegistrationSuccessPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/view/scanned_data_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/set_password/view/SetPasswordPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/signature_page/view/signature_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/upload_status/view/UploadStatusPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/start_up/intro/view/intro_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/start_up/splash/view/splash_page.dart';
// import 'package:flutter/material.dart';

// class AppRoute {
//   // initial
//   static const String initial = '/initial';

//   // intro
//   static const String splash = '/splash';
//   static const String intro = '/intro';

//   // login
//   static const String login = '/login';

//   // registration
//   static const String mobileNo = '/mobile_no';
//   static const String verifyOtp = '/otp-verification';
//   static const String nidScan = '/nid-scan';
//   static const String cameraCapture = '/camera-capture';
//   static const String additionalInfo = '/additional-info';
//   static const String nomineeInfo = '/nominee-info';
//   static const String scannedData = '/scanned-data';
//   static const String photoCapture = '/photo-capture';
//   static const String faceLivelinessCheck = '/face-liveliness-check';
//   static const String photoPreview = '/photo-preview';
//   static const String signature = '/signature';
//   static const String uploadStatus = '/upload-status';
//   static const String finalReview = '/final-review';
//   static const String setPassword = '/set-password';
//   static const String registrationSuccess = '/registration-success';

//   // home
//   static const String home = '/home';
//   static const String fixedDeposit = '/fixed-deposit';
//   static const String monthlyDeposit = '/monthly-deposit';

//   static Map<String, WidgetBuilder> get routes => {
//     // initial
//     initial: SplashPage.builder,

//     // intro
//     splash: SplashPage.builder,
//     intro: IntroPage.builder,

//     // login
//     login: LoginPage.builder,

//     // registration
//     mobileNo: MobileNoPage.builder,
//     verifyOtp: VerifyOtpPage.builder,
//     nidScan: NidScanPage.builder,
//     cameraCapture: CameraCapturePage.builder,
//     scannedData: ScannedDataPage.builder,
//     additionalInfo: AdditionalInfoPage.builder,
//     nomineeInfo: NomineeInfoPage.builder,
//     // photo capture
//     photoCapture: PhotoCapturePage.builder,
//     // face liveliness check
//     faceLivelinessCheck: FaceLivelinessCheckView.builder,
//     // photo preview
//     photoPreview: PhotoPreviewPage.builder,
//     // signature
//     signature: SignaturePage.builder,
//     // upload status
//     uploadStatus: UploadStatusPage.builder,
//     // final review
//     finalReview: FinalReviewPage.builder,
//     // set password
//     setPassword: SetPasswordPage.builder,
//     // registration success
//     registrationSuccess: RegistrationSuccessPage.builder,
//     // home
//     home: HomePage.builder,
//     fixedDeposit: FixedDepositPage.builder,
//     monthlyDeposit: MonthlyDepositPage.builder,
//   };
// }
// import 'package:bangladesh_finance_ekyc/feature/home/category_selection/view/category_selection_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/home/home_page/view/home_page.dart';

// import 'package:bangladesh_finance_ekyc/feature/login/view/login_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/product_detail/view/product_detail_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/view/additional_info_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/camera_capture/view/camera_capture_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/final_review/view/FinalReviewPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/liveliness_check_page/view/LivelinessCheckPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/view/mobile_no_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nid_scan/view/nid_scan_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nominee_info/view/nominee_info_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/otp-verification/view/verify_otp_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_capture/view/photo_capture_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_preview_page/view/PhotoPreviewPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/registration_success/view/RegistrationSuccessPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/view/scanned_data_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/set_password/view/SetPasswordPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/signature_page/view/signature_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/upload_status/view/UploadStatusPage.dart';
// import 'package:bangladesh_finance_ekyc/feature/start_up/intro/view/intro_page.dart';
// import 'package:bangladesh_finance_ekyc/feature/start_up/splash/view/splash_page.dart';
// import 'package:bangladesh_finance_ekyc/model/product_model.dart';
// import 'package:flutter/material.dart';

// class AppRoute {
//   // Initial
//   static const String initial = '/initial';

//   // Intro
//   static const String splash = '/splash';
//   static const String intro = '/intro';

//   // Login
//   static const String login = '/login';

//   // Registration
//   static const String mobileNo = '/mobile_no';
//   static const String verifyOtp = '/otp-verification';
//   static const String nidScan = '/nid-scan';
//   static const String cameraCapture = '/camera-capture';
//   static const String additionalInfo = '/additional-info';
//   static const String nomineeInfo = '/nominee-info';
//   static const String scannedData = '/scanned-data';
//   static const String photoCapture = '/photo-capture';
//   static const String faceLivelinessCheck = '/face-liveliness-check';
//   static const String photoPreview = '/photo-preview';
//   static const String signature = '/signature';
//   static const String uploadStatus = '/upload-status';
//   static const String finalReview = '/final-review';
//   static const String setPassword = '/set-password';
//   static const String registrationSuccess = '/registration-success';

//   // Home
//   static const String home = '/home';
//   static const String fixedDeposit = '/fixed-deposit';
//   static const String monthlyDeposit = '/monthly-deposit';

//   // Dynamic Routes
//   static const String categorySelection = '/category-selection';
//   static const String productDetail = '/product-detail';
//   static const String productList = '/product-list'; // reserved for next step

//   // Static routes (no arguments required)
//   static Map<String, WidgetBuilder> get routes => {
//         // Initial
//         initial: SplashPage.builder,

//         // Intro
//         splash: SplashPage.builder,
//         intro: IntroPage.builder,

//         // Login
//         login: LoginPage.builder,

//         // Registration
//         mobileNo: MobileNoPage.builder,
//         verifyOtp: VerifyOtpPage.builder,
//         nidScan: NidScanPage.builder,
//         cameraCapture: CameraCapturePage.builder,
//         scannedData: ScannedDataPage.builder,
//         additionalInfo: AdditionalInfoPage.builder,
//         nomineeInfo: NomineeInfoPage.builder,
//         photoCapture: PhotoCapturePage.builder,
//         faceLivelinessCheck: FaceLivelinessCheckView.builder,
//         photoPreview: PhotoPreviewPage.builder,
//         signature: SignaturePage.builder,
//         uploadStatus: UploadStatusPage.builder,
//         finalReview: FinalReviewPage.builder,
//         setPassword: SetPasswordPage.builder,
//         registrationSuccess: RegistrationSuccessPage.builder,

//         // Home
//         home: HomePage.builder,

//       };

//   // Dynamic routes (require arguments)
//   static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case categorySelection:
//         final categoryType = settings.arguments as String;
//         return MaterialPageRoute(
//           builder: (context) => CategorySelectionPage.builder(context, categoryType),
//         );

//       case productDetail:
//         final product = settings.arguments as ProductModel;
//         return MaterialPageRoute(
//           builder: (context) => ProductDetailPage.builder(context, product),
//         );

//       default:
//         return _errorRoute("Route not found: ${settings.name}");
//     }
//   }

//   static Route<dynamic> _errorRoute(String message) {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(title: const Text('Error')),
//         body: Center(child: Text(message)),
//       ),
//     );
//   }
// }

import 'package:bangladesh_finance_ekyc/feature/home/category_selection/view/category_selection_page.dart';
import 'package:bangladesh_finance_ekyc/feature/home/home_page/view/home_page.dart';
import 'package:bangladesh_finance_ekyc/feature/home/product_list/view/product_list_page.dart'
    hide HomePage;
import 'package:bangladesh_finance_ekyc/feature/login/view/login_page.dart';
import 'package:bangladesh_finance_ekyc/feature/product_detail/view/product_detail_page.dart'
    hide HomePage;
import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/view/additional_info_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/camera_capture/view/camera_capture_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/final_review/view/FinalReviewPage.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/liveliness_check_page/view/LivelinessCheckPage.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/view/mobile_no_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/nid_scan/view/nid_scan_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/nominee_info/view/nominee_info_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/otp-verification/view/verify_otp_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_capture/view/photo_capture_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_preview_page/view/PhotoPreviewPage.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/registration_success/view/RegistrationSuccessPage.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/view/scanned_data_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/set_password/view/SetPasswordPage.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/signature_page/view/signature_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/upload_status/view/UploadStatusPage.dart';
import 'package:bangladesh_finance_ekyc/feature/start_up/intro/view/intro_page.dart';
import 'package:bangladesh_finance_ekyc/feature/start_up/splash/view/splash_page.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';
import 'package:flutter/material.dart';

class AppRoute {
  // Initial
  static const String initial = '/initial';

  // Intro
  static const String splash = '/splash';
  static const String intro = '/intro';

  // Login
  static const String login = '/login';

  // Registration
  static const String mobileNo = '/mobile_no';
  static const String verifyOtp = '/otp-verification';
  static const String nidScan = '/nid-scan';
  static const String cameraCapture = '/camera-capture';
  static const String additionalInfo = '/additional-info';
  static const String nomineeInfo = '/nominee-info';
  static const String scannedData = '/scanned-data';
  static const String photoCapture = '/photo-capture';
  static const String faceLivelinessCheck = '/face-liveliness-check';
  static const String photoPreview = '/photo-preview';
  static const String signature = '/signature';
  static const String uploadStatus = '/upload-status';
  static const String finalReview = '/final-review';
  static const String setPassword = '/set-password';
  static const String registrationSuccess = '/registration-success';

  // Home & Product
  static const String home = '/home';
  static const String fixedDeposit = '/fixed-deposit';
  static const String monthlyDeposit = '/monthly-deposit';
  static const String categorySelection = '/category-selection';
  static const String productDetail = '/product-detail';
  static const String productList = '/product-list';

  // Static routes (no arguments required)
  static Map<String, WidgetBuilder> get routes => {
    // Intro
    initial: SplashPage.builder,
    splash: SplashPage.builder,
    intro: IntroPage.builder,

    // Login
    login: LoginPage.builder,

    // Registration
    mobileNo: MobileNoPage.builder,
    verifyOtp: VerifyOtpPage.builder,
    nidScan: NidScanPage.builder,
    cameraCapture: CameraCapturePage.builder,
    scannedData: ScannedDataPage.builder,
    additionalInfo: AdditionalInfoPage.builder,
    nomineeInfo: NomineeInfoPage.builder,
    photoCapture: PhotoCapturePage.builder,
    faceLivelinessCheck: FaceLivelinessCheckView.builder,
    photoPreview: PhotoPreviewPage.builder,
    signature: SignaturePage.builder,
    uploadStatus: UploadStatusPage.builder,
    finalReview: FinalReviewPage.builder,
    setPassword: SetPasswordPage.builder,
    registrationSuccess: RegistrationSuccessPage.builder,

    // Home
    home: HomePage.builder,
  };

  // Dynamic routes (require arguments)
  // static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case categorySelection:
  //       final categoryType = settings.arguments as String;
  //       return MaterialPageRoute(
  //         builder: (context) =>
  //             CategorySelectionPage.builder(context, categoryType),
  //       );

  //     case productDetail:
  //       final product = settings.arguments as ProductModel;
  //       return MaterialPageRoute(
  //         builder: (context) => ProductDetailPage.builder(context, product),
  //       );

  //     case productList:
  //       final args = settings.arguments as Map<String, String>;
  //       final serviceTypeId = args['serviceTypeId']!;
  //       final productTypeId = int.parse(args['productTypeId']!);
  //       return MaterialPageRoute(
  //         builder: (context) => ProductListPage.builder(
  //           context,
  //           serviceTypeId: serviceTypeId,
  //           productTypeId: productTypeId,
  //         ),
  //       );

  //     default:
  //       return _errorRoute("Route not found: ${settings.name}");
  //   }
  // }

  // static Route<dynamic> _errorRoute(String message) {
  //   return MaterialPageRoute(
  //     builder: (_) => Scaffold(
  //       appBar: AppBar(title: const Text('Error')),
  //       body: Center(child: Text(message)),
  //     ),
  //   );
  // }
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case categorySelection:
        final categoryType = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) =>
              CategorySelectionPage.builder(context, categoryType),
        );

      case productDetail:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (context) => ProductDetailPage.builder(context, product),
        );

      case productList:
        // ✅ No need to extract arguments, values are stored in ProductSelectionState
        return MaterialPageRoute(
          builder: (context) => ProductListPage.builder(context),
        );

      default:
        return _errorRoute("Route not found: ${settings.name}");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}
