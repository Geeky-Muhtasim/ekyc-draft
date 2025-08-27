// abstract class HomeEvent {}

// class LoadHomeMenuEvent extends HomeEvent {}

// class SaveServiceTypeEvent extends HomeEvent {
//   final String serviceTypeId;

//   SaveServiceTypeEvent({required this.serviceTypeId});
// }
abstract class HomeEvent {}

class LoadHomeMenuEvent extends HomeEvent {}

class SaveServiceTypeEvent extends HomeEvent {
  final String serviceTypeId; // "I" or "C"
  SaveServiceTypeEvent({required this.serviceTypeId});
}
