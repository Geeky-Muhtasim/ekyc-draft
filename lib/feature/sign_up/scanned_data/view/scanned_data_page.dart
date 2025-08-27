// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_state.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:io';

// class ScannedDataPage extends StatefulWidget {
//   const ScannedDataPage({super.key});

//   static Widget builder(BuildContext context) => const ScannedDataPage();

//   @override
//   State<ScannedDataPage> createState() => _ScannedDataPageState();
// }

// class _ScannedDataPageState extends State<ScannedDataPage> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController nidController;
//   late TextEditingController nameEnController;
//   late TextEditingController nameBnController;
//   late TextEditingController fatherController;
//   late TextEditingController motherController;
//   late TextEditingController dobController;
//   late TextEditingController presentAddressController;
//   late TextEditingController permanentAddressController;

//   bool addressSame = false;

//   @override
//   void initState() {
//     super.initState();
//     final state = context.read<ScannedDataBloc>().state;
//     nidController = TextEditingController(text: state.extractedData['nid']);
//     nameEnController = TextEditingController(text: state.extractedData['nameEn']);
//     nameBnController = TextEditingController(text: state.extractedData['nameBn']);
//     fatherController = TextEditingController(text: state.extractedData['fatherBn']);
//     motherController = TextEditingController(text: state.extractedData['motherBn']);
//     dobController = TextEditingController(text: state.extractedData['dob']);
//     presentAddressController = TextEditingController(text: state.extractedData['presentAddress']);
//     permanentAddressController = TextEditingController(text: state.extractedData['permanentAddress']);
//   }

//   Future<void> _selectDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.tryParse(dobController.text.replaceAll('/', '-')) ?? DateTime(2000),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       dobController.text = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
//     }
//   }

//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;

//     final bloc = context.read<ScannedDataBloc>()
//       ..add(ScannedDataInitialized({
//         'nid': nidController.text.trim(),
//         'nameEn': nameEnController.text.trim(),
//         'nameBn': nameBnController.text.trim(),
//         'fatherBn': fatherController.text.trim(),
//         'motherBn': motherController.text.trim(),
//         'dob': dobController.text.trim(),
//         'presentAddress': presentAddressController.text.trim(),
//         'permanentAddress': permanentAddressController.text.trim(),
//       }));

//     Navigator.pushNamed(context, AppRoute.additionalInfo);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         title: const Text("Verify NID Info"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: AppStyle.paddingAllSmall,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const GlowingStepProgressIndicatorWidget(
//                 currentStep: 4,
//                 totalSteps: 7,
//                 progressColor: ColorConstant.primary,
//               ),
//               const SizedBox(height: 16),
//               _buildField("NID", nidController),
//               _buildField("Name (English)", nameEnController),
//               _buildField("Name (Bangla)", nameBnController),
//               _buildField("Father's Name", fatherController),
//               _buildField("Mother's Name", motherController),
//               _buildDateField("Date of Birth", dobController),
//               _buildField("Present Address", presentAddressController),
//               const SizedBox(height: 12),
//               CheckboxListTile(
//                 value: addressSame,
//                 onChanged: (val) {
//                   setState(() {
//                     addressSame = val ?? false;
//                     if (addressSame) {
//                       permanentAddressController.text = presentAddressController.text;
//                     } else {
//                       permanentAddressController.clear();
//                     }
//                   });
//                 },
//                 title: const Text("Same as present address"),
//                 controlAffinity: ListTileControlAffinity.leading,
//                 contentPadding: EdgeInsets.zero,
//               ),
//               _buildField("Permanent Address", permanentAddressController),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   onPressed: _submit,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorConstant.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text(
//                     "Continue",
//                     style: TextStyle(color: ColorConstant.foreground),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         validator: (value) {
//           if (value == null || value.trim().isEmpty) {
//             return 'Required';
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           isDense: true,
//         ),
//       ),
//     );
//   }

//   Widget _buildDateField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         readOnly: true,
//         onTap: _selectDate,
//         validator: (value) {
//           if (value == null || value.trim().isEmpty) {
//             return 'Required';
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           isDense: true,
//           suffixIcon: const Icon(Icons.calendar_today),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/service/nid_service.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_event.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/scanned_data/bloc/scanned_data_state.dart';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScannedDataPage extends StatefulWidget {
  final File nidFrontImage;
  final File nidBackImage;

  const ScannedDataPage({
    super.key,
    required this.nidFrontImage,
    required this.nidBackImage,
  });

  static Widget builder(BuildContext context) => throw UnimplementedError();

  @override
  State<ScannedDataPage> createState() => _ScannedDataPageState();
}

class _ScannedDataPageState extends State<ScannedDataPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nidController;
  late TextEditingController nameEnController;
  late TextEditingController nameBnController;
  late TextEditingController fatherController;
  late TextEditingController motherController;
  late TextEditingController dobController;
  late TextEditingController presentAddressController;
  late TextEditingController permanentAddressController;

  bool addressSame = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<ScannedDataBloc>().state;
    nidController = TextEditingController(text: state.extractedData['nid']);
    nameEnController = TextEditingController(
      text: state.extractedData['nameEn'],
    );
    nameBnController = TextEditingController(
      text: state.extractedData['nameBn'],
    );
    fatherController = TextEditingController(
      text: state.extractedData['fatherBn'],
    );
    motherController = TextEditingController(
      text: state.extractedData['motherBn'],
    );
    dobController = TextEditingController(text: state.extractedData['dob']);
    presentAddressController = TextEditingController(
      text: state.extractedData['presentAddress'],
    );
    permanentAddressController = TextEditingController(
      text: state.extractedData['permanentAddress'],
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.tryParse(dobController.text.replaceAll('/', '-')) ??
          DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final nid = nidController.text.trim();
    final nameEn = nameEnController.text.trim();
    final nameBn = nameBnController.text.trim();
    final fatherBn = fatherController.text.trim();
    final motherBn = motherController.text.trim();
    final dob = _formatDate(dobController.text.trim()); // Ensure yyyy-MM-dd
    final presentAddress = presentAddressController.text.trim();
    final permanentAddress = permanentAddressController.text.trim();

    try {
      final nidId = await NidService.submitNidData(
        nid: nid,
        nameEn: nameEn,
        nameBn: nameBn,
        fatherNameBn: fatherBn,
        motherNameBn: motherBn,
        dob: dob,
        presentAddress: presentAddress,
        permanentAddress: permanentAddress,
      );

      // ✅ Store in singleton
      SignupState().nidId = nidId;
      print("✅ NID Submission successful. nidId = $nidId");
      print("✅ Current SignupState: ${SignupState()}");

      NavigatorUtil.pushNamed(
        AppRoute.additionalInfo,
        arguments: {
          'nidFrontImage': widget.nidFrontImage,
          'nidBackImage': widget.nidBackImage,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  // Optional helper
  String _formatDate(String dob) {
    try {
      final parts = dob.split('/');
      if (parts.length == 3) {
        return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
      }
      return dob;
    } catch (_) {
      return dob;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Verify NID Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppStyle.paddingAllSmall,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GlowingStepProgressIndicatorWidget(
                currentStep: 4,
                totalSteps: 7,
                progressColor: ColorConstant.primary,
              ),
              const SizedBox(height: 16),
              _buildField("NID", nidController),
              _buildField("Name (English)", nameEnController),
              _buildField("Name (Bangla)", nameBnController),
              _buildField("Father's Name", fatherController),
              _buildField("Mother's Name", motherController),
              _buildDateField("Date of Birth", dobController),
              _buildField("Present Address", presentAddressController),
              const SizedBox(height: 12),
              CheckboxListTile(
                value: addressSame,
                onChanged: (val) {
                  setState(() {
                    addressSame = val ?? false;
                    if (addressSame) {
                      permanentAddressController.text =
                          presentAddressController.text;
                    } else {
                      permanentAddressController.clear();
                    }
                  });
                },
                title: const Text("Same as present address"),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              _buildField("Permanent Address", permanentAddressController),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: ColorConstant.foreground),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: _selectDate,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
