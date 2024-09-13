// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/components/UTextField.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class TRACTHST extends StatefulWidget {
  List Transactions;
  TRACTHST({super.key, required this.Transactions});

  @override
  State<TRACTHST> createState() => _TRACTHSTState();
}

class _TRACTHSTState extends State<TRACTHST> {
  TextEditingController minDateController = TextEditingController();
  TextEditingController maxDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return UScaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ULabel(
                  label: "${Localizer.Get(Localizer.transaction_date)}:",
                  child: UTextField(
                    width: USize.Width * 0.4,
                    inputFormatters: [
                      MaskTextInputFormatter(mask: "##/##/####")
                    ],
                    controller: minDateController,
                    hintText: Localizer.Get(Localizer.transaction_date),
                    fillColor: UColor.WhiteHeavyColor,
                    prefixIcon: const Icon(Icons.date_range),
                    prefixColor: UColor.PrimaryColor,
                  ),
                ),
                ULabel(
                  label: "${Localizer.Get(Localizer.transaction_date)}:",
                  child: UTextField(
                    width: USize.Width * 0.4,
                    inputFormatters: [
                      MaskTextInputFormatter(mask: "##/##/####")
                    ],
                    controller: minDateController,
                    hintText: Localizer.Get(Localizer.transaction_date),
                    fillColor: UColor.WhiteHeavyColor,
                    prefixIcon: const Icon(Icons.date_range),
                    prefixColor: UColor.PrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
                width: USize.Width,
                height: USize.Height * 0.8,
                child: ListView.builder(
                  itemCount: widget.Transactions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: widget.Transactions[index][1],
                      child: Container(
                        height: USize.Height / 12,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide())),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UText(widget.Transactions[index][0]),
                                UIcon(Icons.keyboard_arrow_right_outlined)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
