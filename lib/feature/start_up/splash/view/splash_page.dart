import 'package:bangladesh_finance_ekyc/core/constant/image_constant.dart';
import 'package:bangladesh_finance_ekyc/core/constant/logo_constant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/start_up/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc(),
      child: const SplashPage(),
    );
  }

  void _startDelayedNavigation() {
    Future.delayed(const Duration(seconds: 2), () {
      NavigatorUtil.popAndPushNamed(AppRoute.intro);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Start navigation delay after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startDelayedNavigation();
    });

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light, // sets status bar icons to white
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            /// Background SVG
            Positioned.fill(
              child: SvgPicture.asset(
                ImageConstant.bflSplashBackground,
                fit: BoxFit.cover,
              ),
            ),

            /// Animated Logo + Slogan
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Slide up logo with easeOutBack curve
                    Image.asset(
                          LogoConstant.bflLogoWhite,
                          width: 200,
                        )
                        .animate()
                        .slideY(
                          begin: 1,
                          end: 0,
                          duration: 1.seconds,
                          curve: Curves.easeOutBack,
                        )
                        .fadeIn(duration: 1.seconds),

                    const SizedBox(height: 24),

                    /// Fade-in + slight upward move for slogan
                    SvgPicture.asset(
                          LogoConstant.bflSlogan,
                          width: 120,
                          color: Colors.white,
                        )
                        .animate()
                        .fadeIn(duration: 800.ms, delay: 0.5.seconds)
                        .slideY(begin: 0.2, end: 0, duration: 600.ms),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
