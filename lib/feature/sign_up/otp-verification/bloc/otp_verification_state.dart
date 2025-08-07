// import 'package:equatable/equatable.dart';

// abstract class OtpVerificationState extends Equatable {
//   const OtpVerificationState();

//   @override
//   List<Object> get props => [];
// }

// class OtpInitial extends OtpVerificationState {}

// class OtpLoading extends OtpVerificationState {}

// class OtpVerified extends OtpVerificationState {}

// class OtpFailure extends OtpVerificationState {
//   final String error;

//   const OtpFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }
import 'package:equatable/equatable.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpVerificationState {}

class OtpLoading extends OtpVerificationState {}

class OtpVerified extends OtpVerificationState {
  final int otpId;        // ✅ OTP ID from backend
  final String message;   // Optional success message

  const OtpVerified({required this.otpId, this.message = ''});

  @override
  List<Object?> get props => [otpId, message];
}

class OtpFailure extends OtpVerificationState {
  final String error;

  const OtpFailure(this.error);

  @override
  List<Object?> get props => [error];
}
