import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class PhotoPreviewEvent extends Equatable {
  const PhotoPreviewEvent();

  @override
  List<Object?> get props => [];
}

class LoadCapturedPhoto extends PhotoPreviewEvent {
  final XFile photo;

  const LoadCapturedPhoto(this.photo);

  @override
  List<Object?> get props => [photo];
}

class ConfirmPhoto extends PhotoPreviewEvent {}
