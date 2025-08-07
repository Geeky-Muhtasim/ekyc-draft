import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class SignatureEvent extends Equatable {
  const SignatureEvent();

  @override
  List<Object?> get props => [];
}

class SignatureDrawn extends SignatureEvent {
  final Uint8List signature;

  const SignatureDrawn(this.signature);

  @override
  List<Object?> get props => [signature];
}

class SignatureCleared extends SignatureEvent {}

class TermsAgreedToggled extends SignatureEvent {}