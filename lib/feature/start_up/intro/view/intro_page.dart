import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/start_up/intro/bloc/intro_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    hide SlideEffect;

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<IntroBloc>(
      create: (BuildContext context) => IntroBloc(),
      child: const IntroPage(),
    );
  }

  void _onTapSkip() {
    NavigatorUtil.pushNamed(AppRoute.home);
    
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final introBloc = context.read<IntroBloc>();
    final introData = introBloc.introData;

    return BlocListener<IntroBloc, IntroState>(
      listenWhen: (previous, current) =>
          current is IntroCompleted ||
          previous.currentPage != current.currentPage,
      listener: (BuildContext context, IntroState state) {
        if (state is IntroCompleted) {
          NavigatorUtil.pushNamed(AppRoute.home);
        } else {
          pageController.animateToPage(
            state.currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: introData.length,
                    onPageChanged: (int index) => context.read<IntroBloc>().add(
                      IntroPageChanged(pageIndex: index),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final data = introData[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 40,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Lottie.asset(
                                data['lottie']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              data['title']!,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ).animate().fadeIn().slideY(begin: 0.5, end: 0),
                            const SizedBox(height: 12),
                            Text(
                              data['desc']!,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ).animate().fadeIn().slideY(begin: 0.5, end: 0),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: BlocBuilder<IntroBloc, IntroState>(
                    builder: (BuildContext context, IntroState state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: _onTapSkip,
                            child: const Text('Skip'),
                          ),
                          SmoothPageIndicator(
                            controller: pageController,
                            count: introData.length,
                            effect: ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              final bloc = context.read<IntroBloc>();
                              final state = bloc.state;

                              if (state.isLastPage) {
                                NavigatorUtil.pushNamed(
                                  AppRoute.home,
                                );
                              } else {
                                bloc.add(IntroNextPressed());
                              }
                            },
                            child: const Text('Next'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
