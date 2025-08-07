// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart'; // Contains color constants
// import 'package:bangladesh_finance_ekyc/core/constant/regex_constant.dart'; // Contains regex patterns (e.g., for mobile number validation)
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart'; // Contains app-wide styling, padding, decorations, etc.
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/mobile_no/bloc/mobile_no_bloc.dart'; // BLoC (Business Logic Component) for mobile number step
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart'; // Widget to show step progress
// import 'package:bangladesh_finance_ekyc/widget/common/vertical_spacer_small_widget.dart'; // Small vertical space widget
// import 'package:flutter/material.dart'; // Core Flutter UI toolkit
// import 'package:flutter_bloc/flutter_bloc.dart'; // BLoC state management package

// // The main page for entering mobile number
// class MobileNoPage extends StatefulWidget {
//   const MobileNoPage({super.key});

//   // Static builder to inject BLoC for this page
//   static Widget builder(BuildContext context) {
//     return BlocProvider<MobileNoBloc>(
//       create: (context) => MobileNoBloc(), // Create instance of MobileNoBloc
//       child: const MobileNoPage(), // Provide it to the page
//     );
//   }

//   @override
//   State<MobileNoPage> createState() => _MobileNoPageState(); // Connect to the page state
// }

// class _MobileNoPageState extends State<MobileNoPage> {
//   final _signUpMobileNoFormKey = GlobalKey<FormState>(); // Form key for validation

//   late TextEditingController _phoneNoController; // Controller for mobile number input

//   @override
//   void initState() {
//     super.initState();
//     _phoneNoController = TextEditingController(); // Initialize the controller
//   }

//   @override
//   void dispose() {
//     _phoneNoController.dispose(); // Dispose the controller to free memory
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Calculate body height dynamically excluding AppBar and status bar
//     final bodyHeight =
//         MediaQuery.of(context).size.height -
//         AppBar().preferredSize.height -
//         MediaQuery.of(context).padding.top;

//     return GestureDetector(
//       behavior: HitTestBehavior.translucent, // Allows tap detection outside widgets
//       onTap: () {
//         FocusScope.of(context).unfocus(); // Dismiss keyboard when tapping outside
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           elevation: 0, // No shadow
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new), // Back arrow icon
//             onPressed: () => Navigator.of(context).pop(), // Go back on tap
//           ),
//           title: Text(
//             'Sign Up', // App bar title
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
//                   listener: (context, state) {}, // Listener for state changes (currently empty)
//                   builder: (context, state) {
//                     return Container(); // UI updates based on state (currently not used)
//                   },
//                 ),
//                 GlowingStepProgressIndicatorWidget(
//                   currentStep: 1, // This is step 1
//                   totalSteps: 5, // Out of 5 steps
//                   progressColor: Theme.of(context).primaryColor, // Step color
//                 ),
//                 const VerticalSpacerSmallWidget(), // Vertical spacing
//                 Container(
//                   width: double.infinity,
//                   padding: AppStyle.paddingHorizontalSmall,
//                   child: Text(
//                     'Verify Mobile Number', // Heading
//                     style: Theme.of(context).textTheme.headlineSmall,
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   padding: AppStyle.paddingHorizontalSmall,
//                   child: Text(
//                     'Please enter your mobile number to verify your account.', // Description
//                     style: Theme.of(context).textTheme.bodyMedium,
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//                 const VerticalSpacerSmallWidget(),
//                 Form(
//                   key: _signUpMobileNoFormKey, // Assign form key
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: AppStyle.paddingHorizontalSmall,
//                         width: double.infinity,
//                         child: TextFormField(
//                           controller: _phoneNoController, // Text controller
//                           textInputAction: TextInputAction.done,
//                           onFieldSubmitted: (value) {
//                             FocusScope.of(context).unfocus(); // Dismiss keyboard on submit
//                           },
//                           keyboardType: TextInputType.phone, // Number input
//                           keyboardAppearance: Brightness.dark, // Dark keyboard theme
//                           decoration: AppStyle.buildTextFormFieldDecoration(
//                             prefixIcon: Icons.mobile_friendly_rounded,
//                             hintText: 'Mobile Number',
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Mobile number is required.'; // Validation: empty
//                             }
//                             if (RegExp(
//                                   RegexConstant.bdMobileNo, // Use BD mobile number pattern
//                                 ).hasMatch(value) == false) {
//                               return 'Invalid mobile number.'; // Validation: wrong format
//                             }
//                             return null; // Valid input
//                           },
//                         ),
//                       ),
//                       const VerticalSpacerSmallWidget(), // Spacing below input
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
//                   print('Mobile number: ${_phoneNoController.text}'); // Debug print
//                   NavigatorUtil.pushNamed(
//                     AppRoute.verifyOtp,
//                     arguments: _phoneNoController.text, // Pass mobile number to next screen
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).primaryColor,
//               ),
//               child: Text(
//                 'Next',
//                 style: Theme.of(context).textTheme.labelLarge!.copyWith(
//                       color: ColorConstant.foreground, // Text color on button
//                     ),
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

class MobileNoPage extends StatefulWidget {
  const MobileNoPage({super.key});

  static Widget builder(BuildContext context) {
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
                  // listener: (context, state) {
                  //   if (state is MobileNoSuccess) {
                  //     NavigatorUtil.pushNamed(
                  //       AppRoute.verifyOtp,
                  //       arguments: _phoneNoController.text,
                  //     );
                  //   } else if (state is MobileNoFailure) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(content: Text(state.error)),
                  //     );
                  //   }
                  // },
                  listener: (context, state) {
                    if (state is MobileNoSuccess) {
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
