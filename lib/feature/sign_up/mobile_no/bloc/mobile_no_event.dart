import 'package:equatable/equatable.dart';

abstract class MobileNoEvent extends Equatable {
  const MobileNoEvent();

  @override
  List<Object> get props => [];
}

class MobileNoSubmitted extends MobileNoEvent {
  final String mobileNumber;

  const MobileNoSubmitted(this.mobileNumber);

  @override
  List<Object> get props => [mobileNumber];
}
