import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signature_event.dart';
import 'signature_state.dart';

class SignatureBloc extends Bloc<SignatureEvent, SignatureState> {
  SignatureBloc() : super(const SignatureState()) {
    on<SignatureDrawn>(_onSignatureDrawn);
    on<SignatureCleared>(_onSignatureCleared);
    on<TermsAgreedToggled>(_onTermsAgreedToggled);
  }

  void _onSignatureDrawn(SignatureDrawn event, Emitter<SignatureState> emit) {
    emit(state.copyWith(signatureBytes: event.signature));
  }

  void _onSignatureCleared(SignatureCleared event, Emitter<SignatureState> emit) {
    emit(state.copyWith(signatureBytes: null));
  }

  void _onTermsAgreedToggled(TermsAgreedToggled event, Emitter<SignatureState> emit) {
    emit(state.copyWith(agreed: !state.agreed));
  }
}