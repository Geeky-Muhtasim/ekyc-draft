import 'package:equatable/equatable.dart';

class ScannedDataState extends Equatable {
  final Map<String, String> extractedData;

  const ScannedDataState({
    this.extractedData = const {
      'nid': '',
      'nameEn': '',
      'nameBn': '',
      'fatherBn': '',
      'motherBn': '',
      'dob': '',
      'presentAddress': '',
      'permanentAddress': '',
    },
  });

  ScannedDataState copyWith({Map<String, String>? extractedData}) {
    return ScannedDataState(
      extractedData: extractedData ?? this.extractedData,
    );
  }

  @override
  List<Object?> get props => [extractedData];
}
