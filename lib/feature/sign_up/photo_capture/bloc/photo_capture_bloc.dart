import 'package:flutter_bloc/flutter_bloc.dart';
import 'photo_capture_event.dart';
import 'photo_capture_state.dart';

class PhotoCaptureBloc extends Bloc<PhotoCaptureEvent, PhotoCaptureState> {
  PhotoCaptureBloc() : super(const PhotoCaptureState()) {
    on<MarkInstructionsAcknowledged>(_onAcknowledged);
  }

  void _onAcknowledged(
    MarkInstructionsAcknowledged event,
    Emitter<PhotoCaptureState> emit,
  ) {
    emit(state.copyWith(instructionsAcknowledged: true));
  }
}
