import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class FaceLivelinessEvent extends Equatable {
  const FaceLivelinessEvent();

  @override
  List<Object?> get props => [];
}

class InitializeCamera extends FaceLivelinessEvent {}

class AnalyzeFace extends FaceLivelinessEvent {}

class StartClothDetection extends FaceLivelinessEvent {}

class FaceDetected extends FaceLivelinessEvent {
  final double yaw;
  final double pitch;
  final double? leftEye;
  final double? rightEye;

  const FaceDetected({
    required this.yaw,
    required this.pitch,
    this.leftEye,
    this.rightEye,
  });

  @override
  List<Object?> get props => [yaw, pitch, leftEye, rightEye];
}

class StartCountdown extends FaceLivelinessEvent {}

class TickCountdown extends FaceLivelinessEvent {}

class CapturePhoto extends FaceLivelinessEvent {
  final XFile photo;

  const CapturePhoto(this.photo);

  @override
  List<Object?> get props => [photo];
}

class RetryDetection extends FaceLivelinessEvent {}