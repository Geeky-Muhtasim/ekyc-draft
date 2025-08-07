import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:flutter/material.dart';

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key});

  static Widget builder(BuildContext context) => const SetPasswordPage();

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordMatching = false;

  void _checkPasswordMatch() {
    setState(() {
      _isPasswordMatching =
          _passwordController.text == _confirmPasswordController.text &&
              _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Set Password'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), // Back arrow icon
          onPressed: () => Navigator.of(context).pop(), // Go back on tap
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const GlowingStepProgressIndicatorWidget(
                currentStep: 7,
                totalSteps: 7,
                progressColor: ColorConstant.primary,
              ),
              const SizedBox(height: 24),

              /// Icon
              const Icon(
                Icons.password_rounded,
                size: 100,
                color: ColorConstant.primary,
              ),

              const SizedBox(height: 24),

              /// Title
              const Text(
                'Set Your Password',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),

              const SizedBox(height: 32),

              /// Password Fields
              Padding(
                padding: AppStyle.paddingHorizontalLarge,
                child: Column(
                  children: [
                    /// Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: 'Password',
                      ),
                      onChanged: (_) => _checkPasswordMatch(),
                    ),
                    const SizedBox(height: 20),

                    /// Confirm Password
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        labelText: 'Confirm Password',
                        suffixIcon: _isPasswordMatching
                            ? const Icon(Icons.check,
                                color: Colors.green, size: 20)
                            : null,
                      ),
                      onChanged: (_) => _checkPasswordMatch(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// Submit Button
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
                    onPressed: _isPasswordMatching
                        ? () {
                            NavigatorUtil.pushNamed(
                              AppRoute.registrationSuccess,
                            );
                          }
                        : null,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
