import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/route/app_route.dart';
import 'package:bangladesh_finance_ekyc/core/style/app_style.dart';
import 'package:bangladesh_finance_ekyc/core/util/navigator_util.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/bloc/additional_info_bloc.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/bloc/additional_info_event.dart';
import 'package:bangladesh_finance_ekyc/feature/sign_up/additional_info/bloc/additional_info_state.dart';
import 'package:bangladesh_finance_ekyc/widget/common/glowing_step_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalInfoPage extends StatelessWidget {
  const AdditionalInfoPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => AdditionalInfoBloc(),
      child: const AdditionalInfoPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _AdditionalInfoView();
  }
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
  final netWorthController = TextEditingController();

  final List<String> divisions = ['Dhaka', 'Chittagong', 'Khulna', 'Sylhet', 'Barishal', 'Rajshahi', 'Rangpur', 'Mymensingh'];
  final List<String> districts = ['Dhaka', 'Cumilla', 'Rajshahi', 'Khulna', 'Sylhet', 'Barishal', 'Rangpur', 'Mymensingh'];
  final List<String> thanas = ['Dhanmondi', 'Boalia', 'Kotwali'];
  final List<String> cities = ['Dhaka City', 'Cumilla City', 'Khulna City','Sylhet City', 'Barishal City', 'Rajshahi City', 'Rangpur City', 'Mymensingh City'];

  @override
  void initState() {
    super.initState();
    context.read<AdditionalInfoBloc>().add(
      UpdateDropdown('country', 'Bangladesh'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdditionalInfoBloc>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Additional Info'),
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
                    _buildInputField(
                      'E-TIN or TIN No (Optional)',
                      tinController,
                      keyboardType: TextInputType.number,
                      required: false,
                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          final numericRegex = RegExp(r'^[0-9]+$');
                          return numericRegex.hasMatch(val.trim())
                              ? null
                              : 'Only numbers allowed';
                        }
                        return null;
                      },
                    ),
                    const Divider(thickness: 1),
                    _buildInputField(
                      'Religion (Optional)',
                      religionController,
                      required: false,
                      validator: (val) {
                        if (val != null && val.trim().isNotEmpty) {
                          final alphaRegex = RegExp(r'^[a-zA-Z ]+$');
                          return alphaRegex.hasMatch(val.trim())
                              ? null
                              : 'Only letters allowed';
                        }
                        return null;
                      },
                    ),
                    const Divider(thickness: 1),
                    _buildReadOnlyField('Country', 'Bangladesh'),
                    const Divider(thickness: 1),
                    _buildDropdownField(
                      'Division',
                      divisions,
                      state.selectedDivision,
                      (val) => bloc.add(UpdateDropdown('division', val!)),
                    ),
                    const Divider(thickness: 1),
                    _buildDropdownField(
                      'District',
                      districts,
                      state.selectedDistrict,
                      (val) => bloc.add(UpdateDropdown('district', val!)),
                    ),
                    const Divider(thickness: 1),
                    _buildDropdownField(
                      'Thana',
                      thanas,
                      state.selectedThana,
                      (val) => bloc.add(UpdateDropdown('thana', val!)),
                    ),
                    const Divider(thickness: 1),
                    _buildDropdownField(
                      'City',
                      cities,
                      state.selectedCity,
                      (val) => bloc.add(UpdateDropdown('city', val!)),
                    ),
                    const Divider(thickness: 1),
                    _buildDropdownField(
                      'Net Worth',
                      ['1 lac - 5 lac', '5 lac - 10 lac', 'More than 10 lac'],
                      state.selectedNetWorth,
                      (val) => bloc.add(UpdateDropdown('netWorth', val!)),
                    ),
                    const Divider(thickness: 1),
                    const SizedBox(height: 12),
                    _buildSectionLabel('Gender'),
                    _buildRadioRow(state.gender, [
                      'Male',
                      'Female',
                      'Others',
                    ], (val) => bloc.add(UpdateGender(val))),
                    const Divider(thickness: 1),
                    _buildSectionLabel('Occupation'),
                    _buildRadioGrid(
                      state.occupation,
                      ['Service', 'Business', 'Housewife', 'Student', 'Others'],
                      (val) => bloc.add(UpdateOccupation(val)),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
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
              if (_formKey.currentState!.validate()) {
                // NavigatorUtil.pushNamed(AppRoute.photoCapture);
                NavigatorUtil.pushNamed(AppRoute.nomineeInfo);
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
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool required = true,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: Theme.of(context).textTheme.bodyMedium,
            validator:
                validator ??
                (required
                    ? (val) =>
                          val == null || val.trim().isEmpty ? 'Required' : null
                    : null),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          TextFormField(
            initialValue: value,
            readOnly: true,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> options,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: value,
            items: options
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
            isExpanded: true,
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
    );
  }

  Widget _buildRadioRow(
    String groupValue,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(
        spacing: 24,
        children: options
            .map(
              (o) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: o,
                    groupValue: groupValue,
                    activeColor: ColorConstant.primary,
                    onChanged: (v) => onChanged(v!),
                  ),
                  Text(o),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildRadioGrid(
    String groupValue,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(
        spacing: 24,
        runSpacing: 8,
        children: options
            .map(
              (o) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: o,
                    groupValue: groupValue,
                    activeColor: ColorConstant.primary,
                    onChanged: (v) => onChanged(v!),
                  ),
                  Text(o),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
