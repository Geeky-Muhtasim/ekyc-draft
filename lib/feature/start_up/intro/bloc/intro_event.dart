part of 'intro_bloc.dart';

@immutable
sealed class IntroEvent {}

class IntroPageChanged extends IntroEvent {
  IntroPageChanged({required this.pageIndex});
  final int pageIndex;
}

class IntroNextPressed extends IntroEvent {
  IntroNextPressed();
}
