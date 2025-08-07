import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class SignatureState extends Equatable {
  final bool agreed;
  final Uint8List? signatureBytes;

  const SignatureState({
    this.agreed = false,
    this.signatureBytes,
  });

  bool get canContinue => agreed && signatureBytes != null;

  SignatureState copyWith({
    bool? agreed,
    Uint8List? signatureBytes,
  }) {
    return SignatureState(
      agreed: agreed ?? this.agreed,
      signatureBytes: signatureBytes,
    );
  }

  @override
  List<Object?> get props => [agreed, signatureBytes ?? ''];
}