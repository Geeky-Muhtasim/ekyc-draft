// import 'package:equatable/equatable.dart';

// abstract class OtpVerificationEvent extends Equatable {
//   const OtpVerificationEvent();

//   @override
//   List<Object> get props => [];
// }

// // class OtpSubmitted extends OtpVerificationEvent {
// //   final String otp;
// //   final String phone;

// //   const OtpSubmitted({required this.otp, required this.phone});

// //   @override
// //   List<Object> get props => [otp, phone];
// // }
// class OtpSubmitted extends OtpVerificationEvent {
//   final int otpId;
//   final String otp;

//   const OtpSubmitted({required this.otpId, required this.otp});

//   @override
//   List<Object> get props => [otpId, otp];
// }

// class OtpResendRequested extends OtpVerificationEvent {
//   final String phone;

//   const OtpResendRequested({required this.phone});

//   @override
//   List<Object> get props => [phone];
// }

// otp_verification_event.dart
import 'package:equatable/equatable.dart';

abstract class OtpVerificationEvent extends Equatable {
  const OtpVerificationEvent();

  @override
  List<Object> get props => [];
}

class OtpSubmitted extends OtpVerificationEvent {
  final int otpId;
  final String otp;

  const OtpSubmitted({required this.otpId, required this.otp});

  @override
  List<Object> get props => [otpId, otp];
}

class OtpResendRequested extends OtpVerificationEvent {
  final String phone;

  const OtpResendRequested({required this.phone});

  @override
  List<Object> get props => [phone];
}