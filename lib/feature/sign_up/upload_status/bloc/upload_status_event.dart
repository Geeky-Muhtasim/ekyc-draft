import 'dart:io';
import 'package:equatable/equatable.dart';
import 'dart:typed_data';

abstract class UploadStatusEvent extends Equatable {
  const UploadStatusEvent();

  @override
  List<Object?> get props => [];
}

class SetUploadStatusImages extends UploadStatusEvent {
  final File? nidFront;
  final File? nidBack;
  final File? photo;
  final Uint8List? signature;

  const SetUploadStatusImages({
    this.nidFront,
    this.nidBack,
    this.photo,
    this.signature,
  });

  @override
  List<Object?> get props => [nidFront, nidBack, photo, signature];
}
