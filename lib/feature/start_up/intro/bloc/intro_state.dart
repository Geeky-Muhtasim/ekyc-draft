part of 'intro_bloc.dart';

@immutable
sealed class IntroState extends Equatable {
  const IntroState({required this.currentPage, required this.isLastPage});
  final int currentPage;
  final bool isLastPage;

  @override
  List<Object?> get props => [currentPage, isLastPage];
}

final class IntroInitial extends IntroState {
  const IntroInitial() : super(currentPage: 0, isLastPage: false);
}

final class IntroUpdated extends IntroState {
  const IntroUpdated({required super.currentPage, required super.isLastPage});
}

final class IntroCompleted extends IntroState {
  const IntroCompleted() : super(currentPage: 1, isLastPage: true);
}
