import 'package:equatable/equatable.dart';

abstract class ScannedDataEvent extends Equatable {
  const ScannedDataEvent();

  @override
  List<Object?> get props => [];
}

class ScannedDataInitialized extends ScannedDataEvent {
  final Map<String, String> data;

  const ScannedDataInitialized(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateScannedDataField extends ScannedDataEvent {
  final String fieldKey;
  final String newValue;

  const UpdateScannedDataField({required this.fieldKey, required this.newValue});

  @override
  List<Object?> get props => [fieldKey, newValue];
}
