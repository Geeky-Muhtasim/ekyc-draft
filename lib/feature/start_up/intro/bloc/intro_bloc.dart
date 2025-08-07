import 'package:bangladesh_finance_ekyc/core/constant/lottie_constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(const IntroInitial()) {
    on<IntroPageChanged>(_onPageChanged);
    on<IntroNextPressed>(_onNextPressed);
  }

  List<Map<String, String>> get introData => [
    {
      'lottie': LottieConstant.intro1,
      'title': 'Welcome to Your Financial Partner',
      'desc':
          'Access personalized financial services anytime, right from your phone.',
    },
    {
      'lottie': LottieConstant.intro2,
      'title': 'Smart Account Management',
      'desc':
          'Easily track deposits, loans, and statements with real-time updates.',
    },
    {
      'lottie': LottieConstant.intro3,
      'title': 'Secure. Simple. Seamless.',
      'desc':
          'Enjoy a safe, user-friendly experience built for your financial growth.',
    },
  ];
  int get totalPages => introData.length;

  void _onPageChanged(IntroPageChanged event, Emitter<IntroState> emit) {
    final isLast = event.pageIndex == totalPages - 1;
    emit(IntroUpdated(currentPage: event.pageIndex, isLastPage: isLast));
  }

  void _onNextPressed(IntroNextPressed event, Emitter<IntroState> emit) {
    if (state.isLastPage) {
      emit(const IntroCompleted());
    } else {
      final nextPage = state.currentPage + 1;
      final isLast = nextPage == totalPages - 1;
      emit(IntroUpdated(currentPage: nextPage, isLastPage: isLast));
    }
  }
}
