import 'package:bangladesh_finance_ekyc/feature/home/category_selection/view/category_selection_page.dart';
// Home & Product
import 'package:bangladesh_finance_ekyc/feature/home/home_page/view/home_page.dart';
// NEW: Product Apply page (amount/tenure)
import 'package:bangladesh_finance_ekyc/feature/home/product_apply/view/product_apply_page.dart';
import 'package:bangladesh_finance_ekyc/feature/home/product_list/view/product_list_page.dart' hide HomePage;
import 'package:bangladesh_finance_ekyc/feature/login/view/login_page.dart';
import 'package:bangladesh_finance_ekyc/feature/product_detail/view/product_detail_page.dart' hide HomePage;
import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/view/additional_info_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/camera_capture/view/camera_capture_page.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/final_review/view/FinalReviewPage.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/liveliness_check_page/view/LivelinessCheckPage.dart';
// Registration flow
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
// Start-up
import 'package:bangladesh_finance_ekyc/feature/start_up/splash/view/splash_page.dart';
import 'package:bangladesh_finance_ekyc/model/product_model.dart';
import 'package:flutter/material.dart';

class AppRoute {
  // Initial / Start-up
  static const String initial = '/initial';
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

  // NEW: Product Apply (amount/tenure) – no args
  static const String productApply = '/product-apply';

  // ---------- Static routes (no arguments) ----------
  static Map<String, WidgetBuilder> get routes => {
        // Start-up
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

        // Home (no args)
        home: HomePage.builder,

        // NEW: Product Apply (no args)
        productApply: ProductApplyPage.builder,
      };

  // ---------- Dynamic routes (require arguments) ----------
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
        // Values are already cached inside ProductSelectionState
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
