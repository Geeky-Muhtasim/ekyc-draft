// import 'dart:convert';

// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/bloc/additional_info_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/bloc/additional_info_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/bloc/additional_info_state.dart';
// import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;

// class AdditionalInfoPage extends StatelessWidget {
//   const AdditionalInfoPage({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider(
//       create: (_) => AdditionalInfoBloc(),
//       child: const AdditionalInfoPage(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const _AdditionalInfoView();
//   }
// }

// class _AdditionalInfoView extends StatefulWidget {
//   const _AdditionalInfoView();

//   @override
//   State<_AdditionalInfoView> createState() => _AdditionalInfoViewState();
// }

// class _AdditionalInfoViewState extends State<_AdditionalInfoView> {
//   final _formKey = GlobalKey<FormState>();
//   final tinController = TextEditingController();
//   final religionController = TextEditingController();
//   final netWorthController = TextEditingController();

//   final List<String> divisions = [
//     'Dhaka',
//     'Chittagong',
//     'Khulna',
//     'Sylhet',
//     'Barishal',
//     'Rajshahi',
//     'Rangpur',
//     'Mymensingh',
//   ];
//   final List<String> districts = [
//     'Dhaka',
//     'Cumilla',
//     'Rajshahi',
//     'Khulna',
//     'Sylhet',
//     'Barishal',
//     'Rangpur',
//     'Mymensingh',
//   ];
//   final List<String> thanas = ['Dhanmondi', 'Boalia', 'Kotwali'];
//   final List<String> cities = [
//     'Dhaka City',
//     'Cumilla City',
//     'Khulna City',
//     'Sylhet City',
//     'Barishal City',
//     'Rajshahi City',
//     'Rangpur City',
//     'Mymensingh City',
//   ];

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   context.read<AdditionalInfoBloc>().add(
//   //     UpdateDropdown('country', 'Bangladesh'),
//   //   );
//   // }
//   @override
//   void initState() {
//     super.initState();
//     final bloc = context.read<AdditionalInfoBloc>();
//     bloc.add(FetchDivisions());
//     bloc.add(FetchNetWorths());
//     bloc.add(UpdateDropdown('country', 'Bangladesh'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<AdditionalInfoBloc>();

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text('Additional Info'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         foregroundColor: Colors.black,
//       ),
//       body: BlocBuilder<AdditionalInfoBloc, AdditionalInfoState>(
//         builder: (context, state) {
//           return SafeArea(
//             child: SingleChildScrollView(
//               padding: AppStyle.paddingAllSmall,
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 12),
//                     const GlowingStepProgressIndicatorWidget(
//                       currentStep: 5,
//                       totalSteps: 7,
//                       progressColor: ColorConstant.primary,
//                     ),
//                     const SizedBox(height: 24),
//                     _buildInputField(
//                       'E-TIN or TIN No (Optional)',
//                       tinController,
//                       keyboardType: TextInputType.number,
//                       required: false,
//                       validator: (val) {
//                         if (val != null && val.trim().isNotEmpty) {
//                           final numericRegex = RegExp(r'^[0-9]+$');
//                           return numericRegex.hasMatch(val.trim())
//                               ? null
//                               : 'Only numbers allowed';
//                         }
//                         return null;
//                       },
//                     ),
//                     const Divider(thickness: 1),
//                     _buildInputField(
//                       'Religion (Optional)',
//                       religionController,
//                       required: false,
//                       validator: (val) {
//                         if (val != null && val.trim().isNotEmpty) {
//                           final alphaRegex = RegExp(r'^[a-zA-Z ]+$');
//                           return alphaRegex.hasMatch(val.trim())
//                               ? null
//                               : 'Only letters allowed';
//                         }
//                         return null;
//                       },
//                     ),
//                     const Divider(thickness: 1),
//                     _buildReadOnlyField('Country', 'Bangladesh'),
//                     const Divider(thickness: 1),
//                     _buildDropdownField(
//                       'Division',
//                       divisions,
//                       state.selectedDivision,
//                       (val) => bloc.add(UpdateDropdown('division', val!)),
//                     ),
//                     const Divider(thickness: 1),
//                     _buildDropdownField(
//                       'District',
//                       districts,
//                       state.selectedDistrict,
//                       (val) => bloc.add(UpdateDropdown('district', val!)),
//                     ),
//                     const Divider(thickness: 1),
//                     _buildDropdownField(
//                       'Thana',
//                       thanas,
//                       state.selectedThana,
//                       (val) => bloc.add(UpdateDropdown('thana', val!)),
//                     ),
//                     const Divider(thickness: 1),
//                     _buildDropdownField(
//                       'City',
//                       cities,
//                       state.selectedCity,
//                       (val) => bloc.add(UpdateDropdown('city', val!)),
//                     ),
//                     const Divider(thickness: 1),
//                     _buildDropdownField(
//                       'Net Worth',
//                       ['1 lac - 5 lac', '5 lac - 10 lac', 'More than 10 lac'],
//                       state.selectedNetWorth,
//                       (val) => bloc.add(UpdateDropdown('netWorth', val!)),
//                     ),
//                     const Divider(thickness: 1),
//                     const SizedBox(height: 12),
//                     _buildSectionLabel('Gender'),
//                     _buildRadioRow(state.gender, [
//                       'Male',
//                       'Female',
//                       'Others',
//                     ], (val) => bloc.add(UpdateGender(val))),
//                     const Divider(thickness: 1),
//                     _buildSectionLabel('Occupation'),
//                     _buildRadioGrid(
//                       state.occupation,
//                       ['Service', 'Business', 'Housewife', 'Student', 'Others'],
//                       (val) => bloc.add(UpdateOccupation(val)),
//                     ),
//                     const SizedBox(height: 12),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: SafeArea(
//         minimum: const EdgeInsets.all(16),
//         child: SizedBox(
//           width: double.infinity,
//           height: 48,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: ColorConstant.primary,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//             ),
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 // NavigatorUtil.pushNamed(AppRoute.photoCapture);
//                 NavigatorUtil.pushNamed(AppRoute.nomineeInfo);
//               }
//             },
//             child: Text(
//               'Continue',
//               style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                 color: ColorConstant.foreground,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField(
//     String label,
//     TextEditingController controller, {
//     TextInputType keyboardType = TextInputType.text,
//     bool required = true,
//     FormFieldValidator<String>? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: Theme.of(
//               context,
//             ).textTheme.bodySmall?.copyWith(color: Colors.grey),
//           ),
//           const SizedBox(height: 4),
//           TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             style: Theme.of(context).textTheme.bodyMedium,
//             validator:
//                 validator ??
//                 (required
//                     ? (val) =>
//                           val == null || val.trim().isEmpty ? 'Required' : null
//                     : null),
//             decoration: const InputDecoration(
//               isDense: true,
//               border: InputBorder.none,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildReadOnlyField(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: Theme.of(
//               context,
//             ).textTheme.bodySmall?.copyWith(color: Colors.grey),
//           ),
//           const SizedBox(height: 4),
//           TextFormField(
//             initialValue: value,
//             readOnly: true,
//             style: Theme.of(context).textTheme.bodyMedium,
//             decoration: const InputDecoration(
//               isDense: true,
//               border: InputBorder.none,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDropdownField(
//     String label,
//     List<String> options,
//     String? value,
//     ValueChanged<String?> onChanged,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: Theme.of(
//               context,
//             ).textTheme.bodySmall?.copyWith(color: Colors.grey),
//           ),
//           const SizedBox(height: 4),
//           DropdownButtonFormField<String>(
//             value: value,
//             items: options
//                 .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                 .toList(),
//             onChanged: onChanged,
//             isExpanded: true,
//             validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//             decoration: const InputDecoration(
//               isDense: true,
//               border: InputBorder.none,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Text(
//         text,
//         style: Theme.of(
//           context,
//         ).textTheme.bodySmall?.copyWith(color: Colors.grey),
//       ),
//     );
//   }

//   Widget _buildRadioRow(
//     String groupValue,
//     List<String> options,
//     ValueChanged<String> onChanged,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Wrap(
//         spacing: 24,
//         children: options
//             .map(
//               (o) => Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Radio<String>(
//                     value: o,
//                     groupValue: groupValue,
//                     activeColor: ColorConstant.primary,
//                     onChanged: (v) => onChanged(v!),
//                   ),
//                   Text(o),
//                 ],
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildRadioGrid(
//     String groupValue,
//     List<String> options,
//     ValueChanged<String> onChanged,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Wrap(
//         spacing: 24,
//         runSpacing: 8,
//         children: options
//             .map(
//               (o) => Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Radio<String>(
//                     value: o,
//                     groupValue: groupValue,
//                     activeColor: ColorConstant.primary,
//                     onChanged: (v) => onChanged(v!),
//                   ),
//                   Text(o),
//                 ],
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';

// import '../bloc/additional_info_bloc.dart';
// import '../bloc/additional_info_event.dart';
// import '../bloc/additional_info_state.dart';
// import 'package:bangladesh_finance_ekyc/core/service/additional_info_service.dart';

// class AdditionalInfoPage extends StatelessWidget {
//   const AdditionalInfoPage({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider(
//       create: (_) => AdditionalInfoBloc()
//         ..add(FetchDivisions())
//         ..add(FetchNetWorths())
//         ..add(UpdateDropdown('country', 'Bangladesh')),
//       child: const AdditionalInfoPage(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) => const _AdditionalInfoView();
// }

// class _AdditionalInfoView extends StatefulWidget {
//   const _AdditionalInfoView();

//   @override
//   State<_AdditionalInfoView> createState() => _AdditionalInfoViewState();
// }

// class _AdditionalInfoViewState extends State<_AdditionalInfoView> {
//   final _formKey = GlobalKey<FormState>();
//   final tinController = TextEditingController();
//   final religionController = TextEditingController();
//   bool isSubmitting = false;

//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<AdditionalInfoBloc>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Additional Info'),
//         leading: const BackButton(),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         foregroundColor: Colors.black,
//       ),
//       body: BlocBuilder<AdditionalInfoBloc, AdditionalInfoState>(
//         builder: (context, state) {
//           return SafeArea(
//             child: SingleChildScrollView(
//               padding: AppStyle.paddingAllSmall,
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 12),
//                     const GlowingStepProgressIndicatorWidget(
//                       currentStep: 5,
//                       totalSteps: 7,
//                       progressColor: ColorConstant.primary,
//                     ),
//                     const SizedBox(height: 24),
//                     _buildInputField(
//                       'E-TIN or TIN No (Optional)',
//                       tinController,
//                       false,
//                     ),
//                     const Divider(thickness: 1),
//                     _buildInputField(
//                       'Religion (Optional)',
//                       religionController,
//                       false,
//                     ),
//                     const Divider(thickness: 1),
//                     _buildReadOnlyField('Country', state.selectedCountry),
//                     const Divider(thickness: 1),
//                     _buildDropdownField(
//                       'Division',
//                       state.divisionList
//                           .map((e) => e['division_nm'] as String)
//                           .toList(),
//                       state.selectedDivision,
//                       (val) {
//                         final selected = state.divisionList.firstWhere(
//                           (e) => e['division_nm'] == val,
//                         );
//                         bloc.add(
//                           UpdateDropdown(
//                             'division',
//                             val!,
//                             id: selected['division_id'] as int,
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(thickness: 1),
//                     _buildDropdownField(
//                       'District',
//                       state.allDistricts
//                           .map((e) => e['district_nm'] as String)
//                           .toList(),
//                       state.selectedDistrict,
//                       (val) {
//                         final selected = state.allDistricts.firstWhere(
//                           (e) => e['district_nm'] == val,
//                         );
//                         bloc.add(
//                           UpdateDropdown(
//                             'district',
//                             val!,
//                             id: selected['district_id'] as int,
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(thickness: 1),
//                     _buildDropdownField(
//                       'Thana',
//                       state.allThanas
//                           .map((e) => e['thana_nm'] as String)
//                           .toList(),
//                       state.selectedThana,
//                       (val) {
//                         final selected = state.allThanas.firstWhere(
//                           (e) => e['thana_nm'] == val,
//                         );
//                         bloc.add(
//                           UpdateDropdown(
//                             'thana',
//                             val!,
//                             id: selected['thana_id'] as int,
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(thickness: 1),
//                     _buildDropdownField(
//                       'Net Worth',
//                       state.netWorthList
//                           .map((e) => e['net_worth_nm'] as String)
//                           .toList(),
//                       state.selectedNetWorth,
//                       (val) {
//                         bloc.add(
//                           UpdateDropdown(
//                             'netWorth',
//                             val!,
//                             id:
//                                 state.netWorthList.firstWhere(
//                                       (e) => e['net_worth_nm'] == val,
//                                     )['net_worth_id']
//                                     as int?,
//                           ),
//                         );
//                       },
//                     ),
//                     const Divider(thickness: 1),
//                     const SizedBox(height: 12),
//                     _buildSectionLabel('Gender'),
//                     _buildRadioRow(
//                       ['Male', 'Female', 'Others'],
//                       state.gender,
//                       bloc,
//                     ),
//                     const Divider(thickness: 1),
//                     _buildSectionLabel('Occupation'),
//                     _buildRadioGrid(
//                       ['Service', 'Business', 'Housewife', 'Student', 'Others'],
//                       state.occupation,
//                       bloc,
//                     ),
//                     const SizedBox(height: 24),
//                     isSubmitting
//                         ? const Center(child: CircularProgressIndicator())
//                         : SizedBox(
//                             width: double.infinity,
//                             height: 48,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: ColorConstant.primary,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                               ),
//                               onPressed: () async {
//                                 // Debug: Log current bloc state
//                                 print("🔍 Current State:");
//                                 print(
//                                   "Selected Country: ${state.selectedCountry}",
//                                 );
//                                 print(
//                                   "Selected Division: ${state.selectedDivision}",
//                                 );
//                                 print(
//                                   "Selected District: ${state.selectedDistrict}",
//                                 );
//                                 print("Selected Thana: ${state.selectedThana}");
//                                 print(
//                                   "Selected Net Worth: ${state.selectedNetWorth}",
//                                 );
//                                 print("Gender: ${state.gender}");
//                                 print("Occupation: ${state.occupation}");
//                                 print("TIN: ${tinController.text.trim()}");
//                                 print(
//                                   "Religion: ${religionController.text.trim()}",
//                                 );

//                                 // Safely extract IDs
//                                 final selectedDivision = state.divisionList
//                                     .firstWhere(
//                                       (e) =>
//                                           e['division_nm'] ==
//                                           state.selectedDivision,
//                                       orElse: () => {},
//                                     );
//                                 final selectedDistrict = state.allDistricts
//                                     .firstWhere(
//                                       (e) =>
//                                           e['district_nm'] ==
//                                           state.selectedDistrict,
//                                       orElse: () => {},
//                                     );
//                                 final selectedThana = state.allThanas
//                                     .firstWhere(
//                                       (e) =>
//                                           e['thana_nm'] == state.selectedThana,
//                                       orElse: () => {},
//                                     );
//                                 final selectedNetWorth = state.netWorthList
//                                     .firstWhere(
//                                       (e) =>
//                                           e['net_worth_nm'] ==
//                                           state.selectedNetWorth,
//                                       orElse: () => {},
//                                     );

//                                 final divisionId =
//                                     selectedDivision['division_id'] ?? 0;
//                                 final districtId =
//                                     selectedDistrict['district_id'] ?? 0;
//                                 final thanaId = selectedThana['thana_id'] ?? 0;
//                                 final netWorthId =
//                                     selectedNetWorth['net_worth_id'] ?? "";

//                                 // Final payload debug
//                                 print("🧾 Final Payload:");
//                                 print({
//                                   "etin_no": tinController.text.trim(),
//                                   "religion": religionController.text.trim(),
//                                   "country": state.selectedCountry,
//                                   "division_id": divisionId,
//                                   "district_id": districtId,
//                                   "thana_id": thanaId,
//                                   "net_worth_id": netWorthId,
//                                   "gender": state.gender,
//                                   "occupation": state.occupation,
//                                   "id_no": SignupState().nidId,
//                                 });

//                                 try {
//                                   final additionalInfoId =
//                                       await AdditionalInfoService.postAdditionalInfoData(
//                                         etinNo: tinController.text.trim(),
//                                         religion: religionController.text
//                                             .trim(),
//                                         country: state.selectedCountry,
//                                         divisionId: divisionId as int,
//                                         districtId: districtId as int,
//                                         thanaId: thanaId as int,
//                                         netWorthId: netWorthId as String,
//                                         gender: state.gender,
//                                         occupation: state.occupation,
//                                       );

//                                   // Persist id to singleton
//                                   SignupState().additionalInfoId =
//                                       additionalInfoId;

//                                   print(
//                                     "✅ Additional Info Submitted: ID = $additionalInfoId",
//                                   );
//                                   print(
//                                     "✅ SignUp State now: ID = ${SignupState()}",
//                                   );
//                                   // Navigate to next step
//                                   NavigatorUtil.pushNamed(AppRoute.nomineeInfo);
//                                 } catch (e) {
//                                   print('❌ Submission failed: $e');
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                         'Failed to submit additional info',
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               },
//                               child: Text(
//                                 'Continue',
//                                 style: Theme.of(context).textTheme.labelLarge
//                                     ?.copyWith(color: ColorConstant.foreground),
//                               ),
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildInputField(
//     String label,
//     TextEditingController controller,
//     bool required,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionLabel(label),
//         TextFormField(
//           controller: controller,
//           decoration: const InputDecoration(
//             isDense: true,
//             border: InputBorder.none,
//           ),
//           validator: required
//               ? (val) => (val == null || val.trim().isEmpty) ? 'Required' : null
//               : null,
//         ),
//       ],
//     );
//   }

//   Widget _buildReadOnlyField(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionLabel(label),
//         TextFormField(
//           initialValue: value,
//           readOnly: true,
//           decoration: const InputDecoration(
//             isDense: true,
//             border: InputBorder.none,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdownField(
//     String label,
//     List<String> options,
//     String? value,
//     ValueChanged<String?> onChanged,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionLabel(label),
//         DropdownButtonFormField<String>(
//           value: value?.isNotEmpty == true ? value : null,
//           items: options
//               .map((o) => DropdownMenuItem(value: o, child: Text(o)))
//               .toList(),
//           onChanged: onChanged,
//           isExpanded: true,
//           validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//           decoration: const InputDecoration(
//             isDense: true,
//             border: InputBorder.none,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSectionLabel(String text) => Padding(
//     padding: const EdgeInsets.only(bottom: 6),
//     child: Text(
//       text,
//       style: Theme.of(
//         context,
//       ).textTheme.bodySmall?.copyWith(color: Colors.grey),
//     ),
//   );

//   Widget _buildRadioRow(
//     List<String> options,
//     String groupValue,
//     AdditionalInfoBloc bloc,
//   ) {
//     return Wrap(
//       spacing: 24,
//       children: options.map((e) {
//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Radio<String>(
//               value: e,
//               groupValue: groupValue,
//               onChanged: (v) => bloc.add(UpdateGender(v!)),
//             ),
//             Text(e),
//           ],
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildRadioGrid(
//     List<String> options,
//     String groupValue,
//     AdditionalInfoBloc bloc,
//   ) {
//     return Wrap(
//       spacing: 24,
//       runSpacing: 8,
//       children: options.map((e) {
//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Radio<String>(
//               value: e,
//               groupValue: groupValue,
//               onChanged: (v) => bloc.add(UpdateOccupation(v!)),
//             ),
//             Text(e),
//           ],
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';

import '../bloc/additional_info_bloc.dart';
import '../bloc/additional_info_event.dart';
import '../bloc/additional_info_state.dart';
import 'package:bangladesh_finance_ekyc/core/service/additional_info_service.dart';

class AdditionalInfoPage extends StatelessWidget {
  const AdditionalInfoPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => AdditionalInfoBloc()
        ..add(FetchDivisions())
        ..add(FetchNetWorths())
        ..add(UpdateDropdown('country', 'Bangladesh')),
      child: const AdditionalInfoPage(),
    );
  }

  @override
  Widget build(BuildContext context) => const _AdditionalInfoView();
}

class _AdditionalInfoView extends StatefulWidget {
  const _AdditionalInfoView();

  @override
  State<_AdditionalInfoView> createState() => _AdditionalInfoViewState();
}

class _AdditionalInfoViewState extends State<_AdditionalInfoView> {
  final _formKey = GlobalKey<FormState>();
  final tinController = TextEditingController();
  final religionController = TextEditingController();
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdditionalInfoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional Info'),
        leading: const BackButton(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<AdditionalInfoBloc, AdditionalInfoState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: AppStyle.paddingAllSmall,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const GlowingStepProgressIndicatorWidget(
                      currentStep: 5,
                      totalSteps: 7,
                      progressColor: ColorConstant.primary,
                    ),
                    const SizedBox(height: 24),
                    _buildInputField('E-TIN or TIN No (Optional)', tinController, false),
                    const Divider(thickness: 1),
                    _buildInputField('Religion (Optional)', religionController, false),
                    const Divider(thickness: 1),
                    _buildReadOnlyField('Country', state.selectedCountry),
                    const Divider(thickness: 1),
                    _buildDropdownField('Division',
                      state.divisionList.map((e) => e['division_nm'] as String).toList(),
                      state.selectedDivision,
                      (val) {
                        final selected = state.divisionList.firstWhere((e) => e['division_nm'] == val);
                        bloc.add(UpdateDropdown('division', val!, id: selected['division_id'] as int));
                      },
                    ),
                    const Divider(thickness: 1),
                    _buildDropdownField('District',
                      state.allDistricts.map((e) => e['district_nm'] as String).toList(),
                      state.selectedDistrict,
                      (val) {
                        final selected = state.allDistricts.firstWhere((e) => e['district_nm'] == val);
                        bloc.add(UpdateDropdown('district', val!, id: selected['district_id'] as int));
                      },
                    ),
                    const Divider(thickness: 1),
                    _buildDropdownField('Thana',
                      state.allThanas.map((e) => e['thana_nm'] as String).toList(),
                      state.selectedThana,
                      (val) {
                        final selected = state.allThanas.firstWhere((e) => e['thana_nm'] == val);
                        bloc.add(UpdateDropdown('thana', val!, id: selected['thana_id'] as int));
                      },
                    ),
                    const Divider(thickness: 1),
                    _buildDropdownField('Net Worth',
                      state.netWorthList.map((e) => e['net_worth_nm'] as String).toList(),
                      state.selectedNetWorth,
                      (val) {
                        bloc.add(UpdateDropdown('netWorth', val!, id: state.netWorthList.firstWhere(
                          (e) => e['net_worth_nm'] == val)['net_worth_id'] as int?));
                      },
                    ),
                    const Divider(thickness: 1),
                    const SizedBox(height: 12),
                    _buildSectionLabel('Gender'),
                    _buildRadioRow(['Male', 'Female', 'Others'], state.gender, bloc),
                    const Divider(thickness: 1),
                    _buildSectionLabel('Occupation'),
                    _buildRadioGrid(['Service', 'Business', 'Housewife', 'Student', 'Others'], state.occupation, bloc),
                    const SizedBox(height: 24),
                    isSubmitting
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) return;
                                if (state.gender.isEmpty || state.occupation.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please select gender and occupation')),
                                  );
                                  return;
                                }

                                setState(() => isSubmitting = true);
                                try {
                                  final selectedDivision = state.divisionList.firstWhere(
                                    (e) => e['division_nm'] == state.selectedDivision, orElse: () => {});
                                  final selectedDistrict = state.allDistricts.firstWhere(
                                    (e) => e['district_nm'] == state.selectedDistrict, orElse: () => {});
                                  final selectedThana = state.allThanas.firstWhere(
                                    (e) => e['thana_nm'] == state.selectedThana, orElse: () => {});
                                  final selectedNetWorth = state.netWorthList.firstWhere(
                                    (e) => e['net_worth_nm'] == state.selectedNetWorth, orElse: () => {});

                                  final additionalInfoId = await AdditionalInfoService.postAdditionalInfoData(
                                    etinNo: tinController.text.trim(),
                                    religion: religionController.text.trim(),
                                    country: state.selectedCountry,
                                    divisionId: selectedDivision['division_id'] as int? ?? 0,
                                    districtId: selectedDistrict['district_id'] as int? ?? 0,
                                    thanaId: selectedThana['thana_id'] as int? ?? 0,
                                    netWorthId: selectedNetWorth['net_worth_id']?.toString() ?? '',
                                    gender: state.gender,
                                    occupation: state.occupation,
                                  );

                                  SignupState().additionalInfoId = additionalInfoId;
                                  NavigatorUtil.pushNamed(AppRoute.nomineeInfo);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Failed to submit additional info')),
                                  );
                                } finally {
                                  setState(() => isSubmitting = false);
                                }
                              },
                              child: Text(
                                'Continue',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: ColorConstant.foreground,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, bool required) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(label),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(isDense: true, border: InputBorder.none),
          validator: required ? (val) => val == null || val.trim().isEmpty ? 'Required' : null : null,
        ),
      ],
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(label),
        TextFormField(
          initialValue: value,
          readOnly: true,
          decoration: const InputDecoration(isDense: true, border: InputBorder.none),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> options, String? value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(label),
        DropdownButtonFormField<String>(
          value: options.contains(value) ? value : null,
          items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
          onChanged: onChanged,
          isExpanded: true,
          validator: (val) => val == null || val.isEmpty ? 'Required' : null,
          decoration: const InputDecoration(isDense: true, border: InputBorder.none),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
  );

  Widget _buildRadioRow(List<String> options, String groupValue, AdditionalInfoBloc bloc) {
    return Wrap(
      spacing: 24,
      children: options.map((e) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(value: e, groupValue: groupValue, onChanged: (v) => bloc.add(UpdateGender(v!))),
            Text(e),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildRadioGrid(List<String> options, String groupValue, AdditionalInfoBloc bloc) {
    return Wrap(
      spacing: 24,
      runSpacing: 8,
      children: options.map((e) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(value: e, groupValue: groupValue, onChanged: (v) => bloc.add(UpdateOccupation(v!))),
            Text(e),
          ],
        );
      }).toList(),
    );
  }
}