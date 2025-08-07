// import 'dart:io';

// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/service/ocr_api_service.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nid_scan/bloc/nid_scan_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nid_scan/bloc/nid_scan_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nid_scan/bloc/nid_scan_state.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/view/scanned_data_page.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/vertical_spacer_small_widget.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';

// class NidScanPage extends StatefulWidget {
//   const NidScanPage({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider(
//       create: (_) => NidScanBloc(),
//       child: const NidScanPage(),
//     );
//   }

//   @override
//   State<NidScanPage> createState() => _NidScanPageState();
// }

// class _NidScanPageState extends State<NidScanPage> {
//   late List<CameraDescription> _cameras;
//   bool _isLoading = false;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     _initializeCameras();
//   }

//   Future<void> _initializeCameras() async {
//     _cameras = await availableCameras();
//   }

//   Future<void> _captureNid({required bool isFront}) async {
//     if (_cameras.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No cameras found')),
//       );
//       return;
//     }

//     final result = await Navigator.pushNamed(
//       context,
//       AppRoute.cameraCapture,
//       arguments: _cameras.first,
//     );

//     if (result != null && mounted) {
//       final imagePath = result as String;
//       if (isFront) {
//         context.read<NidScanBloc>().add(NidFrontCaptured(imagePath));
//       } else {
//         context.read<NidScanBloc>().add(NidBackCaptured(imagePath));
//       }
//     }
//   }

//   Future<void> _pickFromGallery({required bool isFront}) async {
//     final XFile? pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       if (isFront) {
//         context.read<NidScanBloc>().add(NidFrontCaptured(pickedFile.path));
//       } else {
//         context.read<NidScanBloc>().add(NidBackCaptured(pickedFile.path));
//       }
//     }
//   }

//   // Future<void> _submitToApi(String frontPath, String backPath) async {
//   //   setState(() => _isLoading = true);

//   //   try {
//   //     final extractedData = await OcrApiService.extractNidData(
//   //       frontImage: File(frontPath),
//   //       backImage: File(backPath),
//   //     );

//   //     final scannedDataBloc = ScannedDataBloc()
//   //       ..add(ScannedDataInitialized(extractedData));

//   //     if (mounted) {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (_) => BlocProvider.value(
//   //             value: scannedDataBloc,
//   //             child: const ScannedDataPage(),
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('OCR failed: $e')),
//   //     );
//   //   } finally {
//   //     setState(() => _isLoading = false);
//   //   }
//   // }
//   Future<void> _submitToApi(String frontPath, String backPath) async {
//     setState(() => _isLoading = true);

//     try {
//       final frontFile = File(frontPath);
//       final backFile = File(backPath);

//       final extractedData = await OcrApiService.extractNidData(
//         frontImage: frontFile,
//         backImage: backFile,
//       );

//       final scannedDataBloc = ScannedDataBloc()
//         ..add(ScannedDataInitialized(extractedData));

//       if (mounted) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => BlocProvider.value(
//               value: scannedDataBloc,
//               child: ScannedDataPage(
//                 nidFrontImage: frontFile,
//                 nidBackImage: backFile,
//               ),
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('OCR failed: $e')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double cardWidth = MediaQuery.of(context).size.width * 0.8;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Text(
//             '<',
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Scan Your NID',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//       body: SafeArea(
//         child: BlocBuilder<NidScanBloc, NidScanState>(
//           builder: (context, state) {
//             return Column(
//               children: [
//                 GlowingStepProgressIndicatorWidget(
//                   currentStep: 3,
//                   totalSteps: 7,
//                   progressColor: Theme.of(context).primaryColor,
//                 ),
//                 const VerticalSpacerSmallWidget(),
//                 Text(
//                   'SCAN YOUR NID CARD',
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   'Scan the front side of NID card with camera or upload',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildNidCardSection(
//                   imagePath: state.frontImagePath,
//                   cardWidth: cardWidth,
//                   animationPath: 'asset/lottie/nid_front.json',
//                   onCameraPressed: () => _captureNid(isFront: true),
//                   onUploadPressed: () => _pickFromGallery(isFront: true),
//                 ),
//                 const SizedBox(height: 24),
//                 Text(
//                   'Scan the back side of NID card with camera or upload',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildNidCardSection(
//                   imagePath: state.backImagePath,
//                   cardWidth: cardWidth,
//                   animationPath: 'asset/lottie/nid_back.json',
//                   onCameraPressed: () => _captureNid(isFront: false),
//                   onUploadPressed: () => _pickFromGallery(isFront: false),
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: AppStyle.paddingAllSmall as EdgeInsets,
//                   child: SafeArea(
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: state.isReadyToContinue && !_isLoading
//                             // ? () => _submitToApi(state.frontImagePath!, state.backImagePath!)
//                             ? () async {
//                                 context.read<NidScanBloc>().add(
//                                   NidUploadSubmitted(),
//                                 );
//                                 await Future.delayed(
//                                   const Duration(seconds: 2),
//                                 ); // wait for upload
//                                 final blocState = context
//                                     .read<NidScanBloc>()
//                                     .state;
//                                 if (blocState.trackingNo != null) {
//                                   print("🔹 Current SignupState after photo upload: ${SignupState()}");
//                                   _submitToApi(
//                                     blocState.frontImagePath!,
//                                     blocState.backImagePath!,
//                                   );
//                                 }
//                               }
//                             : null,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               state.isReadyToContinue && !_isLoading
//                               ? Theme.of(context).primaryColor
//                               : Colors.grey.shade400,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: _isLoading
//                             ? const CircularProgressIndicator(
//                                 color: Colors.white,
//                               )
//                             : Text(
//                                 'Continue',
//                                 style: Theme.of(context).textTheme.labelLarge
//                                     ?.copyWith(
//                                       color: ColorConstant.foreground,
//                                     ),
//                               ),
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

//   Widget _buildNidCardSection({
//     required String? imagePath,
//     required double cardWidth,
//     required String animationPath,
//     required VoidCallback onCameraPressed,
//     required VoidCallback onUploadPressed,
//   }) {
//     return Stack(
//       alignment: Alignment.bottomRight,
//       children: [
//         Container(
//           width: cardWidth,
//           height: 150,
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: imagePath != null
//               ? Image.file(File(imagePath), fit: BoxFit.cover)
//               : Lottie.asset(animationPath, repeat: true, fit: BoxFit.contain),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               FloatingActionButton.small(
//                 heroTag: null,
//                 backgroundColor: Colors.grey.shade700,
//                 tooltip: 'Upload from Gallery',
//                 onPressed: onUploadPressed,
//                 child: const Icon(Icons.upload_file, color: Colors.white),
//               ),
//               const SizedBox(width: 12),
//               FloatingActionButton(
//                 heroTag: null,
//                 backgroundColor: Theme.of(context).primaryColor,
//                 tooltip: 'Scan with Camera',
//                 onPressed: onCameraPressed,
//                 child: const Icon(Icons.camera_alt, color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:io';

import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/service/ocr_api_service.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/nid_scan/bloc/nid_scan_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/nid_scan/bloc/nid_scan_event.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/nid_scan/bloc/nid_scan_state.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_event.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/view/scanned_data_page.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:bangladesh_finance_ekyc/widget/common/vertical_spacer_small_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';

class NidScanPage extends StatefulWidget {
  const NidScanPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => NidScanBloc(),
      child: const NidScanPage(),
    );
  }

  @override
  State<NidScanPage> createState() => _NidScanPageState();
}

class _NidScanPageState extends State<NidScanPage> {
  late List<CameraDescription> _cameras;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();
  }

  Future<void> _captureNid({required bool isFront}) async {
    if (_cameras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No cameras found')),
      );
      return;
    }

    final result = await Navigator.pushNamed(
      context,
      AppRoute.cameraCapture,
      arguments: _cameras.first,
    );

    if (result != null && mounted) {
      final imagePath = result as String;
      if (isFront) {
        context.read<NidScanBloc>().add(NidFrontCaptured(imagePath));
      } else {
        context.read<NidScanBloc>().add(NidBackCaptured(imagePath));
      }
    }
  }

  Future<void> _pickFromGallery({required bool isFront}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (isFront) {
        context.read<NidScanBloc>().add(NidFrontCaptured(pickedFile.path));
      } else {
        context.read<NidScanBloc>().add(NidBackCaptured(pickedFile.path));
      }
    }
  }

  Future<void> _submitToApi(String frontPath, String backPath) async {
    setState(() => _isLoading = true);

    try {
      final frontFile = File(frontPath);
      final backFile = File(backPath);

      final extractedData = await OcrApiService.extractNidData(
        frontImage: frontFile,
        backImage: backFile,
      );

      final scannedDataBloc = ScannedDataBloc()
        ..add(ScannedDataInitialized(extractedData));

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: scannedDataBloc,
              child: ScannedDataPage(
                nidFrontImage: frontFile,
                nidBackImage: backFile,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OCR failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Text(
            '<',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Scan Your NID',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: BlocListener<NidScanBloc, NidScanState>(
          listener: (context, state) {
            if (state.isUploaded && state.trackingNo != null) {
              // ✅ Persist photoId to SignupState
              SignupState().photoId = state.trackingNo;
              print("✅ Photo ID persisted: ${SignupState().photoId}");
              print("🔹 Full SignupState: ${SignupState()}");

              // ✅ Navigate automatically
              _submitToApi(state.frontImagePath!, state.backImagePath!);
            }
          },
          child: BlocBuilder<NidScanBloc, NidScanState>(
            builder: (context, state) {
              return Column(
                children: [
                  GlowingStepProgressIndicatorWidget(
                    currentStep: 3,
                    totalSteps: 7,
                    progressColor: Theme.of(context).primaryColor,
                  ),
                  const VerticalSpacerSmallWidget(),
                  Text(
                    'SCAN YOUR NID CARD',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Scan the front side of NID card with camera or upload',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildNidCardSection(
                    imagePath: state.frontImagePath,
                    cardWidth: cardWidth,
                    animationPath: 'asset/lottie/nid_front.json',
                    onCameraPressed: () => _captureNid(isFront: true),
                    onUploadPressed: () => _pickFromGallery(isFront: true),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Scan the back side of NID card with camera or upload',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildNidCardSection(
                    imagePath: state.backImagePath,
                    cardWidth: cardWidth,
                    animationPath: 'asset/lottie/nid_back.json',
                    onCameraPressed: () => _captureNid(isFront: false),
                    onUploadPressed: () => _pickFromGallery(isFront: false),
                  ),
                  const Spacer(),
                  Padding(
                    padding: AppStyle.paddingAllSmall as EdgeInsets,
                    child: SafeArea(
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: state.isReadyToContinue && !_isLoading
                              ? () {
                                  setState(() => _isLoading = true);
                                  context
                                      .read<NidScanBloc>()
                                      .add(NidUploadSubmitted());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.isReadyToContinue && !_isLoading
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Continue',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(color: ColorConstant.foreground),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNidCardSection({
    required String? imagePath,
    required double cardWidth,
    required String animationPath,
    required VoidCallback onCameraPressed,
    required VoidCallback onUploadPressed,
  }) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: cardWidth,
          height: 150,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: imagePath != null
              ? Image.file(File(imagePath), fit: BoxFit.cover)
              : Lottie.asset(animationPath, repeat: true, fit: BoxFit.contain),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.small(
                heroTag: null,
                backgroundColor: Colors.grey.shade700,
                tooltip: 'Upload from Gallery',
                onPressed: onUploadPressed,
                child: const Icon(Icons.upload_file, color: Colors.white),
              ),
              const SizedBox(width: 12),
              FloatingActionButton(
                heroTag: null,
                backgroundColor: Theme.of(context).primaryColor,
                tooltip: 'Scan with Camera',
                onPressed: onCameraPressed,
                child: const Icon(Icons.camera_alt, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
