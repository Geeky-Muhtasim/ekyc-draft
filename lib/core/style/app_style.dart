import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:bangladesh_finance_ekyc/core/constant/style_constant.dart';
import 'package:flutter/material.dart';

class AppStyle {
  // padding
  static EdgeInsetsGeometry paddingAllSmall = const EdgeInsets.all(
    StyleConstant.paddingSmallSize,
  );
  static EdgeInsetsGeometry paddingAllMedium = const EdgeInsets.all(
    StyleConstant.paddingMediumSize,
  );
  static EdgeInsetsGeometry paddingAllLarge = const EdgeInsets.all(
    StyleConstant.paddingLargeSize,
  );
  static EdgeInsetsGeometry paddingVerticalSmall = const EdgeInsets.symmetric(
    vertical: StyleConstant.paddingSmallSize,
  );
  static EdgeInsetsGeometry paddingVerticalMedium = const EdgeInsets.symmetric(
    vertical: StyleConstant.paddingMediumSize,
  );
  static EdgeInsetsGeometry paddingVerticalLarge = const EdgeInsets.symmetric(
    vertical: StyleConstant.paddingLargeSize,
  );
  static EdgeInsetsGeometry paddingHorizontalSmall = const EdgeInsets.symmetric(
    horizontal: StyleConstant.paddingSmallSize,
  );
  static EdgeInsetsGeometry paddingHorizontalMedium =
      const EdgeInsets.symmetric(
        horizontal: StyleConstant.paddingMediumSize,
      );
  static EdgeInsetsGeometry paddingHorizontalLarge = const EdgeInsets.symmetric(
    horizontal: StyleConstant.paddingLargeSize,
  );
  static EdgeInsetsGeometry paddingLeftSmall = const EdgeInsets.only(
    left: StyleConstant.paddingSmallSize,
  );
  static EdgeInsetsGeometry paddingLeftMedium = const EdgeInsets.only(
    left: StyleConstant.paddingMediumSize,
  );
  static EdgeInsetsGeometry paddingLeftLarge = const EdgeInsets.only(
    left: StyleConstant.paddingLargeSize,
  );
  static EdgeInsetsGeometry paddingTopSmall = const EdgeInsets.only(
    top: StyleConstant.paddingSmallSize,
  );
  static EdgeInsetsGeometry paddingTopMedium = const EdgeInsets.only(
    top: StyleConstant.paddingMediumSize,
  );
  static EdgeInsetsGeometry paddingTopLarge = const EdgeInsets.only(
    top: StyleConstant.paddingLargeSize,
  );
  static EdgeInsetsGeometry paddingRightSmall = const EdgeInsets.only(
    right: StyleConstant.paddingSmallSize,
  );
  static EdgeInsetsGeometry paddingRightMedium = const EdgeInsets.only(
    right: StyleConstant.paddingMediumSize,
  );
  static EdgeInsetsGeometry paddingRightLarge = const EdgeInsets.only(
    right: StyleConstant.paddingLargeSize,
  );
  static EdgeInsetsGeometry paddingBottomSmall = const EdgeInsets.only(
    bottom: StyleConstant.paddingSmallSize,
  );
  static EdgeInsetsGeometry paddingBottomMedium = const EdgeInsets.only(
    bottom: StyleConstant.paddingMediumSize,
  );
  static EdgeInsetsGeometry paddingBottomLarge = const EdgeInsets.only(
    bottom: StyleConstant.paddingLargeSize,
  );

  // margin
  static EdgeInsetsGeometry marginAllSmall = const EdgeInsets.all(
    StyleConstant.marginSmallSize,
  );
  static EdgeInsetsGeometry marginAllMedium = const EdgeInsets.all(
    StyleConstant.marginMediumSize,
  );
  static EdgeInsetsGeometry marginAllLarge = const EdgeInsets.all(
    StyleConstant.marginLargeSize,
  );
  static EdgeInsetsGeometry marginVerticalSmall = const EdgeInsets.symmetric(
    vertical: StyleConstant.marginSmallSize,
  );
  static EdgeInsetsGeometry marginVerticalMedium = const EdgeInsets.symmetric(
    vertical: StyleConstant.marginMediumSize,
  );
  static EdgeInsetsGeometry marginVerticalLarge = const EdgeInsets.symmetric(
    vertical: StyleConstant.marginLargeSize,
  );
  static EdgeInsetsGeometry marginHorizontalSmall = const EdgeInsets.symmetric(
    horizontal: StyleConstant.marginSmallSize,
  );
  static EdgeInsetsGeometry marginHorizontalMedium = const EdgeInsets.symmetric(
    horizontal: StyleConstant.marginMediumSize,
  );
  static EdgeInsetsGeometry marginHorizontalLarge = const EdgeInsets.symmetric(
    horizontal: StyleConstant.marginLargeSize,
  );
  static EdgeInsetsGeometry marginLeftSmall = const EdgeInsets.only(
    left: StyleConstant.marginSmallSize,
  );
  static EdgeInsetsGeometry marginLeftMedium = const EdgeInsets.only(
    left: StyleConstant.marginMediumSize,
  );
  static EdgeInsetsGeometry marginLeftLarge = const EdgeInsets.only(
    left: StyleConstant.marginLargeSize,
  );
  static EdgeInsetsGeometry marginTopSmall = const EdgeInsets.only(
    top: StyleConstant.marginSmallSize,
  );
  static EdgeInsetsGeometry marginTopMedium = const EdgeInsets.only(
    top: StyleConstant.marginMediumSize,
  );
  static EdgeInsetsGeometry marginTopLarge = const EdgeInsets.only(
    top: StyleConstant.marginLargeSize,
  );
  static EdgeInsetsGeometry marginRightSmall = const EdgeInsets.only(
    right: StyleConstant.marginSmallSize,
  );
  static EdgeInsetsGeometry marginRightMedium = const EdgeInsets.only(
    right: StyleConstant.marginMediumSize,
  );
  static EdgeInsetsGeometry marginRightLarge = const EdgeInsets.only(
    right: StyleConstant.marginLargeSize,
  );
  static EdgeInsetsGeometry marginBottomSmall = const EdgeInsets.only(
    bottom: StyleConstant.marginSmallSize,
  );
  static EdgeInsetsGeometry marginBottomMedium = const EdgeInsets.only(
    bottom: StyleConstant.marginMediumSize,
  );
  static EdgeInsetsGeometry marginBottomLarge = const EdgeInsets.only(
    bottom: StyleConstant.marginLargeSize,
  );

  // text form field
  static InputDecoration buildTextFormFieldDecoration({
    required IconData prefixIcon,
    required String hintText,
    Widget? suffixIcon, // ✅ New optional parameter
  }) {
    return InputDecoration(
      contentPadding: AppStyle.paddingAllSmall,
      isDense: true,
      hintText: hintText,
      labelText: hintText,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        color: ColorConstant.disabled,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: ColorConstant.primary,
      ),
      suffixIcon: suffixIcon, // ✅ Use it here
      filled: false,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorConstant.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorConstant.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorConstant.primary),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorConstant.disabled),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorConstant.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorConstant.error),
      ),
      focusColor: ColorConstant.primary,
    );
  }

  static InputDecoration buildTextFormFieldDecorationWithoutIcon() {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(8),
      isDense: true,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        color: ColorConstant.disabled,
      ),
      filled: false,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorConstant.primary,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorConstant.primary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorConstant.primary,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorConstant.disabled,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorConstant.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorConstant.error,
        ),
      ),
      focusColor: ColorConstant.primary,
    );
  }
}
