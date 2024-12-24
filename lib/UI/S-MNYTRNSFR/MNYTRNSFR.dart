// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/api/URequestTypes.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UDropDownButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/USegmentedButton.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/components/UTextButton.dart';
import 'package:parbank/components/UTextField.dart';
import 'package:parbank/dto/DTOAccount.dart';
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
  bool parbankCustomer = false;

  DTOAccount? selectedAccount;

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
                      selectedAccount = e;
                    });
                  }),
            ),
            Gap(USize.Height / 25),
            ULabel(
                label: "${Localizer.Get(Localizer.recipient)}:",
                tailWidget: UTextButton(
                  child: UText(
                    "Kayıtlı Alıcılar",
                    fontSize: 13,
                    color: UColor.PrimaryColor,
                  ),
                  onPressed: () {},
                ),
                child: USegmentedButton(
                    segments: [
                      ButtonSegment(
                          value: '0',
                          label: UText(
                            "IBAN",
                            fontSize: 13,
                          )),
                      ButtonSegment(
                          value: '1',
                          enabled: identityNoEnabled,
                          label: UText(
                            Localizer.Get(Localizer.identity_no),
                            fontSize: 13,
                          ))
                    ],
                    onSelectionChanged: (p0) {
                      setState(() {
                        parbankCustomer = false;
                        nameSurnameController.text = "";
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
              onSubmitted1: (p0) async {
                checkRecipient();
              },
              onSubmitted2: (p0) {
                checkRecipient();
              },
              fontSize: segmentSelected.first == "0" ? 11.5 : 15,
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
              readOnly: parbankCustomer,
              onTap: () {
                checkRecipient();
              },
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
                    if (amountController.text == "0.00") {
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
                hintText: Localizer.Get(Localizer.select_a_date),
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
                  UText(Localizer.Get(Localizer.send_postdated))
                ],
              ),
            ),
            Gap(USize.Height / 25),
            UButton(
                onPressed: () async {
                  if (selectedAccount == null) {
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
                    SenderAccountNo: selectedAccount!.AccountNo,
                    SenderCustomerNo: widget.customer.CustomerNo,
                    RecipientAccountNo: recipientController.text,
                    Currency: selectedAccount!.Currency,
                  );
                  dtoTransfer.OrderDate = DateTime.parse(
                      dateController.text.split('/')[2] +
                          dateController.text.split('/')[1].padLeft(2, '0') +
                          dateController.text.split('/')[0].padLeft(2, '0'));

                  message.Add("DTOTransfer", dtoTransfer);
                  try {
                    await UProxy.Request(URequestTypes.POST,IService.START_MONEY_TRANSFER, message);
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

  void checkRecipient() async {
    if (!parbankCustomer &&
            (segmentSelected.first == "0" &&
                recipientController.text.length == 32 &&
                recipientController.text.substring(2, 4) == "11") ||
        (segmentSelected.first == "1" &&
            recipientController.text.length == 11)) {
      HelperMethods.SetLoadingScreen(context);
      DTOCustomer dtoCustomer;

      try {
        dtoCustomer = await UProxy.Request(
                      URequestTypes.GET,
            IService.CHECK_RECIPIENT_CUSTOMER,
            MessageContainer.builder({
              "DTOTransfer":
                  DTOTransfer(RecipientAccountNo: recipientController.text, SenderCustomerNo: widget.customer.CustomerNo),
            })).then((value) {
          return DTOCustomer.fromJson(value.GetWithKey("DTOCustomer"));
        });
      } catch (e) {
        HelperMethods.ApiException(context, e.toString());
        return;
      }

      setState(() {
        Navigator.pop(context);
        parbankCustomer = true;
        nameSurnameController.text =
            "${dtoCustomer.Name} ${dtoCustomer.Surname}";
      });
    }
  }
}
