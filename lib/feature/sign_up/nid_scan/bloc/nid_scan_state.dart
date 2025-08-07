import 'package:equatable/equatable.dart';

// class NidScanState extends Equatable {
//   final String? frontImagePath;
//   final String? backImagePath;

//   const NidScanState({this.frontImagePath, this.backImagePath});

//   bool get isReadyToContinue => frontImagePath != null && backImagePath != null;

//   NidScanState copyWith({
//     String? frontImagePath,
//     String? backImagePath,
//   }) {
//     return NidScanState(
//       frontImagePat  h: frontImagePath ?? this.frontImagePath,
//       backImagePath: backImagePath ?? this.backImagePath,
//     );
//   }

//   @override
//   List<Object?> get props => [frontImagePath, backImagePath];
// }

import 'package:equatable/equatable.dart';

class NidScanState extends Equatable {
  final String? frontImagePath;
  final String? backImagePath;
  final int? trackingNo;        // Tracking number from backend
  final bool isUploading;       // Indicates if upload is in progress
  final bool isUploaded;        // ✅ True after successful upload

  const NidScanState({
    this.frontImagePath,
    this.backImagePath,
    this.trackingNo,
    this.isUploading = false,
    this.isUploaded = false,
  });

  bool get isReadyToContinue => frontImagePath != null && backImagePath != null;

  NidScanState copyWith({
    String? frontImagePath,
    String? backImagePath,
    int? trackingNo,
    bool? isUploading,
    bool? isUploaded,
  }) {
    return NidScanState(
      frontImagePath: frontImagePath ?? this.frontImagePath,
      backImagePath: backImagePath ?? this.backImagePath,
      trackingNo: trackingNo ?? this.trackingNo,
      isUploading: isUploading ?? this.isUploading,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }

  @override
  List<Object?> get props =>
      [frontImagePath, backImagePath, trackingNo, isUploading, isUploaded];
}


