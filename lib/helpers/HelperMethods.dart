// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UCircularProgressIndicator.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UAsset.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperMethods {
  static Widget ShowAsset(String path, {double? height, double? width}) {
    return Image.asset(
      path,
      height: height ?? USize.Height,
      width: width ?? USize.Width,
      fit: BoxFit.fill,
    );
  }

  static SetLoadingScreen(BuildContext context) {
    showDialog<void>(
      barrierColor: UColor.BarrierColor,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const UCircularProgressIndicator();
      },
    );
  }

  static InsertData(String fullName, String identityNo) async {
    var sp = await SharedPreferences.getInstance();

    sp.setString("IdentityNo", identityNo);
    sp.setString("FullName", fullName);
  }
  
  static DeleteData() async {
    var sp = await SharedPreferences.getInstance();
    
    await sp.remove("IdentityNo");
    await sp.remove("FullName");
  }

  static Future<String?> GetIdentityNo() async {
    var sp = await SharedPreferences.getInstance();

    return sp.getString("IdentityNo") ?? "";
  }

  static Future<String?> GetFullName() async {
    var sp = await SharedPreferences.getInstance();

    return sp.getString("FullName") ?? "";
  }

  static SetSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.all(USize.Height / 20),
      content: Align(alignment: Alignment.center, child: UText(text)),
      backgroundColor: UColor.PrimaryLightColor,
      showCloseIcon: true,
      closeIconColor: UColor.PrimaryColor,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static SetBottomSheet(BuildContext context, String bodyText, String asset, String labelText, Widget button) {
    showModalBottomSheet(
      context: context,
      barrierColor: UColor.BarrierColor,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45))),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: UColor.WhiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45))),
          height: USize.Height / 2.2,
          child: Center(
            child: Column(
              children: [
                Gap(USize.Height / 44),
                UText(
                  labelText,
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
                Gap(USize.Height / 25),
                HelperMethods.ShowAsset(
                  asset,
                  height: USize.Height / 8,
                  width: USize.Height / 8,
                ),
                Gap(USize.Height / 44),
                Container(width: USize.Width * 0.75, alignment: Alignment.center, child: Text(bodyText, textAlign: TextAlign.center,)),
                Gap(USize.Height / 17),
                button
              ],
            ),
          ),
        );
      },
    );
  }

  static ApiException(BuildContext context, String exception) {
    showModalBottomSheet(
      context: context,
      barrierColor: UColor.BarrierColor,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45))),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: UColor.WhiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45))),
          height: USize.Height / 2.2,
          child: Center(
            child: Column(
              children: [
                Gap(USize.Height / 44),
                UText(
                  Localizer.Get(Localizer.error),
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
                Gap(USize.Height / 25),
                HelperMethods.ShowAsset(
                  UAsset.ERROR_GIF,
                  height: USize.Height / 8,
                  width: USize.Height / 8,
                ),
                Gap(USize.Height / 44),
                UText(Localizer.Get(Localizer.error_database) + exception),
                Gap(USize.Height / 17),
                UButton(
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                    child: UText(
                      Localizer.Get(Localizer.ok),
                      color: UColor.WhiteColor,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
