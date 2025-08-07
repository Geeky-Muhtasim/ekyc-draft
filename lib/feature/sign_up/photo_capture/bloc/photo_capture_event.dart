import 'package:equatable/equatable.dart';

abstract class PhotoCaptureEvent extends Equatable {
  const PhotoCaptureEvent();

  @override
  List<Object?> get props => [];
}

class MarkInstructionsAcknowledged extends PhotoCaptureEvent {}
