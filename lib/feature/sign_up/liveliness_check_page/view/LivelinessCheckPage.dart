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
import 'dart:io';
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
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
  State<FaceLivelinessCheckView> createState() => _FaceLivelinessCheckViewState();
}

class _FaceLivelinessCheckViewState extends State<FaceLivelinessCheckView> with WidgetsBindingObserver {
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
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      bloc?.cameraController?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FaceLivelinessBloc, FaceLivelinessState>(
      listener: (context, state) async {
        if (state.photoCaptured && state.capturedPhoto != null) {
          await bloc?.cameraController?.dispose(); // Dispose before navigation
          NavigatorUtil.pushNamed(AppRoute.photoPreview, arguments: state.capturedPhoto);
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
              onPressed: () async {
                await bloc?.cameraController?.dispose();
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
                        width: 300, // made slightly larger for better detection
                        height: 300,
                        child: ClipOval(child: CameraPreview(bloc!.cameraController!)),
                      ),
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: CustomPaint(painter: _CircleBorderPainter()),
                      ),
                      if (state.isCountingDown)
                        Positioned(
                          child: Text(
                            '${state.countdown}',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.primary,
                            ),
                          ),
                        ),
                    ],
                  )
                else
                  Expanded(child: Image.file(File(state.capturedPhoto!.path))),
                const SizedBox(height: 16),
                Text(
                  _getHintText(state),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstant.primary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.successfulSteps.map(
                      (s) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: ColorConstant.primary, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                s,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).toList(),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          await bloc?.cameraController?.dispose(); // dispose early
                          NavigatorUtil.pushNamed(AppRoute.photoPreview, arguments: state.capturedPhoto);
                        },
                        child: Text(
                          'Confirm',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorConstant.foreground),
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

  String _getHintText(FaceLivelinessState state) {
    if (state.isCheckingClothes) return 'Checking clothes...';
    if (!state.lookLeft) return 'Please turn your face to the LEFT';
    if (!state.lookRight) return 'Now turn RIGHT';
    if (!state.lookUp) return 'Look UP';
    if (!state.lookDown) return 'Now look DOWN';
    if (!state.eyesOpen) return 'Please open your EYES';
    if (state.isCountingDown) return 'Hold still... ${state.countdown}';
    return 'Getting ready to capture photo';
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
