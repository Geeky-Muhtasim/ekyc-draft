import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the preferred orientations to portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Set the status bar color to primary color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: ColorConstant.primary,
      ),
    );

    return GlobalLoaderOverlay(
      duration: Durations.medium4,
      reverseDuration: Durations.medium4,
      overlayColor: Colors.grey.withValues(alpha: 0.8),
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return const Center(
          child: SpinKitCubeGrid(
            color: ColorConstant.primary,
          ),
        );
      },
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: ColorConstant.primary,
            primary: ColorConstant.primary,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoute.initial,
        // initialRoute: AppRoute.nomineeInfo,
        onGenerateRoute: AppRoute.onGenerateRoute,
        routes: AppRoute.routes,
        navigatorKey: NavigatorUtil.navigatorKey,
      ),
    );
  }
}
