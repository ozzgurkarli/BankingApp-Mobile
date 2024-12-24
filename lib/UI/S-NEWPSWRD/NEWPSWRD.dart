// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parbank/UI/S-BTMGNRTR/BTMGNRTR.dart';
import 'package:parbank/api/ENV.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/api/URequestTypes.dart';
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
import 'package:pinput/pinput.dart';

class NEWPSWRD extends StatefulWidget {
  DTOLogin dtoLogin;
  NEWPSWRD({super.key, required this.dtoLogin});

  @override
  State<NEWPSWRD> createState() => _NEWPSWRDState();
}

class _NEWPSWRDState extends State<NEWPSWRD> {
  final controller = TextEditingController();
  final verificationController = TextEditingController();
  final focusNode = FocusNode();
  final verificationNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    verificationNode.dispose();
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
          children: [
            Gap(USize.Height / 3),
            ULabel(
              label: Localizer.Get(Localizer.new_password),
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
                    textStyle:
                        GoogleFonts.poppins(fontSize: 19, color: Colors.white),
                    decoration:
                        const BoxDecoration(color: UColor.PrimaryLightColor),
                  ),
                  showCursor: true,
                  focusedPinTheme: PinTheme(
                    width: USize.Width / 9,
                    height: USize.Width / 9,
                    textStyle:
                        GoogleFonts.poppins(fontSize: 19, color: Colors.white),
                    decoration: const BoxDecoration(color: UColor.PrimaryColor),
                  ),
                ),
              ),
            ),
            Gap(USize.Height / 15),
            ULabel(
              label: Localizer.Get(Localizer.new_password__again),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Pinput(
                  obscureText: true,
                  length: 6,
                  controller: verificationController,
                  focusNode: verificationNode,
                  separatorBuilder: (index) => Container(
                    height: USize.Width / 9,
                    width: 2,
                    color: Colors.white,
                  ),
                  defaultPinTheme: PinTheme(
                    width: USize.Width / 9,
                    height: USize.Width / 9,
                    textStyle:
                        GoogleFonts.poppins(fontSize: 19, color: Colors.white),
                    decoration:
                        const BoxDecoration(color: UColor.PrimaryLightColor),
                  ),
                  showCursor: true,
                  focusedPinTheme: PinTheme(
                    width: USize.Width / 9,
                    height: USize.Width / 9,
                    textStyle:
                        GoogleFonts.poppins(fontSize: 19, color: Colors.white),
                    decoration: const BoxDecoration(color: UColor.PrimaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (controller.text.length != 6 ||
              verificationController.text.length != 6) {
            HelperMethods.SetBottomSheet(
                context,
                Localizer.Get(Localizer.incorrect_password_entry) +
                    Localizer.Get(Localizer.password_must_be_6_char_long),
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
          } else if (controller.text != verificationController.text) {
            HelperMethods.SetBottomSheet(
                context,
                Localizer.Get(Localizer.incorrect_password_entry) +
                    Localizer.Get(Localizer.entered_passwords_do_not_match),
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
            HelperMethods.SetLoadingScreen(context);
            widget.dtoLogin.Password = int.parse(controller.text);
            widget.dtoLogin.NotificationToken = ENV.NotificationToken;
            late DTOCustomer customer;
            try {
              await UProxy.Request(URequestTypes.PUT, IService.UPDATE_PASSWORD,
                  MessageContainer.builder({"DTOLogin": widget.dtoLogin}));

              customer = await UProxy.Request(
                      URequestTypes.GET,
                  IService.GET_CUSTOMER_BY_IDENTITY_NO,
                  MessageContainer.builder({
                    "DTOCustomer":
                        DTOCustomer(IdentityNo: widget.dtoLogin.IdentityNo)
                  })).then((value) {
                return DTOCustomer.fromJson(value.GetWithKey("DTOCustomer"));
              });
            } catch (e) {
              HelperMethods.ApiException(context, e.toString());
              return;
            }

            HelperMethods.SetSnackBar(context,
                Localizer.Get(Localizer.password_changed_successfully));
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BTMGNRTR(
                          customer: customer,
                        )),
                (route) => false);
          }
        },
        backgroundColor: UColor.PrimaryColor,
        child: UIcon(
          Icons.arrow_forward,
          color: UColor.WhiteColor,
        ),
      ),
    );
  }
}
