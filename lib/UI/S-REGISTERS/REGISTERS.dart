// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:parbank/UI/S-LGNIDNTY/LGNIDNTY.dart';
import 'package:parbank/api/ENV.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/api/URequestTypes.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UDropDownButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/components/UTextButton.dart';
import 'package:parbank/components/UTextField.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/DTOLogin.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UAsset.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';
import 'package:easy_mask/easy_mask.dart';

class REGISTERS extends StatefulWidget {
  DTOCustomer dtoCustomer;
  List cityList;
  List districtList;
  List professionList;
  List genderList;
  REGISTERS(
      {super.key,
      required this.dtoCustomer,
      required this.districtList,
      required this.professionList,
      required this.genderList,
      required this.cityList});

  @override
  State<REGISTERS> createState() => _REGISTERSState();
}

class _REGISTERSState extends State<REGISTERS> {
  String? cityError;
  String? districtError;
  String? professionError;
  String? genderError;
  String? incomeError;

  int cityValue = 0;
  int? districtValue;
  int genderValue = 0;
  int professionValue = 0;
  TextEditingController incomeController = TextEditingController();

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
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
            Gap(USize.Height / 27),
            ULabel(
              label: "${Localizer.Get(Localizer.gender)}:",
              child: UDropDownButton(
                  errorText: genderError,
                  prefixColor: UColor.PrimaryColor,
                  prefixIcon: const Icon(Icons.wc),
                  hintText: "${Localizer.Get(Localizer.select_a_gender)}",
                  fillColor: UColor.WhiteHeavyColor,
                  items: widget.genderList.map((e) {
                    List<String> genderLocalizer = e.Description.split(';');
                    return DropdownMenuItem(
                      value: e.Code,
                      child: UText(Localizer.Get(genderLocalizer)),
                    );
                  }).toList(),
                  onChanged: (e) {
                    setState(() {
                      genderError = null;
                      genderValue = e as int;
                    });
                  }),
            ),
            Gap(USize.Height / 33),
            ULabel(
              label: "${Localizer.Get(Localizer.city)}:",
              child: UDropDownButton(
                  errorText: cityError,
                  prefixColor: UColor.PrimaryColor,
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  hintText: "${Localizer.Get(Localizer.select_a_city)}",
                  fillColor: UColor.WhiteHeavyColor,
                  items: widget.cityList.map((e) {
                    return DropdownMenuItem(
                      value: e.Code,
                      child: UText(e.Description!),
                    );
                  }).toList(),
                  onChanged: (e) {
                    setState(() {
                      districtValue = null;
                      cityError = null;
                      cityValue = e as int;
                    });
                  }),
            ),
            Gap(USize.Height / 33),
            ULabel(
              label: "${Localizer.Get(Localizer.district)}:",
              child: UDropDownButton(
                  errorText: districtError,
                  value: districtValue,
                  prefixColor: UColor.PrimaryColor,
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  hintText: "${Localizer.Get(Localizer.select_a_district)}",
                  fillColor: UColor.WhiteHeavyColor,
                  items: widget.districtList
                      .where((x) => x.Detail1 == cityValue.toString())
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.Code,
                      child: UText(e.Description!),
                    );
                  }).toList(),
                  onChanged: (e) {
                    setState(() {
                      districtError = null;
                      districtValue = e as int;
                    });
                  }),
            ),
            Gap(USize.Height / 33),
            ULabel(
              label: "${Localizer.Get(Localizer.profession)}:",
              child: UDropDownButton(
                  errorText: professionError,
                  prefixColor: UColor.PrimaryColor,
                  prefixIcon: const Icon(Icons.cabin),
                  hintText: "${Localizer.Get(Localizer.select_a_profession)}",
                  fillColor: UColor.WhiteHeavyColor,
                  items: widget.professionList.map((e) {
                    List<String> professionLocalizer = e.Description.split(';');
                    return DropdownMenuItem(
                      value: e.Code,
                      child: UText(Localizer.Get(professionLocalizer)),
                    );
                  }).toList(),
                  onChanged: (e) {
                    setState(() {
                      professionError = null;
                      professionValue = e as int;
                    });
                  }),
            ),
            Gap(USize.Height / 33),
            ULabel(
              label: "${Localizer.Get(Localizer.monthly_income)}:",
              child: UTextField(
                inputFormatters: [TextInputMask(mask: '9+,999', reverse: true)],
                onTap: () {
                  setState(() {
                    incomeError = null;
                  });
                },
                controller: incomeController,
                hintText: "${Localizer.Get(Localizer.monthly_income)}",
                fillColor: UColor.WhiteHeavyColor,
                errorText: incomeError,
                prefixIcon: const Icon(Icons.currency_lira),
                prefixColor: UColor.PrimaryColor,
              ),
            ),
            Gap(USize.Height / 33),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            incomeError = !incomeController.text.isNotEmpty
                ? Localizer.Get(Localizer.this_field_cannot_be_left_empty)
                : null;
            genderError = genderValue == 0
                ? Localizer.Get(Localizer.this_field_cannot_be_left_empty)
                : null;
            cityError = cityValue == 0
                ? Localizer.Get(Localizer.this_field_cannot_be_left_empty)
                : null;
            districtError = districtValue == 0
                ? Localizer.Get(Localizer.this_field_cannot_be_left_empty)
                : null;
            professionError = professionValue == 0
                ? Localizer.Get(Localizer.this_field_cannot_be_left_empty)
                : null;
          });

          if (incomeError == null &&
              genderError == null &&
              cityError == null &&
              districtError == null &&
              professionError == null) {
            widget.dtoCustomer.Branch = districtValue;
            widget.dtoCustomer.Gender = genderValue;
            widget.dtoCustomer.Profession = professionValue;
            widget.dtoCustomer.Salary =
                double.parse(incomeController.text.replaceAll(',', ''));

            HelperMethods.SetLoadingScreen(context);

            try {
              await UProxy.Request(
                  URequestTypes.POST,
                  IService.CREATE_CUSTOMER,
                  MessageContainer.builder({
                    "DTOCustomer": widget.dtoCustomer,
                    "DTOLogin":
                        DTOLogin(NotificationToken: ENV.NotificationToken, IdentityNo: widget.dtoCustomer.IdentityNo)
                  }));

              Navigator.pop(context);
              HelperMethods.InsertData(
                  "${widget.dtoCustomer.Name!} ${widget.dtoCustomer.Surname!}",
                  widget.dtoCustomer.IdentityNo!);

              HelperMethods.SetBottomSheet(
                  context,
                  Localizer.Get(Localizer.account_created),
                  UAsset.CHECK,
                  Localizer.Get(Localizer.success),
                  UButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LGNIDNTY()),
                            (route) => false);
                      },
                      child: UText(
                        Localizer.Get(Localizer.ok),
                        color: UColor.WhiteColor,
                      )));
            } catch (e) {
              HelperMethods.ApiException(context, e.toString());
              return;
            }
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
