import 'package:equatable/equatable.dart';

class PhotoCaptureState extends Equatable {
  final bool instructionsAcknowledged;

  const PhotoCaptureState({
    this.instructionsAcknowledged = false,
  });

  PhotoCaptureState copyWith({
    bool? instructionsAcknowledged,
  }) {
    return PhotoCaptureState(
      instructionsAcknowledged: instructionsAcknowledged ?? this.instructionsAcknowledged,
    );
  }

  @override
  List<Object?> get props => [instructionsAcknowledged];
}

