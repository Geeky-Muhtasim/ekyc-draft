// import 'dart:io';

// import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
// import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
// import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
// import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nominee_info/bloc/nominee_info_bloc.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nominee_info/bloc/nominee_info_event.dart';
// import 'package:bangladesh_finance_ekyc/feature/sign_up/nominee_info/bloc/nominee_info_state.dart';
// import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class NomineeInfoPage extends StatelessWidget {
//   const NomineeInfoPage({super.key});

//   static Widget builder(BuildContext context) {
//     return BlocProvider(
//       create: (_) => NomineeInfoBloc(),
//       child: const NomineeInfoPage(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) => const _NomineeInfoView();
// }

// class _NomineeInfoView extends StatefulWidget {
//   const _NomineeInfoView();

//   @override
//   State<_NomineeInfoView> createState() => _NomineeInfoViewState();
// }

// class _NomineeInfoViewState extends State<_NomineeInfoView> {
//   final _formKey = GlobalKey<FormState>();

//   final nameController = TextEditingController();
//   final fatherNameController = TextEditingController();
//   final motherNameController = TextEditingController();
//   final relationshipController = TextEditingController();
//   final dobController = TextEditingController();
//   final nidController = TextEditingController();
//   final addressController = TextEditingController();

//   Future<void> _pickDateOfBirth() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2000),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       dobController.text = "${picked.day}/${picked.month}/${picked.year}";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text('Nominee Information'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         foregroundColor: Colors.black,
//       ),
//       body: SafeArea(
//         child: BlocBuilder<NomineeInfoBloc, NomineeInfoState>(
//           builder: (context, state) {
//             return SingleChildScrollView(
//               padding: AppStyle.paddingAllSmall,
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const GlowingStepProgressIndicatorWidget(
//                       currentStep: 6,
//                       totalSteps: 7,
//                       progressColor: ColorConstant.primary,
//                     ),
//                     const SizedBox(height: 24),
//                     _buildAlphabeticField('Name', nameController),
//                     const Divider(thickness: 1),
//                     _buildAlphabeticField('Father Name', fatherNameController),
//                     const Divider(thickness: 1),
//                     _buildAlphabeticField('Mother Name', motherNameController),
//                     const Divider(thickness: 1),
//                     _buildAlphabeticField('Relationship', relationshipController),
//                     const Divider(thickness: 1),
//                     _buildAlphabeticField('Address', addressController),
//                     const Divider(thickness: 1),
//                     _buildDateField('Date of Birth', dobController),
//                     const Divider(thickness: 1),
//                     _buildNumericField('NID No', nidController),
//                     const Divider(thickness: 1),
//                     _buildPhotoUploadField(context, state),
//                     const SizedBox(height: 32),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: ColorConstant.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         onPressed: () {
//                           final photoPath = context.read<NomineeInfoBloc>().state.photoPath;
//                           if (_formKey.currentState!.validate()) {
//                             if (photoPath == null || photoPath.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Please upload nominee photo',
//                                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
//                                   ),
//                                   backgroundColor: Colors.red,
//                                   behavior: SnackBarBehavior.floating,
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                                   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                                   duration: const Duration(seconds: 2),
//                                 ),
//                               );
//                               return;
//                             }
//                             NavigatorUtil.pushNamed(AppRoute.photoCapture);
//                           }
//                         },
//                         child: Text(
//                           'Continue',
//                           style: Theme.of(context)
//                               .textTheme
//                               .labelLarge
//                               ?.copyWith(color: ColorConstant.foreground),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildAlphabeticField(String label, TextEditingController controller) {
//     return _buildInputField(
//       label,
//       controller,
//       validator: (value) {
//         if (value == null || value.trim().isEmpty) {
//           return 'This field is required';
//         } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
//           return 'Only alphabets allowed';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildNumericField(String label, TextEditingController controller) {
//     return _buildInputField(
//       label,
//       controller,
//       keyboardType: TextInputType.number,
//       validator: (value) {
//         if (value == null || value.trim().isEmpty) {
//           return 'This field is required';
//         } else if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
//           return 'Only numbers allowed';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildInputField(
//     String label,
//     TextEditingController controller, {
//     TextInputType keyboardType = TextInputType.text,
//     String? Function(String?)? validator,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
//           ),
//           const SizedBox(height: 4),
//           TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             style: Theme.of(context).textTheme.bodyMedium,
//             decoration: const InputDecoration(
//               isDense: true,
//               border: InputBorder.none,
//             ),
//             validator: validator,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateField(String label, TextEditingController controller) {
//     return GestureDetector(
//       onTap: _pickDateOfBirth,
//       child: AbsorbPointer(child: _buildInputField(label, controller, validator: (value) {
//         if (value == null || value.isEmpty) return 'Date of Birth is required';
//         return null;
//       })),
//     );
//   }

//   Widget _buildPhotoUploadField(BuildContext context, NomineeInfoState state) {
//     final filePath = state.photoPath;
//     final fileName = filePath != null ? filePath.split(Platform.pathSeparator).last : null;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Upload Nominee Photo',
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
//         const SizedBox(height: 12),
//         ElevatedButton.icon(
//           icon: const Icon(Icons.upload_file, color: Colors.white),
//           label: const Text("Select Photo", style: TextStyle(color: Colors.white)),
//           onPressed: () async {
//             final picker = ImagePicker();
//             final picked = await picker.pickImage(source: ImageSource.gallery);
//             if (picked != null) {
//               context.read<NomineeInfoBloc>().add(UpdatePhotoPath(picked.path));
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("Photo uploaded successfully", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
//                   backgroundColor: Theme.of(context).colorScheme.primary,
//                   behavior: SnackBarBehavior.floating,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   duration: const Duration(seconds: 2),
//                 ),
//               );
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: ColorConstant.primary,
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           ),
//         ),
//         const SizedBox(height: 16),
//         if (filePath != null && filePath.isNotEmpty)
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               border: Border.all(color: Colors.grey.shade400),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: GestureDetector(
//                     onTap: () => _showImagePreview(context, filePath),
//                     child: Text(
//                       fileName ?? '',
//                       style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         decoration: TextDecoration.underline,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     context.read<NomineeInfoBloc>().add(UpdatePhotoPath(""));
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text("Photo removed", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
//                         backgroundColor: Colors.red,
//                         behavior: SnackBarBehavior.floating,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         duration: const Duration(seconds: 2),
//                       ),
//                     );
//                   },
//                   child: const Icon(Icons.close, color: Colors.red),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   void _showImagePreview(BuildContext context, String filePath) {
//     showDialog(
//       context: context,
//       builder: (ctx) => Dialog(
//         backgroundColor: Colors.transparent,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.file(File(filePath)),
//                 ),
//                 Positioned(
//                   top: 4,
//                   right: 4,
//                   child: IconButton(
//                     icon: const Icon(Icons.close, color: Colors.white),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/service/nominee_service.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/nominee_info/bloc/nominee_info_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/nominee_info/bloc/nominee_info_event.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/nominee_info/bloc/nominee_info_state.dart';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class NomineeInfoPage extends StatelessWidget {
  const NomineeInfoPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => NomineeInfoBloc(),
      child: const NomineeInfoPage(),
    );
  }

  @override
  Widget build(BuildContext context) => const _NomineeInfoView();
}

class _NomineeInfoView extends StatefulWidget {
  const _NomineeInfoView();

  @override
  State<_NomineeInfoView> createState() => _NomineeInfoViewState();
}

class _NomineeInfoViewState extends State<_NomineeInfoView> {
  final _formKey = GlobalKey<FormState>();
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  final nameController = TextEditingController();
  final fatherController = TextEditingController();
  final motherController = TextEditingController();
  final relationshipController = TextEditingController();
  final dobController = TextEditingController();
  final nidController = TextEditingController();
  final addressController = TextEditingController(); // ✅ New field

  Future<void> _pickDateOfBirth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<String?> _saveDrawnSignature() async {
    if (_signatureController.isNotEmpty) {
      final bytes = await _signatureController.toPngBytes();
      if (bytes != null) {
        final dir = await getApplicationDocumentsDirectory();
        final path =
            '${dir.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png';
        final file = await File(path).writeAsBytes(bytes);
        return file.path;
      }
    }
    return null;
  }

  SnackBar _customSnackBar(String text) => SnackBar(
    content: Text(text, style: const TextStyle(color: Colors.white)),
    backgroundColor: ColorConstant.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    duration: const Duration(seconds: 2),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nominee Information'),
        centerTitle: true,
        backgroundColor: ColorConstant.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<NomineeInfoBloc, NomineeInfoState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: AppStyle.paddingAllSmall,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const GlowingStepProgressIndicatorWidget(
                      currentStep: 6,
                      totalSteps: 7,
                      progressColor: ColorConstant.primary,
                    ),
                    const SizedBox(height: 24),
                    _buildInput("Name", nameController),
                    _buildInput("Father Name", fatherController),
                    _buildInput("Mother Name", motherController),
                    _buildInput("Relationship", relationshipController),
                    _buildDatePicker("Date of Birth", dobController),
                    _buildInput("NID No", nidController, TextInputType.number),
                    _buildInput("Address", addressController),
                    const SizedBox(height: 16),
                    _buildSignatureSection(context, state),
                    _buildNomineePhotoSection(context, state),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        // onPressed: () async {
                        //   final bloc = context.read<NomineeInfoBloc>();
                        //   final state = bloc.state;

                        //   if (_formKey.currentState!.validate()) {
                        //     String? signaturePath = state.photoPath;

                        //     if ((signaturePath == null || signaturePath.isEmpty) &&
                        //         _signatureController.isNotEmpty) {
                        //       signaturePath = await _saveDrawnSignature();
                        //       if (signaturePath != null) {
                        //         bloc.add(UpdatePhotoPath(signaturePath));
                        //       }
                        //     }

                        //     if (signaturePath == null || signaturePath.isEmpty) {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         _customSnackBar("Please add a signature"),
                        //       );
                        //       return;
                        //     }

                        //     NavigatorUtil.pushNamed(AppRoute.photoCapture);
                        //   }
                        // },
                        onPressed: () async {
                          final bloc = context.read<NomineeInfoBloc>();
                          final state = bloc.state;

                          if (_formKey.currentState!.validate()) {
                            try {
                              // Save drawn signature if needed
                              String? signaturePath = state.photoPath;
                              if ((signaturePath == null ||
                                      signaturePath.isEmpty) &&
                                  _signatureController.isNotEmpty) {
                                signaturePath = await _saveDrawnSignature();
                                if (signaturePath != null) {
                                  bloc.add(UpdatePhotoPath(signaturePath));
                                }
                              }

                              if (signaturePath == null ||
                                  signaturePath.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  _customSnackBar("Please add a signature"),
                                );
                                return;
                              }

                              // Submit nominee info
                              final nomineeId =
                                  await NomineeService.submitNomineeDetails(
                                    ref_id: SignupState().nidId!,
                                    name: nameController.text.trim(),
                                    fatherName: fatherController.text.trim(),
                                    motherName: motherController.text.trim(),
                                    relationship: relationshipController.text
                                        .trim(),
                                    address: addressController.text.trim(),
                                    dateOfBirth: dobController.text.trim(),
                                    nidNo: nidController.text.trim(),
                                  );

                              if (nomineeId != null) {
                                SignupState().nomineeId = nomineeId;

                                print(
                                  "✅ Nominee Info Submitted: ID = $nomineeId",
                                );
                                print(
                                  "✅ SignUp State now: ID = ${SignupState()}",
                                );

                                final nomineePhoto = File(
                                  state.nomineePhotoPath!,
                                );
                                final signatureFile = File(signaturePath);

                                await NomineeService.uploadNomineeFiles(
                                  nomineeId: nomineeId,
                                  nomineeImage: nomineePhoto,
                                  nomineeSignature: signatureFile,
                                );

                                NavigatorUtil.pushNamed(AppRoute.photoCapture);
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                _customSnackBar("❌ ${e.toString()}"),
                              );
                            }
                          }
                        },

                        child: const Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    TextEditingController controller, [
    TextInputType type = TextInputType.text,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => (value == null || value.trim().isEmpty)
            ? 'This field is required'
            : null,
      ),
    );
  }

  Widget _buildDatePicker(String label, TextEditingController controller) {
    return GestureDetector(
      onTap: _pickDateOfBirth,
      child: AbsorbPointer(
        child: _buildInput(label, controller),
      ),
    );
  }

  Widget _buildSignatureSection(BuildContext context, NomineeInfoState state) {
    final path = state.photoPath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Signature (Draw or Upload)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Signature(
            controller: _signatureController,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _signatureController.clear(),
              child: const Text("Clear"),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload"),
          onPressed: () async {
            final picker = ImagePicker();
            final picked = await picker.pickImage(source: ImageSource.gallery);
            if (picked != null) {
              context.read<NomineeInfoBloc>().add(UpdatePhotoPath(picked.path));
              ScaffoldMessenger.of(context).showSnackBar(
                _customSnackBar("Signature image uploaded"),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.foreground,
          ),
        ),
        const SizedBox(height: 16),
        if (path != null && path.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Signature Preview:"),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(File(path), height: 100),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildNomineePhotoSection(
    BuildContext context,
    NomineeInfoState state,
  ) {
    final path = state.nomineePhotoPath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          "Upload Nominee Photo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.camera_alt),
          label: const Text("Choose from Gallery"),
          onPressed: () async {
            final picker = ImagePicker();
            final picked = await picker.pickImage(source: ImageSource.gallery);
            if (picked != null) {
              context.read<NomineeInfoBloc>().add(
                UpdateNomineeImagePath(picked.path),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                _customSnackBar("Nominee photo uploaded"),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.foreground,
          ),
        ),
        const SizedBox(height: 16),
        if (path != null && path.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Nominee Photo Preview:"),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(File(path), height: 100),
              ),
            ],
          ),
      ],
    );
  }
}
