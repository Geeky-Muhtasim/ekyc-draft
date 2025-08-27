import 'dart:io';
import 'dart:typed_data';

import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class UploadStatusPage extends StatelessWidget {
  final XFile? photo;
  final Uint8List? signatureBytes;
  final File? nidFront;
  final File? nidBack;

  const UploadStatusPage({
    super.key,
    this.photo,
    this.signatureBytes,
    this.nidFront,
    this.nidBack,
  });

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final XFile? photo = args['photo'] as XFile?;
    final Uint8List? signature = args['signature'] as Uint8List?;
    final File? nidFront = args['nidFront'] as File?;
    final File? nidBack = args['nidBack'] as File?;

    return UploadStatusPage(
      photo: photo,
      signatureBytes: signature,
      nidFront: nidFront,
      nidBack: nidBack,
    );
  }

  Widget placeholderBox({
    double width = 160,
    double height = 100,
    IconData icon = Icons.image,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 40, color: Colors.grey.shade600),
    );
  }

  Widget buildStatusTile(String label, Widget leading) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8), child: leading),
          Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                'SUCCESS',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey.shade200,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Status"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const GlowingStepProgressIndicatorWidget(
              currentStep: 6,
              totalSteps: 7,
              progressColor: ColorConstant.primary,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildSection("Identity Document", [
                      buildStatusTile(
                        "NID Front",
                        nidFront != null
                            ? Image.file(
                                nidFront!,
                                width: 160,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : placeholderBox(icon: Icons.credit_card),
                      ),
                      buildStatusTile(
                        "NID Back",
                        nidBack != null
                            ? Image.file(
                                nidBack!,
                                width: 160,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : placeholderBox(icon: Icons.credit_card_outlined),
                      ),
                    ]),
                    buildSection("Photo", [
                      buildStatusTile(
                        "Photo",
                        photo != null
                            ? Image.file(
                                File(photo!.path),
                                width: 100,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                            : placeholderBox(
                                width: 100,
                                height: 120,
                                icon: Icons.person,
                              ),
                      ),
                    ]),
                    buildSection("Signature", [
                      buildStatusTile(
                        "Signature",
                        signatureBytes != null
                            ? Image.memory(
                                signatureBytes!,
                                width: 120,
                                height: 60,
                                fit: BoxFit.contain,
                              )
                            : placeholderBox(
                                width: 120,
                                height: 60,
                                icon: Icons.draw,
                              ),
                      ),
                    ]),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
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
                    NavigatorUtil.pushNamed(
                      AppRoute.finalReview,
                      arguments: {
                        'photo': photo,
                        'signature': signatureBytes,
                        'nidFront': nidFront,
                        'nidBack': nidBack,
                      },
                    );
                  },
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorConstant.foreground,
                        ),
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
