import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_capture/bloc/photo_capture_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_capture/bloc/photo_capture_event.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoCapturePage extends StatelessWidget {
  const PhotoCapturePage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => PhotoCaptureBloc(),
      child: const PhotoCapturePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final instructions = [
      'Remove your eye glass (if have any).',
      'Place your face in photo frame.',
      'Make sure there is enough light around.',
      'Do not shake your face when capturing photo.',
      'Blink your eyes several times to capture photo.',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo"),
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
              currentStep: 5,
              totalSteps: 7,
              progressColor: ColorConstant.primary,
            ),
            const SizedBox(height: 24),

            /// Avatar with circular blue border
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstant.primary,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 32),

            /// Instructions
            Padding(
              padding: AppStyle.paddingHorizontalLarge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(instructions.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey.shade300,
                          child: Text(
                            '${index + 1}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            instructions[index],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            const Spacer(),

            /// Take Photo button
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
                  onPressed: () async {
                    // Dispatch event for tracking
                    context.read<PhotoCaptureBloc>().add(MarkInstructionsAcknowledged());

                    // Navigate to liveliness check page
                    await NavigatorUtil.pushNamed(AppRoute.faceLivelinessCheck);
                  },
                  child: Text(
                    'Take Photo',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: ColorConstant.foreground),
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
// import 'dart:io';

// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_capture/bloc/photo_capture_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/photo_capture/bloc/photo_capture_event.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PhotoCapturePage extends StatelessWidget {
//   final File nidFrontImage;
//   final File nidBackImage;

//   const PhotoCapturePage({
//     super.key,
//     required this.nidFrontImage,
//     required this.nidBackImage,
//   });

//   static Widget builder(BuildContext context) {
//     final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     return BlocProvider(
//       create: (_) => PhotoCaptureBloc(),
//       child: PhotoCapturePage(
//         nidFrontImage: args['nidFrontImage'] as File,
//         nidBackImage: args['nidBackImage'] as File,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final instructions = [
//       'Remove your eye glass (if have any).',
//       'Place your face in photo frame.',
//       'Make sure there is enough light around.',
//       'Do not shake your face when capturing photo.',
//       'Blink your eyes several times to capture photo.',
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Photo"),
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
//         child: Column(
//           children: [
//             const SizedBox(height: 12),
//             const GlowingStepProgressIndicatorWidget(
//               currentStep: 5,
//               totalSteps: 7,
//               progressColor: ColorConstant.primary,
//             ),
//             const SizedBox(height: 24),

//             /// Avatar with circular blue border
//             Center(
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: ColorConstant.primary,
//                     width: 2,
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.person,
//                   size: 64,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),

//             /// Instructions
//             Padding(
//               padding: AppStyle.paddingHorizontalLarge,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: List.generate(instructions.length, (index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           radius: 12,
//                           backgroundColor: Colors.grey.shade300,
//                           child: Text(
//                             '${index + 1}',
//                             style: Theme.of(context).textTheme.bodySmall,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             instructions[index],
//                             style: Theme.of(context).textTheme.bodyMedium,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             ),

//             const Spacer(),

//             /// Take Photo button
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
//                   onPressed: () async {
//                     // Dispatch event for tracking
//                     context.read<PhotoCaptureBloc>().add(MarkInstructionsAcknowledged());

//                     // Navigate to liveliness check page with NID images
//                     await NavigatorUtil.pushNamed(
//                       AppRoute.faceLivelinessCheck,
//                       arguments: {
//                         'nidFrontImage': nidFrontImage,
//                         'nidBackImage': nidBackImage,
//                       },
//                     );
//                   },
//                   child: Text(
//                     'Take Photo',
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
