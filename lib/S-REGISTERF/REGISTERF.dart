// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:parbank/S-REGISTERS/REGISTERS.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/components/UTextButton.dart';
import 'package:parbank/components/UTextField.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class REGISTERF extends StatefulWidget {
  List cityList;
  List districtList;
  List professionList;
  List genderList;
  REGISTERF(
      {super.key,
      required this.districtList,
      required this.cityList,
      required this.professionList,
      required this.genderList});

  @override
  State<REGISTERF> createState() => _REGISTERFState();
}

class _REGISTERFState extends State<REGISTERF> {
  String? mailError;
  String? nameError;
  String? surnameError;
  String? identityError;
  String? phoneError;
  TextEditingController mailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController identityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
            Gap(USize.Height / 27),
            UText(
              "Müşteri Bilgileri",
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            Gap(USize.Height / 27),
            ULabel(
              label: "*${Localizer.Get(Localizer.name)}:",
              child: UTextField(
                onChanged: (p0) {
                  setState(() {
                    nameError = null;
                  });
                },
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                hintText: "*${Localizer.Get(Localizer.name)}",
                fillColor: UColor.WhiteHeavyColor,
                errorText: nameError,
                prefixIcon: const Icon(Icons.person_outline),
                prefixColor: UColor.PrimaryColor,
              ),
            ),
            Gap(USize.Height / 33),
            ULabel(
              label: "*${Localizer.Get(Localizer.surname)}:",
              child: UTextField(
                onChanged: (p0) {
                  setState(() {
                    surnameError = null;
                  });
                },
                controller: surnameController,
                textCapitalization: TextCapitalization.words,
                hintText: "*${Localizer.Get(Localizer.surname)}",
                fillColor: UColor.WhiteHeavyColor,
                errorText: surnameError,
                prefixIcon: const Icon(Icons.person_outline),
                prefixColor: UColor.PrimaryColor,
              ),
            ),
            Gap(USize.Height / 33),
            ULabel(
              label: "*${Localizer.Get(Localizer.identity_no)}:",
              child: UTextField(
                onChanged: (p0) {
                  setState(() {
                    identityError = null;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                controller: identityController,
                keyboardType: TextInputType.number,
                hintText: "*${Localizer.Get(Localizer.identity_no)}",
                fillColor: UColor.WhiteHeavyColor,
                errorText: identityError,
                prefixIcon: const Icon(Icons.branding_watermark_outlined),
                prefixColor: UColor.PrimaryColor,
              ),
            ),
            Gap(USize.Height / 33),
            ULabel(
              label: "*${Localizer.Get(Localizer.email)}:",
              child: UTextField(
                onChanged: (p0) {
                  setState(() {
                    mailError = null;
                  });
                },
                controller: mailController,
                hintText: "*${Localizer.Get(Localizer.email)}",
                fillColor: UColor.WhiteHeavyColor,
                errorText: mailError,
                prefixIcon: const Icon(Icons.email_outlined),
                prefixColor: UColor.PrimaryColor,
              ),
            ),
            Gap(USize.Height / 33),
            GestureDetector(
              onTap: () {
                phoneError = null;
              },
              child: ULabel(
                label: "*${Localizer.Get(Localizer.phone_no)}:",
                child: UTextField(
                  inputFormatters: [
                    MaskTextInputFormatter(
                        mask: '+90 (###) ###-##-##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.eager)
                  ],
                  onTap: () {
                    setState(() {
                      phoneError = null;
                    });
                  },
                  controller: phoneController,
                  hintText: "*${Localizer.Get(Localizer.phone_no)}",
                  fillColor: UColor.WhiteHeavyColor,
                  errorText: phoneError,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.phone_iphone_outlined),
                  prefixColor: UColor.PrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            nameError = !nameController.text.isNotEmpty
                ? Localizer.Get(Localizer.this_field_cannot_be_left_empty)
                : null;
            surnameError = !surnameController.text.isNotEmpty
                ? Localizer.Get(Localizer.this_field_cannot_be_left_empty)
                : null;
            identityError = !identityController.text.isNotEmpty
                ? Localizer.Get(Localizer.this_field_cannot_be_left_empty)
                : identityController.text.length != 11
                    ? Localizer.Get(Localizer.identity_no_must_be_11_char_long)
                    : null;
            mailError = !mailController.text.isNotEmpty
                ? Localizer.Get(Localizer.this_field_cannot_be_left_empty)
                : (mailController.text.split("@").length < 2 &&
                        mailController.text.split(".com").length < 2)
                    ? Localizer.Get(Localizer.email_is_invalid)
                    : null;
            phoneError = !(phoneController.text.length > 18)
                ? Localizer.Get(Localizer.phoneno_is_invalid)
                : null;
          });

          if (nameError == null &&
              surnameError == null &&
              mailError == null &&
              phoneError == null &&
              identityError == null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => REGISTERS(
                          dtoCustomer: DTOCustomer(
                              Name: nameController.text,
                              Surname: surnameController.text,
                              PhoneNo: phoneController.text,
                              IdentityNo: identityController.text,
                              PrimaryMailAddress: mailController.text),
                          cityList: widget.cityList,
                          districtList: widget.districtList,
                          professionList: widget.professionList,
                          genderList: widget.genderList,
                        )));
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
