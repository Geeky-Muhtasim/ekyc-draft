import 'dart:io';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class UploadStatusState extends Equatable {
  final File? nidFront;
  final File? nidBack;
  final File? photo;
  final Uint8List? signature;

  const UploadStatusState({
    this.nidFront,
    this.nidBack,
    this.photo,
    this.signature,
  });

  UploadStatusState copyWith({
    File? nidFront,
    File? nidBack,
    File? photo,
    Uint8List? signature,
  }) {
    return UploadStatusState(
      nidFront: nidFront ?? this.nidFront,
      nidBack: nidBack ?? this.nidBack,
      photo: photo ?? this.photo,
      signature: signature ?? this.signature,
    );
  }

  @override
  List<Object?> get props => [nidFront, nidBack, photo, signature];
}
