// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'face_liveliness_event.dart';
// import 'face_liveliness_state.dart';

// class FaceLivelinessBloc extends Bloc<FaceLivelinessEvent, FaceLivelinessState> {
//   CameraController? _cameraController;
//   late FaceDetector _faceDetector;
//   Timer? _periodicTimer;
//   Timer? _countdownTimer;
//   DateTime _lastSuccessTime = DateTime.now();
//   bool _isProcessing = false;

//   CameraController? get cameraController => _cameraController;

//   FaceLivelinessBloc() : super(const FaceLivelinessState()) {
//     _faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
//       enableClassification: true,
//       performanceMode: FaceDetectorMode.accurate,
//     ));

//     on<InitializeCamera>(_onInitializeCamera);
//     on<StartClothDetection>(_onStartClothDetection);
//     on<AnalyzeFace>(_onAnalyzeFace);
//     on<FaceDetected>(_onFaceDetected);
//     on<StartCountdown>(_onStartCountdown);
//     on<TickCountdown>(_onTickCountdown);
//     on<CapturePhoto>(_onCapturePhoto);
//   }

//   Future<void> _onInitializeCamera(
//       InitializeCamera event, Emitter<FaceLivelinessState> emit) async {
//     if (await Permission.camera.request().isDenied) return;
//     final frontCamera = (await availableCameras())
//         .firstWhere((c) => c.lensDirection == CameraLensDirection.front);

//     _cameraController =
//         CameraController(frontCamera, ResolutionPreset.medium, enableAudio: false);
//     await _cameraController!.initialize();

//     emit(state.copyWith(isCameraInitialized: true));

//     _periodicTimer?.cancel();
//     _periodicTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
//       if (state.isCheckingClothes) {
//         add(StartClothDetection());
//       } else {
//         add(AnalyzeFace());
//       }
//     });
//   }

//   Future<void> _onStartClothDetection(
//       StartClothDetection event, Emitter<FaceLivelinessState> emit) async {
//     if (_cameraController == null || !_cameraController!.value.isInitialized || _isProcessing) return;
//     _isProcessing = true;

//     try {
//       final image = await _cameraController!.takePicture();
//       final bytes = await File(image.path).readAsBytes();

//       final request = http.MultipartRequest(
//         "POST",
//         Uri.parse("http://192.168.0.53:8012/detect-clothes"),
//         // Uri.parse("http://172.50.10.121:8012/detect-clothes"),
//       )
//         ..files.add(http.MultipartFile.fromBytes('image', bytes,
//             filename: 'upload.jpg', contentType: MediaType('image', 'jpeg')));

//       final response = await request.send();
//       final resBody = await response.stream.bytesToString();

//       final decoded = json.decode(resBody);
//       if (response.statusCode == 200 && decoded["is_wearing_clothes"] == true) {
//         emit(state.copyWith(
//           isCheckingClothes: false,
//           successfulSteps: [...state.successfulSteps, "Clothes Detected"],
//         ));
//       }
//     } catch (e) {
//       // Handle error if needed
//     }

//     _isProcessing = false;
//   }

//   Future<void> _onAnalyzeFace(
//       AnalyzeFace event, Emitter<FaceLivelinessState> emit) async {
//     if (_cameraController == null || !_cameraController!.value.isInitialized || _isProcessing || state.photoCaptured) return;
//     _isProcessing = true;

//     try {
//       final shot = await _cameraController!.takePicture();
//       final input = InputImage.fromFilePath(shot.path);
//       final faces = await _faceDetector.processImage(input);

//       if (faces.isNotEmpty) {
//         final face = faces.first;

//         final isCentered =
//             (face.headEulerAngleY?.abs() ?? 0) < 5 && (face.headEulerAngleX?.abs() ?? 0) < 5;

//         add(FaceDetected(
//           yaw: face.headEulerAngleY ?? 0,
//           pitch: face.headEulerAngleX ?? 0,
//           leftEye: face.leftEyeOpenProbability,
//           rightEye: face.rightEyeOpenProbability,
//         ));

//         if (state.lookLeft &&
//             state.lookRight &&
//             state.lookUp &&
//             state.lookDown &&
//             state.eyesOpen &&
//             isCentered &&
//             !state.isCountingDown) {
//           add(StartCountdown());
//         }
//       }
//     } catch (e) {
//       // log error
//     }

//     _isProcessing = false;
//   }

//   void _onFaceDetected(FaceDetected event, Emitter<FaceLivelinessState> emit) {
//     final now = DateTime.now();
//     final elapsed = now.difference(_lastSuccessTime);

//     if (elapsed.inMilliseconds < 1500) return;

//     final updatedSteps = [...state.successfulSteps];
//     bool updated = false;

//     if (!state.lookLeft && event.yaw > 10) {
//       updatedSteps.add("Turned Left");
//       emit(state.copyWith(lookLeft: true, successfulSteps: updatedSteps));
//       updated = true;
//     } else if (state.lookLeft && !state.lookRight && event.yaw < -10) {
//       updatedSteps.add("Turned Right");
//       emit(state.copyWith(lookRight: true, successfulSteps: updatedSteps));
//       updated = true;
//     } else if (state.lookRight && !state.lookUp && event.pitch > 10) {
//       updatedSteps.add("Looked Up");
//       emit(state.copyWith(lookUp: true, successfulSteps: updatedSteps));
//       updated = true;
//     } else if (state.lookUp && !state.lookDown && event.pitch < -10) {
//       updatedSteps.add("Looked Down");
//       emit(state.copyWith(lookDown: true, successfulSteps: updatedSteps));
//       updated = true;
//     } else if (state.lookDown &&
//         !state.eyesOpen &&
//         (event.leftEye ?? 0) > 0.3 &&
//         (event.rightEye ?? 0) > 0.3) {
//       updatedSteps.add("Eyes Open");
//       emit(state.copyWith(eyesOpen: true, successfulSteps: updatedSteps));
//       updated = true;
//     }

//     if (updated) _lastSuccessTime = now;
//   }

//   void _onStartCountdown(StartCountdown event, Emitter<FaceLivelinessState> emit) {
//     emit(state.copyWith(isCountingDown: true, countdown: 3));

//     _countdownTimer?.cancel();
//     _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
//       if (state.countdown == 0) {
//         timer.cancel();
//         if (_cameraController != null && _cameraController!.value.isInitialized) {
//           final finalPhoto = await _cameraController!.takePicture();
//           add(CapturePhoto(finalPhoto));
//         }
//       } else {
//         add(TickCountdown());
//       }
//     });
//   }

//   void _onTickCountdown(TickCountdown event, Emitter<FaceLivelinessState> emit) {
//     emit(state.copyWith(countdown: state.countdown - 1));
//   }

//   void _onCapturePhoto(CapturePhoto event, Emitter<FaceLivelinessState> emit) {
//     _periodicTimer?.cancel();
//     emit(state.copyWith(
//       capturedPhoto: event.photo,
//       photoCaptured: true,
//       successfulSteps: [...state.successfulSteps, "Photo Captured"],
//     ));
//   }

//   @override
//   Future<void> close() {
//     _faceDetector.close();
//     _cameraController?.dispose();
//     _periodicTimer?.cancel();
//     _countdownTimer?.cancel();
//     return super.close();
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';

import 'face_liveliness_event.dart';
import 'face_liveliness_state.dart';

class FaceLivelinessBloc extends Bloc<FaceLivelinessEvent, FaceLivelinessState> {
  CameraController? _cameraController;
  late FaceDetector _faceDetector;
  Timer? _periodicTimer;
  Timer? _steadyTimer;                // brief steady phase timer
  DateTime _lastSuccessTime = DateTime.now();
  bool _isProcessing = false;

  // single-face streak before we start evaluating challenges
  int _singleFaceStreak = 0;
  static const int _requiredSingleFaceStreak = 3; // ~6s with 2s sampling

  // how long to hold steady (no countdown UI)
  static const Duration _steadyHold = Duration(milliseconds: 700);

  CameraController? get cameraController => _cameraController;

  FaceLivelinessBloc() : super(const FaceLivelinessState()) {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableClassification: true,
        performanceMode: FaceDetectorMode.accurate,
        enableTracking: true,
      ),
    );

    on<InitializeCamera>(_onInitializeCamera);
    on<DisposeCamera>(_onDisposeCamera);
    on<StartClothDetection>(_onStartClothDetection);
    on<AnalyzeFace>(_onAnalyzeFace);
    on<FaceDetected>(_onFaceDetected);
    on<CapturePhoto>(_onCapturePhoto);
  }

  Future<void> _onInitializeCamera(
      InitializeCamera event, Emitter<FaceLivelinessState> emit) async {
    if (await Permission.camera.request().isDenied) return;

    final frontCamera = (await availableCameras())
        .firstWhere((c) => c.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _cameraController!.initialize();

    _singleFaceStreak = 0;
    emit(state.copyWith(isCameraInitialized: true, hint: 'Checking clothes...'));

    _periodicTimer?.cancel();
    _periodicTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      if (state.photoCaptured) return;
      if (state.isCheckingClothes) {
        add(StartClothDetection());
      } else {
        add(AnalyzeFace());
      }
    });
  }

  Future<void> _onDisposeCamera(
      DisposeCamera event, Emitter<FaceLivelinessState> emit) async {
    _periodicTimer?.cancel();
    _steadyTimer?.cancel();
    await _cameraController?.dispose();
    _cameraController = null;
    emit(state.copyWith(isCameraInitialized: false));
  }

  Future<void> _onStartClothDetection(
      StartClothDetection event, Emitter<FaceLivelinessState> emit) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized || _isProcessing) return;
    _isProcessing = true;

    try {
      final image = await _cameraController!.takePicture();
      final bytes = await File(image.path).readAsBytes();

      final request = http.MultipartRequest(
        "POST",
        Uri.parse("http://192.168.0.53:8012/detect-clothes"),
      )..files.add(http.MultipartFile.fromBytes(
          'image', bytes, filename: 'upload.jpg', contentType: MediaType('image', 'jpeg')));

      final response = await request.send();
      final resBody = await response.stream.bytesToString();
      final decoded = json.decode(resBody);

      if (response.statusCode == 200 && decoded["is_wearing_clothes"] == true) {
        emit(state.copyWith(
          isCheckingClothes: false,
          successfulSteps: [...state.successfulSteps, "Clothes detected"],
          hint: "Make sure only you are in the frame",
        ));
      } else {
        emit(state.copyWith(hint: "Please wear proper clothes and try again"));
      }
    } catch (_) {
      emit(state.copyWith(hint: "Clothes check failed. Retrying..."));
    }

    _isProcessing = false;
  }

  Future<void> _onAnalyzeFace(
      AnalyzeFace event, Emitter<FaceLivelinessState> emit) async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _isProcessing ||
        state.photoCaptured) return;

    _isProcessing = true;

    try {
      final shot = await _cameraController!.takePicture();
      final input = InputImage.fromFilePath(shot.path);
      final faces = await _faceDetector.processImage(input);

      // update faces count for UI
      emit(state.copyWith(facesCount: faces.length));

      // ---- SINGLE PERSON RULE ----
      if (faces.length != 1) {
        _singleFaceStreak = 0;
        _cancelSteadyHoldIfRunning(emit);
        emit(state.copyWith(
          hint: faces.isEmpty ? "Bring your face into the circle"
                              : "Only one person should be in view",
        ));
        _isProcessing = false;
        return;
      } else {
        _singleFaceStreak++;
        if (_singleFaceStreak < _requiredSingleFaceStreak) {
          emit(state.copyWith(hint: "Hold still..."));
          _isProcessing = false;
          return;
        }
      }

      final face = faces.first;
      final yaw = face.headEulerAngleY ?? 0.0;
      final pitch = face.headEulerAngleX ?? 0.0;

      add(FaceDetected(
        yaw: yaw,
        pitch: pitch,
        leftEye: face.leftEyeOpenProbability,
        rightEye: face.rightEyeOpenProbability,
      ));

      // baseline “centered” = facing front-ish
      final isCentered = yaw.abs() < 5 && pitch.abs() < 5;

      final stepsDone = state.lookLeft &&
          state.lookRight &&
          state.lookUp &&
          state.lookDown &&
          state.eyesOpen;

      if (stepsDone && isCentered) {
        // begin steady hold (no countdown UI)
        if (!state.isHoldingSteady) {
          emit(state.copyWith(isHoldingSteady: true, hint: "Hold steady"));
          _steadyTimer?.cancel();
          _steadyTimer = Timer(_steadyHold, () async {
            // re-check basic conditions before capture
            if (!state.photoCaptured &&
                state.isHoldingSteady &&
                _cameraController != null &&
                _cameraController!.value.isInitialized) {
              final finalPhoto = await _cameraController!.takePicture();
              add(CapturePhoto(finalPhoto));
            }
          });
        }
      } else {
        // conditions regressed → cancel steady hold
        _cancelSteadyHoldIfRunning(emit);
        // also update helpful hint
        if (!state.lookLeft) {
          emit(state.copyWith(hint: "Please turn your face to the LEFT"));
        } else if (!state.lookRight) {
          emit(state.copyWith(hint: "Now turn RIGHT"));
        } else if (!state.lookUp) {
          emit(state.copyWith(hint: "Look UP"));
        } else if (!state.lookDown) {
          emit(state.copyWith(hint: "Now look DOWN"));
        } else if (!state.eyesOpen) {
          emit(state.copyWith(hint: "Please open your EYES"));
        } else {
          emit(state.copyWith(hint: "Center your face"));
        }
      }
    } catch (_) {
      // swallow; next tick will retry
    } finally {
      _isProcessing = false;
    }
  }

  void _onFaceDetected(FaceDetected event, Emitter<FaceLivelinessState> emit) {
    final now = DateTime.now();
    final elapsed = now.difference(_lastSuccessTime);
    if (elapsed.inMilliseconds < 1200) return;

    final updatedSteps = [...state.successfulSteps];
    var updated = false;

    if (!state.lookLeft && event.yaw > 10) {
      updatedSteps.add("Turned Left");
      emit(state.copyWith(lookLeft: true, successfulSteps: updatedSteps, hint: "Now turn RIGHT"));
      updated = true;
    } else if (state.lookLeft && !state.lookRight && event.yaw < -10) {
      updatedSteps.add("Turned Right");
      emit(state.copyWith(lookRight: true, successfulSteps: updatedSteps, hint: "Look UP"));
      updated = true;
    } else if (state.lookRight && !state.lookUp && event.pitch > 10) {
      updatedSteps.add("Looked Up");
      emit(state.copyWith(lookUp: true, successfulSteps: updatedSteps, hint: "Look DOWN"));
      updated = true;
    } else if (state.lookUp && !state.lookDown && event.pitch < -10) {
      updatedSteps.add("Looked Down");
      emit(state.copyWith(lookDown: true, successfulSteps: updatedSteps, hint: "Open your eyes"));
      updated = true;
    } else if (state.lookDown &&
        !state.eyesOpen &&
        (event.leftEye ?? 0) > 0.4 &&
        (event.rightEye ?? 0) > 0.4) {
      updatedSteps.add("Eyes open");
      emit(state.copyWith(eyesOpen: true, successfulSteps: updatedSteps, hint: "Hold steady"));
      updated = true;
    }

    if (updated) _lastSuccessTime = now;
  }

  void _onCapturePhoto(CapturePhoto event, Emitter<FaceLivelinessState> emit) {
    _periodicTimer?.cancel();
    _steadyTimer?.cancel();
    emit(state.copyWith(
      capturedPhoto: event.photo,
      photoCaptured: true,
      successfulSteps: [...state.successfulSteps, "Photo captured"],
      hint: "Photo captured",
      isHoldingSteady: false,
    ));
  }

  void _cancelSteadyHoldIfRunning(Emitter<FaceLivelinessState> emit) {
    if (state.isHoldingSteady) {
      _steadyTimer?.cancel();
      emit(state.copyWith(isHoldingSteady: false));
    }
  }

  @override
  Future<void> close() {
    _faceDetector.close();
    _cameraController?.dispose();
    _periodicTimer?.cancel();
    _steadyTimer?.cancel();
    return super.close();
  }
}
