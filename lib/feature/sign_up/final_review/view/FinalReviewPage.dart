// import 'dart:typed_data';
// import 'dart:io';

// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';

// class FinalReviewPage extends StatelessWidget {
//   final Uint8List? signatureBytes;
//   final XFile? photo;

//   const FinalReviewPage({
//     super.key,
//     this.signatureBytes,
//     this.photo,
//   });

//   static Widget builder(BuildContext context) {
//     final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
//     final XFile? photo = args['photo'] as XFile?;
//     final Uint8List? signatureBytes = args['signature'] as Uint8List?;
//     return FinalReviewPage(signatureBytes: signatureBytes, photo: photo);
//   }

//   Widget sectionTitle(String title) {
//     return Container(
//       width: double.infinity,
//       color: Colors.grey.shade200,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Text(
//         title,
//         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//       ),
//     );
//   }

//   Widget infoRow(String title, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 14,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Final Review"),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         foregroundColor: Colors.black,
//         // leading: const BackButton(),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new), // Back arrow icon
//           onPressed: () => Navigator.of(context).pop(), // Go back on tap
//         ),
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 12),
//             const GlowingStepProgressIndicatorWidget(
//               currentStep: 6,
//               totalSteps: 7,
//               progressColor: ColorConstant.primary,
//             ),
//             const SizedBox(height: 12),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// Photo and personal header
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Actual Photo or placeholder
//                           Container(
//                             width: 100,
//                             height: 120,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: photo != null
//                                 ? Image.file(
//                                     File(photo!.path),
//                                     fit: BoxFit.cover,
//                                   )
//                                 : const Icon(
//                                     Icons.person,
//                                     size: 40,
//                                     color: Colors.grey,
//                                   ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 Text(
//                                   "Name",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Mashrafe Bin Mortaza",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   "Father’s Name",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Rahim Uddin",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   "Mother’s Name",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Lipi Begum",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     /// Personal Details Section
//                     sectionTitle("Personal Details"),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           infoRow("Gender", "Male"),
//                           infoRow("Mobile Number", "01855556252"),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           infoRow("Occupation", "Service"),
//                           infoRow("NID Number", "012345678912"),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     /// Address Section
//                     sectionTitle("Address"),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Boalia, Adda, Barura, Cumilla",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),

//                     /// Signature Section
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Signature",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                           Container(
//                             width: 120,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade100,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: signatureBytes != null
//                                 ? Image.memory(
//                                     signatureBytes!,
//                                     fit: BoxFit.contain,
//                                   )
//                                 : const Icon(Icons.draw_outlined, size: 32),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),

//             /// Continue Button
//             Padding(
//               padding: AppStyle.paddingAllMedium,
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorConstant.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   onPressed: () {
//                     // TODO: Final submission logic here
//                     NavigatorUtil.pushNamed(AppRoute.setPassword);
//                   },
//                   child: Text(
//                     'Continue',
//                     style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                       color: ColorConstant.foreground,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:typed_data';
import 'dart:io';

import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';

// Singletons
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';

// Submit service
import 'package:bangladesh_finance_ekyc/core/service/submission_service.dart';

class FinalReviewPage extends StatefulWidget {
  final Uint8List? signatureBytes;
  final XFile? photo;

  const FinalReviewPage({
    super.key,
    this.signatureBytes,
    this.photo,
  });

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final XFile? photo = args['photo'] as XFile?;
    final Uint8List? signatureBytes = args['signature'] as Uint8List?;
    return FinalReviewPage(signatureBytes: signatureBytes, photo: photo);
  }

  @override
  State<FinalReviewPage> createState() => _FinalReviewPageState();
}

class _FinalReviewPageState extends State<FinalReviewPage> {
  bool _isSubmitting = false;

  String _s(Map<String, dynamic> m, String key) => (m[key]?.toString() ?? '—');

  Future<void> _submit() async {
    final signup = SignupState();
    final product = ProductSelectionState();
    final payload = signup.toFinalSubmission();

    debugPrint('🧾 Final submit payload: $payload');

    setState(() => _isSubmitting = true);
    try {
      await SubmissionService.submitFinalApplication(payload);

      // Cleanup after success
      signup.reset();
      product.reset();

      if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoute.registrationSuccess,
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission failed: $e')),
      );
    }
  }

  Widget sectionTitle(String title) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final signup = SignupState();
    final product = signup.productSnapshot; // frozen at MobileNo step

    final serviceTypeId = product['serviceTypeId']?.toString();
    final productTypeId = product['productTypeId'] is int
        ? product['productTypeId'] as int
        : int.tryParse(product['productTypeId']?.toString() ?? '');
    final schemeId = product['schemeId'] is int
        ? product['schemeId'] as int
        : int.tryParse(product['schemeId']?.toString() ?? '');

    final serviceTypeLabel = (serviceTypeId == 'I') ? 'Islamic' : 'Conventional';
    final productTypeLabel = (productTypeId == 1) ? 'Fixed Deposit' : 'Monthly Deposit';
    final schemeLabel = (productTypeId == 2)
        ? (schemeId == 2 ? 'On time' : (schemeId == 1 ? 'On installment' : '—'))
        : '—';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Final Review"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const GlowingStepProgressIndicatorWidget(
              currentStep: 6,
              totalSteps: 7,
              progressColor: ColorConstant.primary,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Photo and simple header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Actual Photo or placeholder
                          Container(
                            width: 100,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: widget.photo != null
                                ? Image.file(
                                    File(widget.photo!.path),
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    )),
                                Text("—",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 8),
                                Text("Father’s Name",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    )),
                                Text("—",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    )),
                                SizedBox(height: 8),
                                Text("Mother’s Name",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    )),
                                Text("—",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Product Details
                    sectionTitle("Product Details"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoRow("Category", serviceTypeLabel),
                              infoRow("Product Type", productTypeLabel),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoRow("Product Name", _s(product, 'productName')),
                              infoRow("Product Code", _s(product, 'productCode')),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoRow("Scheme", schemeLabel),
                              infoRow("Tenure (months)", _s(product, 'tenureMonths')),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoRow("Amount Type", _s(product, 'amountType')),
                              infoRow("Amount", _s(product, 'amount')),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoRow("Branch", _s(product, 'branchName')),
                              infoRow("Branch ID", _s(product, 'branchId')),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoRow("District ID", _s(product, 'districtId')),
                              infoRow("Service Type ID", _s(product, 'serviceTypeId')),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Signup Workflow IDs (from SignupState)
                    sectionTitle("Application IDs"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoRow("NID ID", (signup.nidId?.toString() ?? '—')),
                              infoRow("Photo ID", (signup.photoId?.toString() ?? '—')),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoRow("Additional Info ID", (signup.additionalInfoId?.toString() ?? '—')),
                              infoRow("Nominee ID", (signup.nomineeId?.toString() ?? '—')),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoRow("OTP ID", (signup.otpId?.toString() ?? '—')),
                              infoRow("Password Set", 'N/A'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// Address (placeholder, wire up your data if available)
                    const SizedBox(height: 16),
                    sectionTitle("Address"),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "—",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    /// Signature
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Signature", style: TextStyle(color: Colors.grey)),
                          Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: widget.signatureBytes != null
                                ? Image.memory(widget.signatureBytes!, fit: BoxFit.contain)
                                : const Icon(Icons.draw_outlined, size: 32),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            /// Submit Button
            Padding(
              padding: AppStyle.paddingAllMedium,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          'Submit Application',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: ColorConstant.foreground,
                              ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
