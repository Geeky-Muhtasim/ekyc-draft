import 'package:flutter_bloc/flutter_bloc.dart';
import 'upload_status_event.dart';
import 'upload_status_state.dart';

class UploadStatusBloc extends Bloc<UploadStatusEvent, UploadStatusState> {
  UploadStatusBloc() : super(const UploadStatusState()) {
    on<SetUploadStatusImages>(_onSetImages);
  }

  void _onSetImages(SetUploadStatusImages event, Emitter<UploadStatusState> emit) {
    emit(state.copyWith(
      nidFront: event.nidFront,
      nidBack: event.nidBack,
      photo: event.photo,
      signature: event.signature,
    ));
  }
}
