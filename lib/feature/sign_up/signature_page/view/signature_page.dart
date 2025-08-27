// import 'dart:typed_data';

// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/signature_page/bloc/signature_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/signature_page/bloc/signature_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/signature_page/bloc/signature_state.dart'
//     as sig;
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:signature/signature.dart';

// class SignaturePage extends StatefulWidget {
//   final XFile? photo;
//   final Uint8List? existingSig;

//   const SignaturePage({super.key, this.photo, this.existingSig});

//   static Widget builder(BuildContext context) {
//     final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
//     final XFile? photo = args['photo'] as XFile?;
//     final Uint8List? sigOld = args['signature'] as Uint8List?;

//     return BlocProvider(
//       create: (_) => SignatureBloc(),
//       child: SignaturePage(photo: photo, existingSig: sigOld),
//     );
//   }

//   @override
//   State<SignaturePage> createState() => _SignaturePageState();
// }

// class _SignaturePageState extends State<SignaturePage> {
//   late final SignatureController _sigController;

//   @override
//   void initState() {
//     super.initState();
//     _sigController = SignatureController(
//       penStrokeWidth: 2,
//       penColor: Colors.black,
//     );
//     _sigController.addListener(_onSignatureChanged);
//   }

//   void _onSignatureChanged() async {
//     if (_sigController.isNotEmpty) {
//       final bytes = await _sigController.toPngBytes();
//       if (bytes != null) {
//         context.read<SignatureBloc>().add(SignatureDrawn(bytes));
//       }
//     } else {
//       context.read<SignatureBloc>().add(SignatureCleared());
//     }
//   }

//   void _clearSignature() {
//     _sigController.clear();
//     context.read<SignatureBloc>().add(SignatureCleared());
//   }

//   @override
//   void dispose() {
//     _sigController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Signature'),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         foregroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: BlocBuilder<SignatureBloc, sig.SignatureState>(
//           builder: (context, state) {
//             return Column(
//               children: [
//                 const SizedBox(height: 12),
//                 const GlowingStepProgressIndicatorWidget(
//                   currentStep: 6,
//                   totalSteps: 7,
//                   progressColor: ColorConstant.primary,
//                 ),
//                 const SizedBox(height: 24),

//                 /// Terms & Conditions
//                 Padding(
//                   padding: AppStyle.paddingHorizontalLarge,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 160,
//                           alignment: Alignment.center,
//                           child: Text(
//                             'terms and conditions',
//                             style: Theme.of(context).textTheme.bodyMedium
//                                 ?.copyWith(color: Colors.grey),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () => context.read<SignatureBloc>().add(
//                             TermsAgreedToggled(),
//                           ),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 12,
//                             ),
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.vertical(
//                                 bottom: Radius.circular(16),
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 20,
//                                   height: 20,
//                                   decoration: BoxDecoration(
//                                     color: state.agreed
//                                         ? ColorConstant.primary
//                                         : Colors.white,
//                                     border: Border.all(color: Colors.grey),
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: state.agreed
//                                       ? const Icon(
//                                           Icons.check,
//                                           size: 14,
//                                           color: Colors.white,
//                                         )
//                                       : null,
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Text(
//                                     "I agree to Bangladesh Finance Limited’s Terms & Conditions",
//                                     style: Theme.of(
//                                       context,
//                                     ).textTheme.bodyMedium,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 32),
//                 Text(
//                   'Sign your name below',
//                   style: Theme.of(
//                     context,
//                   ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
//                 ),
//                 const SizedBox(height: 12),

//                 /// Signature Pad
//                 Padding(
//                   padding: AppStyle.paddingHorizontalLarge,
//                   child: Container(
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: Colors.grey.shade400),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Signature(
//                         controller: _sigController,
//                         backgroundColor: Colors.transparent,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 /// Upload & Clear
//                 Padding(
//                   padding: AppStyle.paddingHorizontalLarge,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton.icon(
//                         style: TextButton.styleFrom(
//                           foregroundColor: Colors.grey.shade700,
//                         ),
//                         onPressed: () async {
//                           final ImagePicker picker = ImagePicker();
//                           final XFile? file = await picker.pickImage(
//                             source: ImageSource.gallery,
//                           );

//                           if (file != null) {
//                             final Uint8List bytes = await file.readAsBytes();
//                             context.read<SignatureBloc>().add(
//                               SignatureDrawn(bytes),
//                             );
//                           }
//                         },
//                         icon: const Icon(Icons.upload_file),
//                         label: const Text('Upload file from device'),
//                       ),
//                       GestureDetector(
//                         onTap: _clearSignature,
//                         child: Container(
//                           height: 32,
//                           padding: const EdgeInsets.symmetric(horizontal: 14),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade500),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Clear',
//                               style: Theme.of(context).textTheme.bodySmall
//                                   ?.copyWith(fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Spacer(),

//                 /// Continue Button
//                 Padding(
//                   padding: AppStyle.paddingAllMedium,
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: state.canContinue
//                             ? ColorConstant.primary
//                             : Colors.grey,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       onPressed: state.canContinue
//                           ? () => NavigatorUtil.pushNamed(
//                               AppRoute.uploadStatus,
//                               arguments: {
//                                 'photo': widget.photo,
//                                 'signature': state.signatureBytes,
//                               },
//                             )
//                           : null,
//                       child: Text(
//                         'Continue',
//                         style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                           color: ColorConstant.foreground,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/service/photo_report_service.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/signature_page/bloc/signature_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/signature_page/bloc/signature_event.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/signature_page/bloc/signature_state.dart'
    as sig;
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';

class SignaturePage extends StatefulWidget {
  final XFile? photo;
  final Uint8List? existingSig;

  const SignaturePage({super.key, this.photo, this.existingSig});

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final XFile? photo = args['photo'] as XFile?;
    final Uint8List? sigOld = args['signature'] as Uint8List?;

    return BlocProvider(
      create: (_) => SignatureBloc(),
      child: SignaturePage(photo: photo, existingSig: sigOld),
    );
  }

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  late final SignatureController _sigController;

  @override
  void initState() {
    super.initState();
    _sigController = SignatureController(penStrokeWidth: 2, penColor: Colors.black);
    _sigController.addListener(_onSignatureChanged);
  }

  void _onSignatureChanged() async {
    if (_sigController.isNotEmpty) {
      final bytes = await _sigController.toPngBytes();
      if (bytes != null) {
        context.read<SignatureBloc>().add(SignatureDrawn(bytes));
      }
    } else {
      context.read<SignatureBloc>().add(SignatureCleared());
    }
  }

  void _clearSignature() {
    _sigController.clear();
    context.read<SignatureBloc>().add(SignatureCleared());
  }

  @override
  void dispose() {
    _sigController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature'),
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
        child: BlocBuilder<SignatureBloc, sig.SignatureState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 12),
                const GlowingStepProgressIndicatorWidget(
                  currentStep: 6,
                  totalSteps: 7,
                  progressColor: ColorConstant.primary,
                ),
                const SizedBox(height: 24),

                /// Terms & Conditions
                _buildTermsCard(context, state),

                const SizedBox(height: 32),
                Text(
                  'Sign your name below',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 12),

                /// Signature Pad
                _buildSignaturePad(),

                const SizedBox(height: 24),

                /// Upload & Clear
                _buildUploadAndClearRow(context),

                const Spacer(),

                /// Continue Button
                _buildContinueButton(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTermsCard(BuildContext context, sig.SignatureState state) {
    return Padding(
      padding: AppStyle.paddingHorizontalLarge,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              height: 160,
              alignment: Alignment.center,
              child: Text(
                'terms and conditions',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ),
            InkWell(
              onTap: () => context.read<SignatureBloc>().add(TermsAgreedToggled()),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: state.agreed ? ColorConstant.primary : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: state.agreed
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "I agree to Bangladesh Finance Limited’s Terms & Conditions",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignaturePad() {
    return Padding(
      padding: AppStyle.paddingHorizontalLarge,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Signature(controller: _sigController, backgroundColor: Colors.transparent),
        ),
      ),
    );
  }

  Widget _buildUploadAndClearRow(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingHorizontalLarge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.grey.shade700),
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? file = await picker.pickImage(source: ImageSource.gallery);
              if (file != null) {
                final Uint8List bytes = await file.readAsBytes();
                context.read<SignatureBloc>().add(SignatureDrawn(bytes));
              }
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload file from device'),
          ),
          GestureDetector(
            onTap: _clearSignature,
            child: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Clear',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context, sig.SignatureState state) {
    return Padding(
      padding: AppStyle.paddingAllMedium,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: state.canContinue ? ColorConstant.primary : Colors.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: state.canContinue
              ? () async {
                  final trackingNo = SignupState().photoId;
                  if (trackingNo != null && state.signatureBytes != null) {
                    try {
                      // Save Uint8List as File temporarily
                      final tempDir = await getTemporaryDirectory();
                      final tempFile = File('${tempDir.path}/signature.png');
                      await tempFile.writeAsBytes(state.signatureBytes!);

                      await PhotoReportService.updateUserPhoto(
                        trackingNo: trackingNo,
                        userSign: tempFile,
                      );

                      debugPrint("✅ Signature uploaded successfully");
                    } catch (e) {
                      debugPrint("❌ Signature upload failed: $e");
                    }
                  }
                  NavigatorUtil.pushNamed(
                    AppRoute.uploadStatus,
                    arguments: {
                      'photo': widget.photo,
                      'signature': state.signatureBytes,
                    },
                  );
                }
              : null,
          child: Text(
            'Continue',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorConstant.foreground),
          ),
        ),
      ),
    );
  }
}
