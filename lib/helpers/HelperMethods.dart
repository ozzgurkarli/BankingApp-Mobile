// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:parbank/components/UCircularProgressIndicator.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:intl/intl.dart';
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
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return const UCircularProgressIndicator();
      },
    );
  }

  static String accountNoToIBAN(
      int branchNo, String accountNo, bool withSpace) {
    String iban = "TR11${branchNo.toString().padLeft(6, '0')}$accountNo";

    if (withSpace) {
      return "${iban.substring(0, 4)} ${iban.substring(4, 8)} ${iban.substring(8, 12)} ${iban.substring(12, 16)} ${iban.substring(16, 20)} ${iban.substring(20, 24)} ${iban.substring(24)}";
    }
    return iban;
  }

  static String toExpirationDate(DateTime expirationDate) {
    return "${expirationDate.month}/${expirationDate.year.toString().substring(2)}";
  }

  static String cardNoWithSpaces(String cardNo) {
    return "${cardNo.substring(0, 4)} ${cardNo.substring(4, 8)} ${cardNo.substring(8, 12)} ${cardNo.substring(12)}";
  }

  static InsertData(String fullName, String identityNo) async {
    var sp = await SharedPreferences.getInstance();

    sp.setString("IdentityNo", identityNo);
    sp.setString("FullName", fullName);
  }

  static String FormatBalance(double balance) {
    NumberFormat formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(balance);
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

  static RemoveZerosAndFormat(double number) {
    
    NumberFormat formatter = NumberFormat('#,##0.00', 'en_US');
    String num = formatter.format(number);

    while (num.characters.last == '0'){
      num = num.substring(0, num.length - 1);

      if (num.characters.last == '.') {
        num = num.substring(0, num.length - 1);
        break;
      }
    }
    return num;
  }

  static SetSnackBar(BuildContext context, String text,
      {bool errorBar = false,
      Duration duration = const Duration(seconds: 5),
      GestureTapCallback? onTap}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.all(USize.Height / 20),
      content: GestureDetector(onTap: onTap, child: Align(alignment: Alignment.center, child: UText(text, color: UColor.WhiteColor,))),
      duration: duration,
      backgroundColor: errorBar
          ? UColor.RedHeavyColor
          : UColor.PrimaryLightColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      showCloseIcon: true,
      closeIconColor:
          errorBar ? UColor.WhiteColor : UColor.PrimaryColor,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static SetBottomSheet(BuildContext context, String bodyText, String asset,
      String labelText, Widget button) {
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
                  fontSize: 26,
                ),
                Gap(USize.Height / 25),
                HelperMethods.ShowAsset(
                  asset,
                  height: USize.Height / 8,
                  width: USize.Height / 8,
                ),
                Gap(USize.Height / 44),
                Container(
                    width: USize.Width * 0.75,
                    alignment: Alignment.center,
                    child: Text(
                      bodyText,
                      textAlign: TextAlign.center,
                    )),
                Gap(USize.Height / 17),
                button
              ],
            ),
          ),
        );
      },
    );
  }

  static ApiException(BuildContext context, String exception, {int? popUntil}) {
    HelperMethods.SetSnackBar(context, exception.toString(),
          errorBar: true);
      Navigator.pop(context);
    // showModalBottomSheet(
    //   context: context,
    //   barrierColor: UColor.BarrierColor,
    //   backgroundColor: Colors.black,
    //   shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(45), topRight: Radius.circular(45))),
    //   isScrollControlled: true,
    //   builder: (context) {
    //     return Container(
    //       decoration: const BoxDecoration(
    //           color: UColor.WhiteColor,
    //           borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(45), topRight: Radius.circular(45))),
    //       height: USize.Height / 2.2,
    //       child: Center(
    //         child: Column(
    //           children: [
    //             Gap(USize.Height / 55),
    //             UText(
    //               Localizer.Get(Localizer.error),
    //               fontWeight: FontWeight.w500,
    //               fontSize: 26,
    //             ),
    //             Gap(USize.Height / 33),
    //             HelperMethods.ShowAsset(
    //               UAsset.NETWORK_ERROR,
    //               height: USize.Height / 8,
    //               width: USize.Height / 8,
    //             ),
    //             Gap(USize.Height / 55),
    //             Expanded(
    //               child: SingleChildScrollView(
    //                 child: UText(Localizer.Get(Localizer.error_database) + exception),
    //               ),
    //             ),
    //             Gap(USize.Height / 100),
    //             UButton(
    //                 onPressed: () {
    //                   int count = 0;
    //                   popUntil = popUntil ?? 2;
    //                   Navigator.of(context)
    //                       .popUntil((_) => count++ >= popUntil!);
    //                 },
    //                 child: UText(
    //                   Localizer.Get(Localizer.ok),
    //                   color: UColor.WhiteColor,
    //                 )),
    //             Gap(USize.Height / 50),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
