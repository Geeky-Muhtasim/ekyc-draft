import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'photo_preview_event.dart';
import 'photo_preview_state.dart';

class PhotoPreviewBloc extends Bloc<PhotoPreviewEvent, PhotoPreviewState> {
  PhotoPreviewBloc() : super(const PhotoPreviewState()) {
    on<LoadCapturedPhoto>(_onLoadCapturedPhoto);
    on<ConfirmPhoto>(_onConfirmPhoto);
  }

  void _onLoadCapturedPhoto(
    LoadCapturedPhoto event,
    Emitter<PhotoPreviewState> emit,
  ) {
    emit(state.copyWith(photo: event.photo));
  }

  void _onConfirmPhoto(
    ConfirmPhoto event,
    Emitter<PhotoPreviewState> emit,
  ) {
    emit(state.copyWith(isConfirmed: true));
  }
}
