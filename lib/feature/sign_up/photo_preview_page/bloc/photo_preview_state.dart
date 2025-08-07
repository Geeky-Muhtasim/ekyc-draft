import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

class PhotoPreviewState extends Equatable {
  final XFile? photo;
  final bool isConfirmed;

  const PhotoPreviewState({
    this.photo,
    this.isConfirmed = false,
  });

  PhotoPreviewState copyWith({
    XFile? photo,
    bool? isConfirmed,
  }) {
    return PhotoPreviewState(
      photo: photo ?? this.photo,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }

  @override
  List<Object?> get props => [photo, isConfirmed];
}
