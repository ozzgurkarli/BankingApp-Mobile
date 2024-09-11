// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UDropDownButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/dto/DTOAccount.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class OPENACCT extends StatefulWidget {
  DTOCustomer dtoCustomer;
  List cityList;
  List districtList;
  List currencyList;
  OPENACCT(
      {super.key,
      required this.dtoCustomer,
      required this.districtList,
      required this.currencyList,
      required this.cityList});

  @override
  State<OPENACCT> createState() => _OPENACCTState();
}

class _OPENACCTState extends State<OPENACCT> {
  String? cityError;
  String? districtError;
  String? currencyError;

  int cityValue = 0;
  int? districtValue;
  int currencyValue = 0;

  @override
  Widget build(BuildContext context) {
    return UScaffold(
      leading: UIconButton(
        icon: UIcon(
          Icons.arrow_circle_left_outlined,
          color: UColor.WhiteHeavyColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Column(
          children: [
            Gap(USize.Height / 6),
            ULabel(
              label: "${Localizer.Get(Localizer.currency_type)}:",
              child: UDropDownButton(
                  errorText: currencyError,
                  prefixColor: UColor.PrimaryColor,
                  prefixIcon: const Icon(Icons.currency_exchange),
                  hintText: "${Localizer.Get(Localizer.select_a_currency)}",
                  fillColor: UColor.WhiteHeavyColor,
                  items: widget.currencyList.map((e) {
                    List<String> currencyLocalizer = e.Detail1.split(';');
                    return DropdownMenuItem(
                      value: e.Code,
                      child: UText(e.Description +
                          " - " +
                          Localizer.Get(currencyLocalizer)),
                    );
                  }).toList(),
                  onChanged: (e) {
                    setState(() {
                      cityValue = 1;
                      currencyError = null;
                      currencyValue = e as int;
                    });
                  }),
            ),
            Gap(USize.Height / 25),
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
            Gap(USize.Height / 25),
            ULabel(
              label: "${Localizer.Get(Localizer.district)}:",
              child: UDropDownButton(
                  errorText: districtError,
                  prefixColor: UColor.PrimaryColor,
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  hintText: "${Localizer.Get(Localizer.select_a_district)}",
                  fillColor: UColor.WhiteHeavyColor,
                  value: districtValue,
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
            Gap(USize.Height / 12),
            UButton(
                onPressed: () async {
                  if (cityValue == 0) {
                    setState(() {
                      cityError = Localizer.Get(
                          Localizer.this_field_cannot_be_left_empty);
                    });
                  }
                  if (currencyValue == 0) {
                    setState(() {
                      currencyError = Localizer.Get(
                          Localizer.this_field_cannot_be_left_empty);
                    });
                  }
                  if (districtValue == 0) {
                    setState(() {
                      districtError = Localizer.Get(
                          Localizer.this_field_cannot_be_left_empty);
                    });
                  }

                  if (districtError != null ||
                      cityError != null ||
                      currencyError != null) {
                    return;
                  }
                  HelperMethods.SetLoadingScreen(context);
                  try {
                    await UProxy.Post(
                        IService.ADD_ACCOUNT,
                        MessageContainer.builder({
                          "DTOAccount": DTOAccount(
                              Branch: districtValue,
                              Primary: false,
                              CurrencyCode: currencyValue.toString(),
                              Currency: widget.currencyList
                                  .firstWhere((x) => x.Code == currencyValue)
                                  .Description,
                              CustomerNo: widget.dtoCustomer.CustomerNo)
                        }));
                  } catch (e) {
                    Navigator.pop(context);
                    HelperMethods.ApiException(context, e.toString());
                    return;
                  }

                  HelperMethods.SetSnackBar(
                      context, Localizer.Get(Localizer.account_added));
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
                child: UText(
                  Localizer.Get(Localizer.open_an_account),
                  color: UColor.WhiteColor,
                ))
          ],
        ),
      ),
    );
  }
}
