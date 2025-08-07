// // part of 'mobile_no_bloc.dart';

// // @immutable
// // sealed class MobileNoState {}

// // final class MobileNoInitial extends MobileNoState {}
// import 'package:equatable/equatable.dart';

// abstract class MobileNoState extends Equatable {
//   const MobileNoState();

//   @override
//   List<Object> get props => [];
// }

// class MobileNoInitial extends MobileNoState {}

// class MobileNoLoading extends MobileNoState {}

// class MobileNoSuccess extends MobileNoState {}

// class MobileNoFailure extends MobileNoState {
//   final String error;

//   const MobileNoFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }

import 'package:equatable/equatable.dart';

abstract class MobileNoState extends Equatable {
  const MobileNoState();

  @override
  List<Object> get props => [];
}

class MobileNoInitial extends MobileNoState {}

class MobileNoLoading extends MobileNoState {}

class MobileNoSuccess extends MobileNoState {
  final String mobileNo;
  final int otpId;

  const MobileNoSuccess({required this.mobileNo, required this.otpId});

  @override
  List<Object> get props => [mobileNo, otpId];
}

class MobileNoFailure extends MobileNoState {
  final String error;

  const MobileNoFailure(this.error);

  @override
  List<Object> get props => [error];
}
