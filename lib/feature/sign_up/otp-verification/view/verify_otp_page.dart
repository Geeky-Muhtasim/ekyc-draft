import 'dart:async';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/otp-verification/bloc/otp_verification_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/otp-verification/bloc/otp_verification_event.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/otp-verification/bloc/otp_verification_state.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:bangladesh_finance_ekyc/widget/common/vertical_spacer_small_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';

class VerifyOtpPage extends StatefulWidget {
  final String phoneNo;
  final int otpId;

  const VerifyOtpPage({required this.phoneNo, required this.otpId, super.key});

  static Widget builder(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final phoneNo = args['mobileNo'];
    final otpId = args['otpId'];

    return BlocProvider<OtpVerificationBloc>(
      create: (_) => OtpVerificationBloc(),
      child: VerifyOtpPage(phoneNo: phoneNo as String, otpId: otpId as int),
    );
  }

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}
 
class _VerifyOtpPageState extends State<VerifyOtpPage>
    with TickerProviderStateMixin {
  final _otpFormKey = GlobalKey<FormState>();
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;

  int _resendSeconds = 60;
  Timer? _timer;
  bool _isOtpValid = false;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
    _startResendTimer();

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _shakeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.025, 0),
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);
  }

  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  void _validateOtpFields() {
    final isValid = _otpControllers.every(
      (controller) =>
          controller.text.trim().length == 1 &&
          RegExp(r'^[0-9]$').hasMatch(controller.text.trim()),
    );

    if (_isOtpValid != isValid) {
      setState(() {
        _isOtpValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight =
        MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Verify OTP',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SizedBox(
            height: bodyHeight,
            width: double.infinity,
            child: Column(
              children: [
                // BlocListener<OtpVerificationBloc, OtpVerificationState>(
                //   listener: (context, state) {
                //     if (state is OtpVerified) {
                //       NavigatorUtil.pushNamed(AppRoute.nidScan);
                //     } else if (state is OtpFailure) {
                //       _shakeController.forward(from: 0);
                //       setState(() => _showError = true);
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text(state.error)),
                //       );
                //     }
                //   },
                //   child: const SizedBox.shrink(),
                // ),
                BlocListener<OtpVerificationBloc, OtpVerificationState>(
                  listener: (context, state) {
                    if (state is OtpVerified) {
                      SignupState().otpId = state.otpId; // persist OTP ID
                      print('OTP Verified! SignupState: ${SignupState()}');
                      NavigatorUtil.pushNamed(AppRoute.nidScan);
                    } else if (state is OtpFailure) {
                      _shakeController.forward(from: 0);
                      setState(() => _showError = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
                GlowingStepProgressIndicatorWidget(
                  currentStep: 2,
                  totalSteps: 7,
                  progressColor: Theme.of(context).primaryColor,
                ),
                const VerticalSpacerSmallWidget(),
                const SizedBox(height: 20),
                Text(
                  'An SMS with OTP has been sent to',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  widget.phoneNo,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _otpFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SlideTransition(
                      position: _shakeAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 40,
                            child: TextFormField(
                              controller: _otpControllers[index],
                              focusNode: _focusNodes[index],
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                counterText: '',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: _showError
                                        ? Colors.red
                                        : Colors.blue,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: _showError
                                        ? Colors.red
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  _focusNodes[index + 1].requestFocus();
                                } else if (value.isEmpty && index > 0) {
                                  _focusNodes[index - 1].requestFocus();
                                }
                                _validateOtpFields();
                                setState(() => _showError = false);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) return ' ';
                                if (!RegExp(r'^[0-9]$').hasMatch(value)) {
                                  return ' ';
                                }
                                return null;
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _resendSeconds == 0
                      ? () {
                          setState(() => _resendSeconds = 60);
                          _startResendTimer();
                          context.read<OtpVerificationBloc>().add(
                            OtpResendRequested(phone: widget.phoneNo),
                          );
                        }
                      : null,
                  child: Text(
                    'Resend OTP? ${_resendSeconds > 0 ? '00:${_resendSeconds.toString().padLeft(2, '0')}' : 'Tap here'}',
                    style: TextStyle(
                      color: _resendSeconds > 0
                          ? Colors.red
                          : Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 90, 
            child: BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
              builder: (context, state) {
                final isLoading = state is OtpLoading;
                return ElevatedButton(
                  onPressed: _isOtpValid && !isLoading
                      ? () {
                          if (_otpFormKey.currentState!.validate()) {
                            final otp = _otpControllers
                                .map((e) => e.text)
                                .join();
                            context.read<OtpVerificationBloc>().add(
                              OtpSubmitted(otpId: widget.otpId, otp: otp),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isOtpValid
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade400,
                    disabledBackgroundColor: Colors.grey.shade400,
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Verify',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: Colors.white),
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
