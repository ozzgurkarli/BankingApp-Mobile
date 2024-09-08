// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:easy_mask/easy_mask.dart';
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
import 'package:parbank/components/UTextField.dart';
import 'package:parbank/dto/DTOCreditCard.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class CRDAPPLC extends StatefulWidget {
  DTOCustomer dtoCustomer;
  List cardTypeList;

  CRDAPPLC({super.key, required this.dtoCustomer, required this.cardTypeList});

  @override
  State<CRDAPPLC> createState() => _CRDAPPLCState();
}

class _CRDAPPLCState extends State<CRDAPPLC> {
  String? billingDayError;
  String? cardTypeError;
  String? requestedLimitError;

  int billingDayValue = 0;
  int cardTypeValue = 0;
  TextEditingController requestedLimitController = TextEditingController();

  List billingDayList = List.generate(30, (x) => x + 1);

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
              label: "*${Localizer.Get(Localizer.card_type)}:",
              child: UDropDownButton(
                  errorText: cardTypeError,
                  prefixColor: UColor.PrimaryColor,
                  prefixIcon: const Icon(Icons.credit_card),
                  hintText: "*${Localizer.Get(Localizer.select_a_card_type)}",
                  fillColor: UColor.WhiteHeavyColor,
                  items: widget.cardTypeList.map((e) {
                    return DropdownMenuItem(
                      value: e.Code,
                      child: UText(e.Description),
                    );
                  }).toList(),
                  onChanged: (e) {
                    setState(() {
                      cardTypeError = null;
                      cardTypeValue = e as int;
                    });
                  }),
            ),
            Gap(USize.Height / 25),
            ULabel(
              label: "*${Localizer.Get(Localizer.billing_day)}:",
              child: UDropDownButton(
                  errorText: billingDayError,
                  prefixColor: UColor.PrimaryColor,
                  prefixIcon: const Icon(Icons.calendar_month),
                  hintText: "*${Localizer.Get(Localizer.select_a_billing_day)}",
                  fillColor: UColor.WhiteHeavyColor,
                  items: billingDayList.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: UText(e.toString()),
                    );
                  }).toList(),
                  onChanged: (e) {
                    setState(() {
                      billingDayError = null;
                      billingDayValue = e;
                    });
                  }),
            ),
            Gap(USize.Height / 25),
            ULabel(
              label: "*${Localizer.Get(Localizer.requested_limit)}:",
              child: UTextField(
                inputFormatters: [
                  TextInputMask(mask: '9+,999,999', reverse: true)
                ],
                onTap: () {
                  setState(() {
                    requestedLimitError = null;
                  });
                },
                controller: requestedLimitController,
                hintText: "*${Localizer.Get(Localizer.requested_limit)}",
                fillColor: UColor.WhiteHeavyColor,
                errorText: requestedLimitError,
                prefixIcon: const Icon(Icons.currency_lira),
                prefixColor: UColor.PrimaryColor,
              ),
            ),
            Gap(USize.Height / 12),
            UButton(
                onPressed: () async {
                  if(cardTypeValue == 0){
                    setState(() {
                      cardTypeError = Localizer.Get(Localizer.this_field_cannot_be_left_empty);
                    });
                  }
                  if(billingDayValue == 0){
                    setState(() {
                      billingDayError = Localizer.Get(Localizer.this_field_cannot_be_left_empty);
                    });
                  }
                  if(requestedLimitController.text.isEmpty){
                    setState(() {
                      requestedLimitError = Localizer.Get(Localizer.this_field_cannot_be_left_empty);
                    });
                  }

                  if (requestedLimitError != null ||
                      billingDayError != null ||
                      cardTypeError != null) {
                    return;
                  }
                  HelperMethods.SetLoadingScreen(context);
                  try {
                    await UProxy.Post(
                        IService.CARD_APPLICATION,
                        MessageContainer.builder({
                          "DTOCreditCard": DTOCreditCard(
                              CustomerNo: widget.dtoCustomer.CustomerNo,
                              Limit:
                                  double.parse(requestedLimitController.text.replaceAll(',', '')),
                              Type: cardTypeValue,
                              BillingDay: billingDayValue)
                        }));
                  } catch (e) {
                    Navigator.pop(context);
                    HelperMethods.ApiException(context, e.toString());
                    return;
                  }

                  HelperMethods.SetSnackBar(
                      context, Localizer.Get(Localizer.card_approved));
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
                child: UText(
                  Localizer.Get(Localizer.approve_application),
                  color: UColor.WhiteColor,
                ))
          ],
        ),
      ),
    );
  }
}
