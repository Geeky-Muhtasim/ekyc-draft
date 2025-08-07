import 'package:equatable/equatable.dart';

abstract class NidScanEvent extends Equatable {
  const NidScanEvent();

  @override
  List<Object?> get props => [];
}

class NidFrontCaptured extends NidScanEvent {
  final String imagePath;
  const NidFrontCaptured(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class NidBackCaptured extends NidScanEvent {
  final String imagePath;
  const NidBackCaptured(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class NidUploadSubmitted extends NidScanEvent {}
