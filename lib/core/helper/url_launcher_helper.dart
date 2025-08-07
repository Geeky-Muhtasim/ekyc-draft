import 'package:bangladesh_finance_ekyc/core/constant/color_contsant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<void> launchUrlInBrowser(String url) async {
    final finalUrl = Uri.parse(url);
    if (!await launchUrl(
      finalUrl,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: 'Bangladesh Finance',
    )) {
      await Fluttertoast.showToast(
        msg: 'Could not launch URL',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstant.error,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }

  static Future<void> launchUrlInApp(String url) async {
    final finalUrl = Uri.parse(url);
    if (!await launchUrl(
      finalUrl,
      mode: LaunchMode.inAppWebView,
      webOnlyWindowName: 'Bangladesh Finance',
    )) {
      await Fluttertoast.showToast(
        msg: 'Could not launch URL',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstant.error,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final launchUri = Uri.parse('tel:$phoneNumber');

    if (!await launchUrl(launchUri, mode: LaunchMode.externalApplication)) {
      await Fluttertoast.showToast(
        msg: 'Could not make call',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstant.error,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }
}
