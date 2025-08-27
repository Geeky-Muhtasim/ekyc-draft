// import 'dart:io';
// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/route/app_route.dart';
// import '../bloc/face_liveliness_bloc.dart';
// import '../bloc/face_liveliness_event.dart';
// import '../bloc/face_liveliness_state.dart';

// class FaceLivelinessCheckView extends StatefulWidget {
//   const FaceLivelinessCheckView({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider(
//       create: (_) => FaceLivelinessBloc()..add(InitializeCamera()),
//       child: const FaceLivelinessCheckView(),
//     );
//   }

//   @override
//   State<FaceLivelinessCheckView> createState() => _FaceLivelinessCheckViewState();
// }

// class _FaceLivelinessCheckViewState extends State<FaceLivelinessCheckView> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<FaceLivelinessBloc, FaceLivelinessState>(
//       listener: (context, state) {
//         if (state.photoCaptured && state.capturedPhoto != null) {
//           NavigatorUtil.pushNamed(AppRoute.photoPreview, arguments: state.capturedPhoto);
//         }
//       },
//       builder: (context, state) {
//         final bloc = context.read<FaceLivelinessBloc>();

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("Liveliness Check"),
//             centerTitle: true,
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             foregroundColor: Colors.black,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             elevation: 0,
//           ),
//           body: SafeArea(
//             child: Column(
//               children: [
//                 const SizedBox(height: 12),
//                 const GlowingStepProgressIndicatorWidget(
//                   currentStep: 6,
//                   totalSteps: 7,
//                   progressColor: ColorConstant.primary,
//                 ),
//                 const SizedBox(height: 20),
//                 if (!state.isCameraInitialized || bloc.cameraController == null)
//                   const CircularProgressIndicator()
//                 else if (!state.photoCaptured)
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SizedBox(
//                         width: 260,
//                         height: 260,
//                         child: ClipOval(child: CameraPreview(bloc.cameraController!)),
//                       ),
//                       SizedBox(
//                         width: 260,
//                         height: 260,
//                         child: CustomPaint(painter: _CircleBorderPainter()),
//                       ),
//                       if (state.isCountingDown)
//                         Positioned(
//                           child: Text(
//                             '${state.countdown}',
//                             style: const TextStyle(
//                               fontSize: 48,
//                               fontWeight: FontWeight.bold,
//                               color: ColorConstant.primary,
//                             ),
//                           ),
//                         ),
//                     ],
//                   )
//                 else
//                   Expanded(child: Image.file(File(state.capturedPhoto!.path))),
//                 const SizedBox(height: 16),
//                 Text(
//                   _getHintText(state),
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstant.primary),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: state.successfulSteps.map(
//                       (s) => Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.check_circle, color: ColorConstant.primary, size: 20),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 s,
//                                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ).toList(),
//                   ),
//                 ),
//                 const Spacer(),
//                 if (state.photoCaptured)
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: ColorConstant.primary,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                         ),
//                         onPressed: () => NavigatorUtil.pushNamed(AppRoute.photoPreview, arguments: state.capturedPhoto),
//                         child: Text(
//                           'Confirm',
//                           style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorConstant.foreground),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _getHintText(FaceLivelinessState state) {
//     if (state.isCheckingClothes) return 'Checking clothes...';
//     if (!state.lookLeft) return 'Please turn your face to the LEFT';
//     if (!state.lookRight) return 'Now turn RIGHT';
//     if (!state.lookUp) return 'Look UP';
//     if (!state.lookDown) return 'Now look DOWN';
//     if (!state.eyesOpen) return 'Please open your EYES';
//     if (state.isCountingDown) return 'Hold still... ${state.countdown}';
//     return 'Getting ready to capture photo';
//   }
// }

// class _CircleBorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = ColorConstant.primary
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//     canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }


// ========================================================================

// import 'dart:io';
// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/service/photo_report_service.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/route/app_route.dart';
// import '../bloc/face_liveliness_bloc.dart';
// import '../bloc/face_liveliness_event.dart';
// import '../bloc/face_liveliness_state.dart';

// class FaceLivelinessCheckView extends StatefulWidget {
//   const FaceLivelinessCheckView({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider(
//       create: (_) => FaceLivelinessBloc()..add(InitializeCamera()),
//       child: const FaceLivelinessCheckView(),
//     );
//   }

//   @override
//   State<FaceLivelinessCheckView> createState() =>
//       _FaceLivelinessCheckViewState();
// }

// class _FaceLivelinessCheckViewState extends State<FaceLivelinessCheckView>
//     with WidgetsBindingObserver {
//   FaceLivelinessBloc? bloc;

//   @override
//   void initState() {
//     super.initState();
//     bloc = context.read<FaceLivelinessBloc>();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.paused) {
//       bloc?.cameraController?.dispose();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<FaceLivelinessBloc, FaceLivelinessState>(
//       // listener: (context, state) async {
//       //   if (state.photoCaptured && state.capturedPhoto != null) {
//       //     await bloc?.cameraController?.dispose(); // Dispose before navigation
//       //     NavigatorUtil.pushNamed(AppRoute.photoPreview, arguments: state.capturedPhoto);
//       //   }
//       // },
//       listener: (context, state) async {
//         debugPrint("🧠 Listener triggered with state: $state");

//         if (state.photoCaptured && state.capturedPhoto != null) {
//           debugPrint("📸 Photo Captured Path: ${state.capturedPhoto!.path}");

//           // Dispose camera before navigation
//           await bloc?.cameraController?.dispose();

//           // // Navigate to preview
//           // NavigatorUtil.pushNamed(
//           //   AppRoute.photoPreview,
//           //   arguments: state.capturedPhoto,
//           // );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("Liveliness Check"),
//             centerTitle: true,
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             foregroundColor: Colors.black,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new),
//               onPressed: () async {
//                 await bloc?.cameraController?.dispose();
//                 Navigator.of(context).pop();
//               },
//             ),
//             elevation: 0,
//           ),
//           body: SafeArea(
//             child: Column(
//               children: [
//                 const SizedBox(height: 12),
//                 const GlowingStepProgressIndicatorWidget(
//                   currentStep: 6,
//                   totalSteps: 7,
//                   progressColor: ColorConstant.primary,
//                 ),
//                 const SizedBox(height: 20),
//                 if (!state.isCameraInitialized ||
//                     bloc?.cameraController == null)
//                   const CircularProgressIndicator()
//                 else if (!state.photoCaptured)
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SizedBox(
//                         width: 300, // made slightly larger for better detection
//                         height: 300,
//                         child: ClipOval(
//                           child: CameraPreview(bloc!.cameraController!),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 300,
//                         height: 300,
//                         child: CustomPaint(painter: _CircleBorderPainter()),
//                       ),
//                       if (state.isCountingDown)
//                         Positioned(
//                           child: Text(
//                             '${state.countdown}',
//                             style: const TextStyle(
//                               fontSize: 48,
//                               fontWeight: FontWeight.bold,
//                               color: ColorConstant.primary,
//                             ),
//                           ),
//                         ),
//                     ],
//                   )
//                 else
//                   Expanded(child: Image.file(File(state.capturedPhoto!.path))),
//                 const SizedBox(height: 16),
//                 Text(
//                   _getHintText(state),
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                     color: ColorConstant.primary,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: state.successfulSteps
//                         .map(
//                           (s) => Padding(
//                             padding: const EdgeInsets.only(bottom: 8),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.check_circle,
//                                   color: ColorConstant.primary,
//                                   size: 20,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     s,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium
//                                         ?.copyWith(fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ),
//                 const Spacer(),
//                 // if (state.photoCaptured)
//                 //   Padding(
//                 //     padding: const EdgeInsets.all(16),
//                 //     child: SizedBox(
//                 //       width: double.infinity,
//                 //       height: 48,
//                 //       child: ElevatedButton(
//                 //         style: ElevatedButton.styleFrom(
//                 //           backgroundColor: ColorConstant.primary,
//                 //           shape: RoundedRectangleBorder(
//                 //             borderRadius: BorderRadius.circular(30),
//                 //           ),
//                 //         ),
//                 //         onPressed: () async {
//                 //           await bloc?.cameraController?.dispose();

//                 //           final photoId = SignupState().photoId;
//                 //           final photo = File(state.capturedPhoto!.path);

//                 //           debugPrint("🟡 Captured photo path: ${photo.path}");
//                 //           debugPrint(
//                 //             "📏 File size: ${photo.existsSync() ? photo.lengthSync() : 'Missing'}",
//                 //           );
//                 //           debugPrint("🔗 TrackingNo: $photoId");

//                 //           if (photoId != null && photo.existsSync()) {
//                 //             try {
//                 //               await PhotoReportService.updateUserPhoto(
//                 //                 trackingNo: photoId,
//                 //                 userPhoto: photo,
//                 //               );
//                 //               debugPrint("✅ Upload complete");
//                 //             } catch (e) {
//                 //               debugPrint("❌ Upload failed: $e");
//                 //             }
//                 //           } else {
//                 //             debugPrint(
//                 //               "❌ Skipped upload. Reason: ${photoId == null ? "Missing photoId" : "File not found"}",
//                 //             );
//                 //           }

//                 //           NavigatorUtil.pushNamed(
//                 //             AppRoute.photoPreview,
//                 //             arguments: state.capturedPhoto,
//                 //           );
//                 //         },
//                 //         child: Text(
//                 //           'Confirm',
//                 //           style: Theme.of(context).textTheme.labelLarge
//                 //               ?.copyWith(color: ColorConstant.foreground),
//                 //         ),
//                 if (state.photoCaptured)
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: ColorConstant.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         onPressed: () async {
//                           await bloc?.cameraController?.dispose();

//                           final photoId = SignupState().photoId;
//                           final photo = File(state.capturedPhoto!.path);

//                           debugPrint("🟡 Captured photo path: ${photo.path}");
//                           debugPrint(
//                             "📏 File size: ${photo.existsSync() ? photo.lengthSync() : 'Missing'}",
//                           );
//                           debugPrint("🔗 TrackingNo: $photoId");

//                           if (photoId != null && photo.existsSync()) {
//                             try {
//                               await PhotoReportService.updateUserPhoto(
//                                 trackingNo: photoId,
//                                 userPhoto: photo,
//                               );
//                               debugPrint("✅ Upload complete");

//                               // 👉 Navigate only after successful upload
//                               NavigatorUtil.pushNamed(
//                                 AppRoute.photoPreview,
//                                 arguments: state.capturedPhoto,
//                               );
//                             } catch (e) {
//                               debugPrint("❌ Upload failed: $e");
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     "Photo upload failed. Try again.",
//                                   ),
//                                 ),
//                               );
//                             }
//                           } else {
//                             debugPrint(
//                               "❌ Skipped upload. Reason: ${photoId == null ? "Missing photoId" : "File not found"}",
//                             );
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   "Missing photo or tracking info.",
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                         child: Text(
//                           'Confirm',
//                           style: Theme.of(context).textTheme.labelLarge
//                               ?.copyWith(color: ColorConstant.foreground),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _getHintText(FaceLivelinessState state) {
//     if (state.isCheckingClothes) return 'Checking clothes...';
//     if (!state.lookLeft) return 'Please turn your face to the LEFT';
//     if (!state.lookRight) return 'Now turn RIGHT';
//     if (!state.lookUp) return 'Look UP';
//     if (!state.lookDown) return 'Now look DOWN';
//     if (!state.eyesOpen) return 'Please open your EYES';
//     if (state.isCountingDown) return 'Hold still... ${state.countdown}';
//     return 'Getting ready to capture photo';
//   }
// }

// class _CircleBorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = ColorConstant.primary
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//     canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// ========================================================================


import 'dart:io';
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/service/photo_report_service.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/route/app_route.dart';
import '../bloc/face_liveliness_bloc.dart';
import '../bloc/face_liveliness_event.dart';
import '../bloc/face_liveliness_state.dart';

class FaceLivelinessCheckView extends StatefulWidget {
  const FaceLivelinessCheckView({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => FaceLivelinessBloc()..add(InitializeCamera()),
      child: const FaceLivelinessCheckView(),
    );
  }

  @override
  State<FaceLivelinessCheckView> createState() =>
      _FaceLivelinessCheckViewState();
}

class _FaceLivelinessCheckViewState extends State<FaceLivelinessCheckView>
    with WidgetsBindingObserver {
  FaceLivelinessBloc? bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<FaceLivelinessBloc>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final b = bloc;
    if (b == null) return;

    if (state == AppLifecycleState.resumed) {
      b.add(InitializeCamera());
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      b.add(DisposeCamera());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FaceLivelinessBloc, FaceLivelinessState>(
      listener: (context, state) async {
        if (state.photoCaptured && state.capturedPhoto != null) {
          // Camera is disposed in BLoC; nothing else to do here.
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Liveliness Check"),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                bloc?.add(DisposeCamera());
                Navigator.of(context).pop();
              },
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
                const SizedBox(height: 20),

                if (!state.isCameraInitialized || bloc?.cameraController == null)
                  const CircularProgressIndicator()
                else if (!state.photoCaptured)
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: ClipOval(
                          child: CameraPreview(bloc!.cameraController!),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: CustomPaint(painter: _CircleBorderPainter()),
                      ),
                      // Optional: show faces count if not 1
                      if (state.facesCount != 1 && !state.isCheckingClothes)
                        Positioned(
                          bottom: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Detected faces: ${state.facesCount}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  )
                else
                  Expanded(child: Image.file(File(state.capturedPhoto!.path))),

                const SizedBox(height: 16),

                // Hint from BLoC (no countdown)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    state.hint,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: ColorConstant.primary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),

                // Steps checklist
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.successfulSteps
                        .map(
                          (s) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: ColorConstant.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    s,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Spacer(),

                if (state.photoCaptured)
                  Padding(
                    padding: const EdgeInsets.all(16),
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
                          final photoId = SignupState().photoId;
                          final photo = File(state.capturedPhoto!.path);

                          if (!mounted) return;

                          if (photoId != null && photo.existsSync()) {
                            try {
                              await PhotoReportService.updateUserPhoto(
                                trackingNo: photoId,
                                userPhoto: photo,
                              );
                              NavigatorUtil.pushNamed(
                                AppRoute.photoPreview,
                                arguments: state.capturedPhoto,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Photo upload failed. Try again."),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Missing photo or tracking info."),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Confirm',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: ColorConstant.foreground),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CircleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorConstant.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
