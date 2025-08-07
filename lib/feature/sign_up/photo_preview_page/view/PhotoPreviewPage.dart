// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';

// class PhotoPreviewPage extends StatelessWidget {
//   final XFile? captured;

//   const PhotoPreviewPage({super.key, this.captured});

//   static Widget builder(BuildContext context) {
//     final args = ModalRoute.of(context)?.settings.arguments;
//     final XFile? captured = args is XFile ? args : null;
//     return PhotoPreviewPage(captured: captured);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Photo Preview"),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         foregroundColor: Colors.black,
//         leading: const BackButton(),
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
//             const SizedBox(height: 24),

//             /// Square photo preview with border
//             Center(
//               child: Container(
//                 width: 240,
//                 height: 320,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: ColorConstant.primary,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.grey.shade200,
//                 ),
//                 child: const Icon(
//                   Icons.account_box,
//                   size: 120,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             /// Instruction text
//             Padding(
//               padding: AppStyle.paddingHorizontalLarge,
//               child: Text(
//                 "Make sure your captured photo is clear and your face is visible.",
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(fontWeight: FontWeight.w500),
//                 textAlign: TextAlign.center,
//               ),
//             ),

//             const Spacer(),

//             /// Continue button
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
//                     NavigatorUtil.pushNamed(
//                         AppRoute.signature);
//                   },
//                   child: Text(
//                     'Continue',
//                     style: Theme.of(context)
//                         .textTheme
//                         .labelLarge
//                         ?.copyWith(color: ColorConstant.foreground),
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

import 'dart:io';

import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_preview_page/bloc/photo_preview_event.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_preview_page/bloc/photo_preview_bloc.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PhotoPreviewPage extends StatelessWidget {
  final XFile? captured;

  const PhotoPreviewPage({super.key, this.captured});

  static Widget builder(BuildContext context) {
  final args = ModalRoute.of(context)?.settings.arguments;
  final XFile? captured = args is XFile ? args : null;

  return BlocProvider(
    create: (_) => PhotoPreviewBloc()..add(LoadCapturedPhoto(captured!)),
    child: PhotoPreviewPage(captured: captured),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Preview"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        leading: const BackButton(),
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
            const SizedBox(height: 24),

            /// Captured photo preview with border
            Center(
              child: Container(
                width: 240,
                height: 320,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstant.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: captured != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(
                          File(captured!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.account_box,
                        size: 120,
                        color: Colors.grey,
                      ),
              ),
            ),

            const SizedBox(height: 32),

            /// Instruction text
            Padding(
              padding: AppStyle.paddingHorizontalLarge,
              child: Text(
                "Make sure your captured photo is clear and your face is visible.",

                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),

            const Spacer(),

            /// Continue button
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
                  onPressed: () {
                    // NavigatorUtil.pushNamed(
                    //   AppRoute.signature,
                    //   arguments: captured,
                    // );
                    NavigatorUtil.pushNamed(
                      AppRoute.signature,
                      arguments: {
                        'photo': captured, // keep whatever was already there
                        'signature': null, // we don’t have a signature yet
                      },
                    );
                  },
                  child: Text(
                    'Continue',
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
