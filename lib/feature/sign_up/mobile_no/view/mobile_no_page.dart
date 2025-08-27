// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/constant/regex_constant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/bloc/mobile_no_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/bloc/mobile_no_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/bloc/mobile_no_state.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/vertical_spacer_small_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MobileNoPage extends StatefulWidget {
//   const MobileNoPage({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider<MobileNoBloc>(
//       create: (context) => MobileNoBloc(),
//       child: const MobileNoPage(),
//     );
//   }

//   @override
//   State<MobileNoPage> createState() => _MobileNoPageState();
// }

// class _MobileNoPageState extends State<MobileNoPage> {
//   final _signUpMobileNoFormKey = GlobalKey<FormState>();
//   late TextEditingController _phoneNoController;

//   @override
//   void initState() {
//     super.initState();
//     _phoneNoController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _phoneNoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bodyHeight =
//         MediaQuery.of(context).size.height -
//         AppBar().preferredSize.height -
//         MediaQuery.of(context).padding.top;

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: Text(
//             'Sign Up',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: SizedBox(
//             height: bodyHeight,
//             width: double.infinity,
//             child: Column(
//               children: [
//                 BlocConsumer<MobileNoBloc, MobileNoState>(
//                   // listener: (context, state) {
//                   //   if (state is MobileNoSuccess) {
//                   //     NavigatorUtil.pushNamed(
//                   //       AppRoute.verifyOtp,
//                   //       arguments: _phoneNoController.text,
//                   //     );
//                   //   } else if (state is MobileNoFailure) {
//                   //     ScaffoldMessenger.of(context).showSnackBar(
//                   //       SnackBar(content: Text(state.error)),
//                   //     );
//                   //   }
//                   // },
//                   listener: (context, state) {
//                     if (state is MobileNoSuccess) {
//                       NavigatorUtil.pushNamed(
//                         AppRoute.verifyOtp,
//                         arguments: {
//                           'mobileNo': state.mobileNo,
//                           'otpId': state.otpId,
//                         },
//                       );
//                     } else if (state is MobileNoFailure) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(state.error)),
//                       );
//                     }
//                   },
//                   builder: (context, state) {
//                     return state is MobileNoLoading
//                         ? const LinearProgressIndicator()
//                         : const SizedBox.shrink();
//                   },
//                 ),
//                 GlowingStepProgressIndicatorWidget(
//                   currentStep: 1,
//                   totalSteps: 5,
//                   progressColor: Theme.of(context).primaryColor,
//                 ),
//                 const VerticalSpacerSmallWidget(),
//                 Container(
//                   width: double.infinity,
//                   padding: AppStyle.paddingHorizontalSmall,
//                   child: Text(
//                     'Verify Mobile Number',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   padding: AppStyle.paddingHorizontalSmall,
//                   child: Text(
//                     'Please enter your mobile number to verify your account.',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ),
//                 const VerticalSpacerSmallWidget(),
//                 Form(
//                   key: _signUpMobileNoFormKey,
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: AppStyle.paddingHorizontalSmall,
//                         child: TextFormField(
//                           controller: _phoneNoController,
//                           textInputAction: TextInputAction.done,
//                           keyboardType: TextInputType.phone,
//                           keyboardAppearance: Brightness.dark,
//                           decoration: AppStyle.buildTextFormFieldDecoration(
//                             prefixIcon: Icons.mobile_friendly_rounded,
//                             hintText: 'Mobile Number',
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Mobile number is required.';
//                             }
//                             if (!RegExp(
//                               RegexConstant.bdMobileNo,
//                             ).hasMatch(value)) {
//                               return 'Invalid mobile number.';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const VerticalSpacerSmallWidget(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: SafeArea(
//           child: Container(
//             padding: AppStyle.paddingAllSmall,
//             height: 90,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_signUpMobileNoFormKey.currentState!.validate()) {
//                   context.read<MobileNoBloc>().add(
//                     MobileNoSubmitted(_phoneNoController.text),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).primaryColor,
//               ),
//               child: Text(
//                 'Next',
//                 style: Theme.of(context).textTheme.labelLarge!.copyWith(
//                   color: ColorConstant.foreground,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/constant/regex_constant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/bloc/mobile_no_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/bloc/mobile_no_event.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/bloc/mobile_no_state.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:bangladesh_finance_ekyc/widget/common/vertical_spacer_small_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🔗 NEW: pull in the two singletons
import 'package:bangladesh_finance_ekyc/shared/state/product_selection_state.dart';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';

class MobileNoPage extends StatefulWidget {
  const MobileNoPage({super.key});

  static Widget builder(BuildContext context) {
    // ✅ Freeze the product snapshot the moment eKYC starts
    final productJson = ProductSelectionState().toApiJson();
    SignupState().attachProductSelection(productJson);
    debugPrint('📦 [MobileNo] Frozen product snapshot: $productJson');

    return BlocProvider<MobileNoBloc>(
      create: (context) => MobileNoBloc(),
      child: const MobileNoPage(),
    );
  }

  @override
  State<MobileNoPage> createState() => _MobileNoPageState();
}

class _MobileNoPageState extends State<MobileNoPage> {
  final _signUpMobileNoFormKey = GlobalKey<FormState>();
  late TextEditingController _phoneNoController;

  @override
  void initState() {
    super.initState();
    _phoneNoController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNoController.dispose();
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Sign Up',
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
                BlocConsumer<MobileNoBloc, MobileNoState>(
                  listener: (context, state) {
                    if (state is MobileNoSuccess) {
                      // ✅ Persist OTP id (and optionally mobile if you later add it to SignupState)
                      SignupState().otpId = state.otpId;
                      debugPrint('✅ [MobileNo] Persisted otpId=${state.otpId}');

                      NavigatorUtil.pushNamed(
                        AppRoute.verifyOtp,
                        arguments: {
                          'mobileNo': state.mobileNo,
                          'otpId': state.otpId,
                        },
                      );
                    } else if (state is MobileNoFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is MobileNoLoading
                        ? const LinearProgressIndicator()
                        : const SizedBox.shrink();
                  },
                ),
                GlowingStepProgressIndicatorWidget(
                  currentStep: 1,
                  totalSteps: 5,
                  progressColor: Theme.of(context).primaryColor,
                ),
                const VerticalSpacerSmallWidget(),
                Container(
                  width: double.infinity,
                  padding: AppStyle.paddingHorizontalSmall,
                  child: Text(
                    'Verify Mobile Number',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: AppStyle.paddingHorizontalSmall,
                  child: Text(
                    'Please enter your mobile number to verify your account.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const VerticalSpacerSmallWidget(),
                Form(
                  key: _signUpMobileNoFormKey,
                  child: Column(
                    children: [
                      Container(
                        padding: AppStyle.paddingHorizontalSmall,
                        child: TextFormField(
                          controller: _phoneNoController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          keyboardAppearance: Brightness.dark,
                          decoration: AppStyle.buildTextFormFieldDecoration(
                            prefixIcon: Icons.mobile_friendly_rounded,
                            hintText: 'Mobile Number',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Mobile number is required.';
                            }
                            if (!RegExp(
                              RegexConstant.bdMobileNo,
                            ).hasMatch(value)) {
                              return 'Invalid mobile number.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const VerticalSpacerSmallWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: AppStyle.paddingAllSmall,
            height: 90,
            child: ElevatedButton(
              onPressed: () {
                if (_signUpMobileNoFormKey.currentState!.validate()) {
                  context.read<MobileNoBloc>().add(
                    MobileNoSubmitted(_phoneNoController.text),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Next',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: ColorConstant.foreground,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
