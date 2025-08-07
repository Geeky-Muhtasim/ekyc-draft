// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'nid_scan_event.dart';
// import 'nid_scan_state.dart';

// class NidScanBloc extends Bloc<NidScanEvent, NidScanState> {
//   NidScanBloc() : super(const NidScanState()) {
//     on<NidFrontCaptured>(_onFrontCaptured);
//     on<NidBackCaptured>(_onBackCaptured);
//   }

//   void _onFrontCaptured(NidFrontCaptured event, Emitter<NidScanState> emit) {
//     emit(state.copyWith(frontImagePath: event.imagePath));
//   }

//   void _onBackCaptured(NidBackCaptured event, Emitter<NidScanState> emit) {
//     emit(state.copyWith(backImagePath: event.imagePath));
//   }
// }

import 'dart:convert';

import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'nid_scan_event.dart';
import 'nid_scan_state.dart';

class NidScanBloc extends Bloc<NidScanEvent, NidScanState> {
  NidScanBloc() : super(const NidScanState()) {
    on<NidFrontCaptured>(_onFrontCaptured);
    on<NidBackCaptured>(_onBackCaptured);
    on<NidUploadSubmitted>(_onUploadSubmitted); // ⬅ Add
  }

  void _onFrontCaptured(NidFrontCaptured event, Emitter<NidScanState> emit) {
    emit(state.copyWith(frontImagePath: event.imagePath));
  }

  void _onBackCaptured(NidBackCaptured event, Emitter<NidScanState> emit) {
    emit(state.copyWith(backImagePath: event.imagePath));
  }

  Future<void> _onUploadSubmitted(
    NidUploadSubmitted event,
    Emitter<NidScanState> emit,
  ) async {
    final frontPath = state.frontImagePath;
    final backPath = state.backImagePath;

    if (frontPath == null || backPath == null) return;

    final uri = Uri.parse('http://192.168.0.53:8070/photo-report/upload-nid');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
        'nid_front_photo',
        frontPath,
        contentType: MediaType.parse(lookupMimeType(frontPath) ?? 'image/jpeg'),
      ))
      ..files.add(await http.MultipartFile.fromPath(
        'nid_back_photo',
        backPath,
        contentType: MediaType.parse(lookupMimeType(backPath) ?? 'image/jpeg'),
      ));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);
        final trackingNo = responseJson['tracking_no'] as int?;
        if (trackingNo != null) {
            SignupState().photoId = trackingNo;
             print("✅ Photo ID persisted: ${SignupState().photoId}");

          }
        emit(state.copyWith(trackingNo: trackingNo, isUploaded: true));
      } else {
        throw Exception('Upload failed');
      }
    } catch (e) {
      print('NID upload error: $e');
    }
  }
}
