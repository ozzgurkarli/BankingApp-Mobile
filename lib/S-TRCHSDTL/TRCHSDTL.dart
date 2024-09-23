// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class TRCHSDTL extends StatefulWidget {
  List Transactions;
  TRCHSDTL({super.key, required this.Transactions});

  @override
  State<TRCHSDTL> createState() => _TRCHSDTLState();
}

class _TRCHSDTLState extends State<TRCHSDTL> {
  @override
  Widget build(BuildContext context) {
    return UScaffold(
      leading: UIconButton(
        icon: UIcon(
          Icons.arrow_circle_left_outlined,
          color: UColor.WhiteHeavyColor,
        ),
        onPressed: () {
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);
        },
      ),
      body: Center(
        child: Column(
          children: [
            Gap(USize.Height / 100),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USize.Width / 10),
              child: UButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UText(
                      "Filtrele",
                      color: UColor.WhiteColor,
                    ),
                    UIcon(
                      Icons.filter_alt_outlined,
                      color: UColor.WhiteColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
                width: USize.Width,
                height: USize.Height * 0.86,
                child: ListView.builder(
                  itemCount: widget.Transactions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        height: USize.Height / 12,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.Transactions[index].Amount > 0
                                    ? UText(
                                        Localizer.Get(Localizer.incoming),
                                        color: Colors.green,
                                      )
                                    : UText(
                                        Localizer.Get(Localizer.outgoing),
                                        color: Colors.red,
                                      ),
                                UText(
                                  DateFormat('dd/MM/yyyy').format(widget
                                      .Transactions[index].TransactionDate),
                                  fontSize: 14,
                                  color: UColor.BarrierColor,
                                )
                              ],
                            ),
                            UText(
                                "${HelperMethods.RemoveZeros(widget.Transactions[index].Amount.abs().toString())} ${widget.Transactions[index].Currency}"),
                            UIcon(Icons.keyboard_arrow_right_outlined)
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
