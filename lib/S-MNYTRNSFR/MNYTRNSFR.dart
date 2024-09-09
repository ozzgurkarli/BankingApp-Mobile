// ignore_for_file: must_be_immutable

import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UDropDownButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/USegmentedButton.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/components/UTextField.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/DTOTransfer.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class MNYTRNSFR extends StatefulWidget {
  DTOCustomer customer;
  List? accountList;
  MNYTRNSFR({super.key, required this.accountList, required this.customer});

  @override
  State<MNYTRNSFR> createState() => _MNYTRNSFRState();
}

class _MNYTRNSFRState extends State<MNYTRNSFR> {
  Set<String> segmentSelected = {"0"};

  String? nameSurnameError;
  String? recipientError;
  String? senderAccountError;
  String? amountError;
  String? dateError;

  bool identityNoEnabled = true;
  bool? dateValue = false;
  int? senderAccountValue;
  String? currencyValue;

  TextEditingController recipientController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController nameSurnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (amountController.text.isEmpty) {
      amountController.text = "0.00";
    } else if (amountController.text.length > 2) {
      amountController.text = amountController.text.replaceAll(r'^0+', '');
    }

    if (dateController.text.isEmpty) {
      dateController.text =
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    }
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
            Gap(USize.Height / 20),
            ULabel(
              label: "${Localizer.Get(Localizer.sender_account)}:",
              child: UDropDownButton(
                  errorText: senderAccountError,
                  prefixColor: UColor.PrimaryColor,
                  prefixIcon: const Icon(Icons.account_balance),
                  hintText: "${Localizer.Get(Localizer.select_an_account)}",
                  fillColor: UColor.WhiteHeavyColor,
                  items: widget.accountList!.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Column(
                        children: [
                          UText(
                              "${Localizer.Get(Localizer.balance)}: ${HelperMethods.FormatBalance(e.Balance)} ${e.Currency}"),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (e) {
                    setState(() {
                      identityNoEnabled = e.Currency == "TL";
                      if (!identityNoEnabled) {
                        segmentSelected = {"0"};
                      }
                      senderAccountError = null;
                      senderAccountValue = e.Id;
                      currencyValue = e.Currency;
                    });
                  }),
            ),
            Gap(USize.Height / 25),
            ULabel(
                label: "${Localizer.Get(Localizer.recipient)}:",
                child: USegmentedButton(
                    segments: [
                      ButtonSegment(
                          value: '0',
                          label: UText(
                            "IBAN",
                            fontSize: 14,
                          )),
                      ButtonSegment(
                          value: '1',
                          enabled: identityNoEnabled,
                          label: UText(
                            Localizer.Get(Localizer.identity_no),
                            fontSize: 14,
                          ))
                    ],
                    onSelectionChanged: (p0) {
                      setState(() {
                        recipientController.text = "";
                        segmentSelected = p0;
                      });
                    },
                    selected: segmentSelected)),
            Gap(USize.Height / 67),
            UTextField(
              onTap: () {
                setState(() {
                  recipientError = null;
                });
              },
              controller: recipientController,
              inputFormatters: segmentSelected.first == "0"
                  ? [
                      MaskTextInputFormatter(
                          mask: 'TR## #### #### #### #### #### ##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.eager)
                    ]
                  : [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
              textCapitalization: TextCapitalization.words,
              hintText: segmentSelected.first == "0"
                  ? "IBAN"
                  : Localizer.Get(Localizer.identity_no),
              fillColor: UColor.WhiteHeavyColor,
              errorText: recipientError,
              prefixIcon: const Icon(
                  HugeIcons.strokeRoundedCircleArrowDataTransferHorizontal),
              prefixColor: UColor.PrimaryColor,
            ),
            Gap(USize.Height / 67),
            UTextField(
              onChanged: (p0) {
                setState(() {
                  nameSurnameError = null;
                });
              },
              controller: nameSurnameController,
              textCapitalization: TextCapitalization.words,
              hintText: Localizer.Get(Localizer.namesurname),
              fillColor: UColor.WhiteHeavyColor,
              errorText: nameSurnameError,
              prefixIcon: const Icon(Icons.person_outline),
              prefixColor: UColor.PrimaryColor,
            ),
            Gap(USize.Height / 25),
            ULabel(
              label: "${Localizer.Get(Localizer.amount)}:",
              child: UTextField(
                inputFormatters: [
                  TextInputMask(
                    mask: '9+,999,999.99',
                    reverse: true,
                  )
                ],
                onTap: () {
                  setState(() {
                    if(amountController.text == "0.00"){
                      amountController.text = " ";
                    }
                    amountError = null;
                  });
                },
                controller: amountController,
                hintText: Localizer.Get(Localizer.amount),
                fillColor: UColor.WhiteHeavyColor,
                errorText: amountError,
                prefixIcon: const Icon(HugeIcons.strokeRoundedCash01),
                prefixColor: UColor.PrimaryColor,
              ),
            ),
            Gap(USize.Height / 25),
            ULabel(
              label: "${Localizer.Get(Localizer.transaction_date)}:",
              child: UTextField(
                readOnly: !dateValue!,
                inputFormatters: [MaskTextInputFormatter(mask: "##/##/####")],
                onTap: () {
                  setState(() {
                    dateError = null;
                  });
                },
                controller: dateController,
                hintText: Localizer.Get(Localizer.transaction_date),
                fillColor: UColor.WhiteHeavyColor,
                errorText: dateError,
                prefixIcon: const Icon(Icons.date_range),
                prefixColor: UColor.PrimaryColor,
              ),
            ),
            SizedBox(
              width: USize.Width * 0.72,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      value: dateValue,
                      splashRadius: 0,
                      activeColor: UColor.PrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          dateValue = value;
                        });
                      }),
                  UText(Localizer.Get(
                          Localizer.send_postdated))
                ],
              ),
            ),
            Gap(USize.Height / 25),
            UButton(
                onPressed: () async{
                  if (senderAccountValue == 0 || senderAccountValue == null) {
                    setState(() {
                      senderAccountError = Localizer.Get(
                          Localizer.this_field_cannot_be_left_empty);
                    });
                  }
                  if (recipientController.text.isEmpty) {
                    setState(() {
                      recipientError = Localizer.Get(
                          Localizer.this_field_cannot_be_left_empty);
                    });
                  }
                  if (nameSurnameController.text.isEmpty) {
                    setState(() {
                      nameSurnameError = Localizer.Get(
                          Localizer.this_field_cannot_be_left_empty);
                    });
                  }
                  if (amountController.text.isEmpty) {
                    setState(() {
                      amountError = Localizer.Get(
                          Localizer.this_field_cannot_be_left_empty);
                    });
                  }
                  if (dateController.text.split('/')[2].length != 4) {
                    setState(() {
                      dateError = Localizer.Get(Localizer.date_is_invalid);
                    });
                  }

                  if (dateError != null ||
                      amountError != null ||
                      recipientError != null ||
                      senderAccountError != null ||
                      nameSurnameError != null) {
                    return;
                  }

                  MessageContainer message = MessageContainer();
                  DTOTransfer dtoTransfer = DTOTransfer(
                    Amount:
                        double.parse(amountController.text.replaceAll(',', '')),
                    SenderAccountId: senderAccountValue,
                    SenderCustomerNo: widget.customer.CustomerNo,
                    RecipientAccount: recipientController.text,
                    Currency: currencyValue,
                  );
                  dtoTransfer.OrderDate = DateTime.parse(
                      dateController.text.split('/')[2] +
                          dateController.text.split('/')[1].padLeft(2, '0') +
                          dateController.text.split('/')[0].padLeft(2, '0'));

                  message.Add("DTOTransfer", dtoTransfer);
                  try {
                    await UProxy.Post(IService.START_MONEY_TRANSFER, message);
                  } catch (e) {
                    HelperMethods.ApiException(context, e.toString(),
                        popUntil: 1);
                    return;
                  }

                  HelperMethods.SetSnackBar(
                      context, Localizer.Get(Localizer.transaction_queued));
                  Navigator.pop(context);
                },
                child: UText(
                  Localizer.Get(Localizer.send_money),
                  color: UColor.WhiteColor,
                ))
          ],
        ),
      ),
    );
  }
}
