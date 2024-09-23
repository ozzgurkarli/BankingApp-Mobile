import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/components/UTextField.dart';
import 'package:parbank/dto/DTOTransactionHistory.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class TRCHSFLT extends StatefulWidget {
  const TRCHSFLT({super.key});

  @override
  State<TRCHSFLT> createState() => _TRCHSFLTState();
}

class _TRCHSFLTState extends State<TRCHSFLT> {
  DTOTransactionHistory filter = DTOTransactionHistory();

  TextEditingController minDateController = TextEditingController();
  TextEditingController maxDateController = TextEditingController();
  TextEditingController minAmountController = TextEditingController();
  TextEditingController maxAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (minAmountController.text.isEmpty) {
      minAmountController.text = "0.00";
    } else if (minAmountController.text.length > 2) {
      minAmountController.text = minAmountController.text.replaceAll(r'^0+', '');
    }
    if (maxAmountController.text.isEmpty) {
      maxAmountController.text = "0.00";
    } else if (maxAmountController.text.length > 2) {
      maxAmountController.text = maxAmountController.text.replaceAll(r'^0+', '');
    }
    return UScaffold(
      leading: UIconButton(
        icon: UIcon(
          Icons.arrow_circle_left_outlined,
          color: UColor.WhiteHeavyColor,
        ),
        onPressed: () {
          Navigator.pop(context, filter);
        },
      ),
      body: Center(
        child: Column(
          children: [
            Gap(USize.Height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ULabel(
                  label: "${Localizer.Get(Localizer.start_date)}:",
                  child: UTextField(
                    width: USize.Width * 0.4,
                    inputFormatters: [
                      MaskTextInputFormatter(mask: "##/##/####")
                    ],
                    controller: minDateController,
                    hintText: Localizer.Get(Localizer.select_a_date),
                    fillColor: UColor.WhiteHeavyColor,
                    prefixIcon: const Icon(Icons.date_range),
                    prefixColor: UColor.PrimaryColor,
                  ),
                ),
                ULabel(
                  label: "${Localizer.Get(Localizer.end_date)}:",
                  child: UTextField(
                    width: USize.Width * 0.4,
                    inputFormatters: [
                      MaskTextInputFormatter(mask: "##/##/####")
                    ],
                    controller: minDateController,
                    hintText: Localizer.Get(Localizer.select_a_date),
                    fillColor: UColor.WhiteHeavyColor,
                    prefixIcon: const Icon(Icons.date_range),
                    prefixColor: UColor.PrimaryColor,
                  ),
                ),
              ],
            ),
            Gap(USize.Height/33),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ULabel(
                  label: "${Localizer.Get(Localizer.lowest_amount)}:",
                  child: UTextField(
                    width: USize.Width * 0.4,
                    inputFormatters: [
                      TextInputMask(
                        mask: '9+,999,999.99',
                        reverse: true,
                      )
                    ],
                    onTap: () {
                      setState(() {
                        if (minAmountController.text == "0.00") {
                          minAmountController.text = " ";
                        }
                      });
                    },
                    controller: minAmountController,
                    hintText: Localizer.Get(Localizer.amount),
                    fillColor: UColor.WhiteHeavyColor,
                    prefixIcon: const Icon(HugeIcons.strokeRoundedCash01),
                    prefixColor: UColor.PrimaryColor,
                  ),
                ),
                ULabel(
                  label: "${Localizer.Get(Localizer.highest_amount)}:",
                  child: UTextField(
                    width: USize.Width * 0.4,
                    inputFormatters: [
                      TextInputMask(
                        mask: '9+,999,999.99',
                        reverse: true,
                      )
                    ],
                    onTap: () {
                      setState(() {
                        if (maxAmountController.text == "0.00") {
                          maxAmountController.text = " ";
                        }
                      });
                    },
                    controller: maxAmountController,
                    hintText: Localizer.Get(Localizer.amount),
                    fillColor: UColor.WhiteHeavyColor,
                    prefixIcon: const Icon(HugeIcons.strokeRoundedCash01),
                    prefixColor: UColor.PrimaryColor,
                  ),
                ),
              ],
            ),
            Gap(USize.Height/20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USize.Width / 10),
              child: UButton(
                redButton: true,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UText(
                      Localizer.Get(Localizer.clear),
                      color: UColor.WhiteColor,
                    ),
                    UIcon(
                      Icons.clear,
                      color: UColor.WhiteColor,
                    )
                  ],
                ),
              ),
            ),
            Gap(USize.Height/100),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USize.Width / 10),
              child: UButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UText(
                      Localizer.Get(Localizer.filter),
                      color: UColor.WhiteColor,
                    ),
                    UIcon(
                      Icons.filter_alt,
                      color: UColor.WhiteColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
