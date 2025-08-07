// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'mobile_no_event.dart';
// part 'mobile_no_state.dart';

// class MobileNoBloc extends Bloc<MobileNoEvent, MobileNoState> {
//   MobileNoBloc() : super(MobileNoInitial()) {
//     on<MobileNoEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'mobile_no_event.dart';
// import 'mobile_no_state.dart';

// class MobileNoBloc extends Bloc<MobileNoEvent, MobileNoState> {
//   MobileNoBloc() : super(MobileNoInitial()) {
//     on<MobileNoSubmitted>(_onMobileNoSubmitted);
//   }

//   Future<void> _onMobileNoSubmitted(
//     MobileNoSubmitted event,
//     Emitter<MobileNoState> emit,
//   ) async {
//     emit(MobileNoLoading());

//     try {
//       // Simulate API call or backend validation
//       await Future.delayed(const Duration(seconds: 2));

//       // Assume success
//       emit(MobileNoSuccess());
//     } catch (e) {
//       emit(MobileNoFailure('Failed to verify mobile number'));
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'mobile_no_event.dart';
import 'mobile_no_state.dart';

class MobileNoBloc extends Bloc<MobileNoEvent, MobileNoState> {
  MobileNoBloc() : super(MobileNoInitial()) {
    on<MobileNoSubmitted>(_onMobileNoSubmitted);
  }

  Future<void> _onMobileNoSubmitted(
    MobileNoSubmitted event,
    Emitter<MobileNoState> emit,
  ) async {
    emit(MobileNoLoading());

    try {
      final url = Uri.parse('http://192.168.0.53:8070/otp/send'); // 🔁 Replace with your actual URL
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobileno': event.mobileNumber}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(MobileNoSuccess(
          mobileNo: data['mobileno'] as String,
          otpId: data['otp_id'] as int,
        ));
      } else {
        emit(MobileNoFailure('OTP request failed with code ${response.statusCode}.'));
      }
    } catch (e) {
      emit(MobileNoFailure('Failed to send OTP. Please check your connection.'));
    }
  }
}
