import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/constant/logo_constant.dart';
import 'package:bangladesh_finance_ekyc/core/constant/regex_constant.dart';
import 'package:bangladesh_finance_ekyc/core/helper/url_launcher_helper.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/login/bloc/login_bloc.dart';
import 'package:bangladesh_finance_ekyc/widget/common/long_button_widget.dart';
import 'package:bangladesh_finance_ekyc/widget/common/vertical_spacer_small_widget.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: const LoginPage(),
    );
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authFormKey = GlobalKey<FormState>();
  late FocusNode _phoneNoFocusNode;
  late FocusNode _pinFocusNode;
  late TextEditingController _phoneNoController;
  late TextEditingController _pinController;
  bool _isPinVisible = false;

  void _onTapProceed(String phoneNo) {
    if (_authFormKey.currentState!.validate()) {
      _phoneNoFocusNode.unfocus();
    }
  }

  void _onTapRegister() {
    _unfocusKeyboard();
    NavigatorUtil.pushNamed(AppRoute.mobileNo);
  }

  void _unfocusKeyboard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    _phoneNoController = TextEditingController();
    _pinController = TextEditingController();
    _phoneNoFocusNode = FocusNode();
    _pinFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _phoneNoController.dispose();
    _pinController.dispose();
    _phoneNoFocusNode.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  void _showForgotOptionsSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      sheetAnimationStyle: const AnimationStyle(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: AppStyle.paddingAllSmall,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.help_outline, color: ColorConstant.primary, size: 40),
              const VerticalSpacerSmallWidget(),
              Text(
                'Forgot ID or PIN?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Please select an option below to recover your account.',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const VerticalSpacerSmallWidget(),
              ListTile(
                leading: const Icon(Icons.person_search, color: ColorConstant.primary),
                title: Text('Forgot ID', style: Theme.of(context).textTheme.labelLarge),
                trailing: const Icon(Icons.arrow_forward_ios_outlined, color: ColorConstant.primary, size: 18),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lock_open, color: ColorConstant.primary),
                title: Text('Forgot PIN', style: Theme.of(context).textTheme.labelLarge),
                trailing: const Icon(Icons.arrow_forward_ios_outlined, color: ColorConstant.primary, size: 18),
                onTap: () {},
              ),
              const VerticalSpacerSmallWidget(),
              const VerticalSpacerSmallWidget(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _unfocusKeyboard,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: bodyHeight,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      // Add auth success/failure logic here if needed
                    },
                    builder: (context, state) {
                      return const SizedBox.shrink(); // Placeholder
                    },
                  ),
                  Image.asset(
                    LogoConstant.bflLogoColor,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                    width: 200,
                  ),
                  const VerticalSpacerSmallWidget(),
                  Text('Welcome', style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    'Please enter your mobile number and PIN',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const VerticalSpacerSmallWidget(),
                  Form(
                    key: _authFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: AppStyle.paddingHorizontalSmall,
                          width: 350,
                          child: TextFormField(
                            controller: _phoneNoController,
                            focusNode: _phoneNoFocusNode,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_pinFocusNode),
                            keyboardType: TextInputType.phone,
                            keyboardAppearance: Brightness.dark,
                            decoration: AppStyle.buildTextFormFieldDecoration(
                              prefixIcon: Icons.mobile_friendly_rounded,
                              hintText: 'Mobile Number',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Mobile number is required.';
                              if (!RegExp(RegexConstant.bdMobileNo).hasMatch(value)) {
                                return 'Invalid mobile number.';
                              }
                              return null;
                            },
                          ),
                        ),
                        const VerticalSpacerSmallWidget(),
                        Container(
                          padding: AppStyle.paddingHorizontalSmall,
                          width: 350,
                          child: TextFormField(
                            controller: _pinController,
                            focusNode: _pinFocusNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            obscureText: !_isPinVisible,
                            decoration: AppStyle.buildTextFormFieldDecoration(
                              prefixIcon: Icons.pin,
                              hintText: 'PIN',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPinVisible ? Icons.visibility : Icons.visibility_off,
                                  color: ColorConstant.primary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPinVisible = !_isPinVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'PIN is required.';
                              if (value.length < 4) return 'PIN must be at least 4 digits.';
                              return null;
                            },
                          ),
                        ),
                        const VerticalSpacerSmallWidget(),
                      ],
                    ),
                  ),
                  Container(
                    width: 350,
                    padding: AppStyle.paddingHorizontalSmall,
                    child: GestureDetector(
                      onTap: _showForgotOptionsSheet,
                      child: const Row(
                        children: [
                          Text(
                            'Forgot ID or PIN?',
                            style: TextStyle(
                              color: ColorConstant.primary,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorConstant.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpacerSmallWidget(),
                  Container(
                    width: 350,
                    padding: AppStyle.paddingHorizontalSmall,
                    child: BouncingWidget(
                      onPressed: () => _onTapProceed(_phoneNoController.text),
                      child: const LongButtonWidget(title: 'Login'),
                    ),
                  ),
                  const VerticalSpacerSmallWidget(),
                  Text(
                    "Don't have an account?",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorConstant.disabled),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: _onTapRegister,
                    child: const Text('Sign Up Now'),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// ✅ Bottom bar in SafeArea
        bottomNavigationBar: SafeArea(
          minimum: AppStyle.paddingAllSmall as EdgeInsets,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.explore_outlined),
                label: const Text('Products'),
              ),
              TextButton.icon(
                onPressed: () => UrlLauncherHelper.makePhoneCall('16727'),
                icon: const Icon(Icons.call),
                label: const Text('16727'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
