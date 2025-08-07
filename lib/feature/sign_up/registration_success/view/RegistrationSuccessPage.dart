import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:flutter/material.dart';

class RegistrationSuccessPage extends StatelessWidget {
  const RegistrationSuccessPage({super.key});

  static Widget builder(BuildContext context) =>
      const RegistrationSuccessPage();

  final String userId = '01300984269'; // Replace with dynamic ID if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            /// Logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Image.asset(
                'asset/logo/bfl_logo_color.png', // Replace with your logo path
                width: 180,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 32),

            /// Welcome Texts
            const Text(
              'Welcome to BF fintech App',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorConstant.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Your device is ready for use',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Your User ID is:',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            Text(
              userId,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            /// Go to Login Button
            Padding(
              padding: AppStyle.paddingAllMedium,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    NavigatorUtil.pushNamed(AppRoute.home);
                  },
                  child: const Text(
                    'Go to Home Page',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
