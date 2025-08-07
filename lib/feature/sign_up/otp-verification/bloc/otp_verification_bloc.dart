// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'otp_verification_event.dart';
// import 'otp_verification_state.dart';

// class OtpVerificationBloc
//     extends Bloc<OtpVerificationEvent, OtpVerificationState> {
//   OtpVerificationBloc() : super(OtpInitial()) {
//     on<OtpSubmitted>(_onOtpSubmitted);
//     on<OtpResendRequested>(_onOtpResend);
//   }

//   Future<void> _onOtpSubmitted(
//     OtpSubmitted event,
//     Emitter<OtpVerificationState> emit,
//   ) async {
//     emit(OtpLoading());
//     try {
//       final url = Uri.parse('http://192.168.0.53:8070/otp/verify'); // Replace with actual
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'otp_id': event.otpId,
//           'otp_code_sms': event.otp,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final isVerified = data['is_verified'] == true;

//         if (isVerified) {
//           emit(OtpVerified());
//         } else {
//           emit(OtpFailure((data['message'] ?? 'OTP verification failed.').toString()));
//         }
//       } else {
//         emit(OtpFailure('Server error: ${response.statusCode}'));
//       }
//     } catch (e) {
//       emit(const OtpFailure('Something went wrong while verifying OTP.'));
//     }
//   }

//   Future<void> _onOtpResend(
//     OtpResendRequested event,
//     Emitter<OtpVerificationState> emit,
//   ) async {
//     // You can trigger resend OTP API here if available
//     await Future.delayed(const Duration(seconds: 1));
//   }
// }
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'otp_verification_event.dart';
import 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc() : super(OtpInitial()) {
    on<OtpSubmitted>(_onOtpSubmitted);
    on<OtpResendRequested>(_onOtpResend);
  }

  Future<void> _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<OtpVerificationState> emit,
  ) async {
    emit(OtpLoading());
    try {
      final url = Uri.parse('http://192.168.0.53:8070/otp/verify'); // Replace with actual
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'otp_id': event.otpId,
          'otp_code_sms': event.otp,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Example expected response:
        // {
        //   "is_verified": true,
        //   "otp_id": 123,
        //   "message": "OTP verified successfully"
        // }

        final isVerified = data['is_verified'] == true;
        final otpId = data['otp_id'] is int
            ? data['otp_id'] as int
            : event.otpId; // fallback to event.otpId
        final message = data['message']?.toString() ?? '';

        if (isVerified) {
          // ✅ Emit state with OTP ID
          emit(OtpVerified(otpId: otpId, message: message));
        } else {
          emit(OtpFailure(message.isNotEmpty
              ? message
              : 'OTP verification failed.'));
        }
      } else {
        emit(OtpFailure('Server error: ${response.statusCode}'));
      }
    } catch (e) {
      emit(const OtpFailure('Something went wrong while verifying OTP.'));
    }
  }

  Future<void> _onOtpResend(
    OtpResendRequested event,
    Emitter<OtpVerificationState> emit,
  ) async {
    // TODO: Call resend OTP API if available
    await Future.delayed(const Duration(seconds: 1));
  }
}
