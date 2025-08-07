import 'package:bloc/bloc.dart';
import 'scanned_data_event.dart';
import 'scanned_data_state.dart';

class ScannedDataBloc extends Bloc<ScannedDataEvent, ScannedDataState> {
  ScannedDataBloc() : super(const ScannedDataState()) {
    on<ScannedDataInitialized>(_onScannedDataInitialized);
    on<UpdateScannedDataField>(_onUpdateScannedDataField);
  }

  void _onScannedDataInitialized(
    ScannedDataInitialized event,
    Emitter<ScannedDataState> emit,
  ) {
    emit(state.copyWith(extractedData: event.data));
  }

  void _onUpdateScannedDataField(
    UpdateScannedDataField event,
    Emitter<ScannedDataState> emit,
  ) {
    final updatedMap = Map<String, String>.from(state.extractedData);
    updatedMap[event.fieldKey] = event.newValue;

    emit(state.copyWith(extractedData: updatedMap));
  }
}
