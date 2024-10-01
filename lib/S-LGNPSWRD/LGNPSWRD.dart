// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:parbank/S-BTMGNRTR/BTMGNRTR.dart';
import 'package:parbank/S-NEWPSWRD/NEWPSWRD.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/components/UTextButton.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/DTOLogin.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UAsset.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';

class LGNPSWRD extends StatefulWidget {
  DTOLogin dtoLogin;
  LGNPSWRD({required this.dtoLogin, super.key});

  @override
  State<LGNPSWRD> createState() => _LGNPSWRDState();
}

class _LGNPSWRDState extends State<LGNPSWRD> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  int remainingAttempts = 3;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UScaffold(
      isLogged: false,
        actions: [
          UTextButton(
            onPressed: () {
              setState(() {
                Localizer.index = Localizer.index == 0 ? 1 : 0;
              });
            },
            child: UText(
              Localizer.Get(Localizer.index_text),
              color: UColor.WhiteColor,
            ),
          )
        ],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(USize.Height / 3.5),
              ULabel(
                label: Localizer.Get(Localizer.password),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Pinput(
                    obscureText: true,
                    length: 6,
                    controller: controller,
                    focusNode: focusNode,
                    separatorBuilder: (index) => Container(
                      height: USize.Width / 9,
                      width: 2,
                      color: Colors.white,
                    ),
                    defaultPinTheme: PinTheme(
                      width: USize.Width / 9,
                      height: USize.Width / 9,
                      textStyle: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white),
                      decoration:
                          const BoxDecoration(color: UColor.PrimaryLightColor),
                    ),
                    showCursor: true,
                    focusedPinTheme: PinTheme(
                      width: USize.Width / 9,
                      height: USize.Width / 9,
                      textStyle: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white),
                      decoration:
                          const BoxDecoration(color: UColor.PrimaryColor),
                    ),
                  ),
                ),
              ),
              Gap(USize.Height / 15),
              UTextButton(
                  child: UText(
                Localizer.Get(Localizer.did_you_forget_your_password),
                color: UColor.PrimaryColor,
                fontWeight: FontWeight.w500,
              )),
              Gap(USize.Height / 4),
              UButton(
                  onPressed: () async {
                    if (remainingAttempts == 0) {
                      return;
                    }

                    if (widget.dtoLogin.Password ==
                        int.tryParse(controller.text)) {
                      HelperMethods.SetLoadingScreen(context);
                      late DTOCustomer customer;
                      try {
                        customer = await UProxy.Get(
                            IService.GET_CUSTOMER_BY_IDENTITY_NO,
                            MessageContainer.builder({
                              "DTOCustomer": DTOCustomer(
                                  IdentityNo: widget.dtoLogin.IdentityNo)
                            })).then((value) {
                          return DTOCustomer.fromJson(
                              value.GetWithKey("DTOCustomer"));
                        });
                      } catch (e) {
                        HelperMethods.ApiException(context, e.toString());
                        return;
                      }
                      if (await HelperMethods.GetFullName() == "") {
                        HelperMethods.InsertData(
                            "${customer.Name!} ${customer.Surname!}",
                            customer.IdentityNo!);
                      }
                      if (widget.dtoLogin.Temporary!) {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NEWPSWRD(
                                      dtoLogin: widget.dtoLogin,
                                    )));
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BTMGNRTR(customer: customer)),
                            (route) => false);
                      }
                    } else if (controller.text.length != 6) {
                      HelperMethods.SetBottomSheet(
                          context,
                          Localizer.Get(Localizer.incorrect_password_entry) +
                              Localizer.Get(
                                  Localizer.password_must_be_6_char_long),
                          UAsset.ERROR_GIF,
                          Localizer.Get(Localizer.error),
                          UButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: UText(
                                Localizer.Get(Localizer.ok),
                                color: UColor.WhiteColor,
                              )));
                    } else {
                      remainingAttempts -= 1;
                      controller.text = "";

                      HelperMethods.SetBottomSheet(
                          context,
                          Localizer.Get(Localizer.incorrect_password_entry) +
                              Localizer.Get(Localizer.remaining_attempts) +
                              remainingAttempts.toString(),
                          UAsset.ERROR_GIF,
                          Localizer.Get(Localizer.error),
                          UButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: UText(
                                Localizer.Get(Localizer.ok),
                                color: UColor.WhiteColor,
                              )));
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UText(
                        Localizer.Get(Localizer.login),
                        color: UColor.WhiteColor,
                      ),
                      Gap(USize.Width / 100),
                      UIcon(
                        Icons.arrow_right,
                        color: UColor.WhiteColor,
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
