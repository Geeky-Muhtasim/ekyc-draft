import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:flutter/material.dart';

class LongButtonWidget extends StatelessWidget {
  const LongButtonWidget({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: ColorConstant.primary,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).canvasColor,
            ),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
