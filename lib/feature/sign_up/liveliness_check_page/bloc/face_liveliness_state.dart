import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

class FaceLivelinessState extends Equatable {
  final bool isCameraInitialized;
  final bool isCheckingClothes;
  final bool isCountingDown;
  final bool photoCaptured;
  final int countdown;
  final XFile? capturedPhoto;
  final List<String> successfulSteps;

  final bool lookLeft;
  final bool lookRight;
  final bool lookUp;
  final bool lookDown;
  final bool eyesOpen;

  const FaceLivelinessState({
    this.isCameraInitialized = false,
    this.isCheckingClothes = true,
    this.isCountingDown = false,
    this.photoCaptured = false,
    this.countdown = 3,
    this.capturedPhoto,
    this.successfulSteps = const [],
    this.lookLeft = false,
    this.lookRight = false,
    this.lookUp = false,
    this.lookDown = false,
    this.eyesOpen = false,
  });

  FaceLivelinessState copyWith({
    bool? isCameraInitialized,
    bool? isCheckingClothes,
    bool? isCountingDown,
    bool? photoCaptured,
    int? countdown,
    XFile? capturedPhoto,
    List<String>? successfulSteps,
    bool? lookLeft,
    bool? lookRight,
    bool? lookUp,
    bool? lookDown,
    bool? eyesOpen,
  }) {
    return FaceLivelinessState(
      isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
      isCheckingClothes: isCheckingClothes ?? this.isCheckingClothes,
      isCountingDown: isCountingDown ?? this.isCountingDown,
      photoCaptured: photoCaptured ?? this.photoCaptured,
      countdown: countdown ?? this.countdown,
      capturedPhoto: capturedPhoto ?? this.capturedPhoto,
      successfulSteps: successfulSteps ?? this.successfulSteps,
      lookLeft: lookLeft ?? this.lookLeft,
      lookRight: lookRight ?? this.lookRight,
      lookUp: lookUp ?? this.lookUp,
      lookDown: lookDown ?? this.lookDown,
      eyesOpen: eyesOpen ?? this.eyesOpen,
    );
  }

  @override
  List<Object?> get props => [
        isCameraInitialized,
        isCheckingClothes,
        isCountingDown,
        photoCaptured,
        countdown,
        capturedPhoto,
        successfulSteps,
        lookLeft,
        lookRight,
        lookUp,
        lookDown,
        eyesOpen,
      ];
}