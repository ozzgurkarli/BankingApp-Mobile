// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:parbank/S-TRCHSFLT/TRCHSFLT.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/dto/DTOTransactionHistory.dart';
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
  List FilteredTransactions = [];
  DTOTransactionHistory filter = DTOTransactionHistory();

  @override
  void initState() {
    FilteredTransactions = widget.Transactions;

    super.initState();
  }

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
                onPressed: () async {
                  filter = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TRCHSFLT(filter: filter,)));
                  FilteredTransactions = widget.Transactions;
                  setState(() {
                    if (filter.MinDate != null &&
                        filter.MinDate!.isAfter(DateTime(1))) {
                      FilteredTransactions = FilteredTransactions.where(
                          (x) => !x.TransactionDate!.isBefore(filter.MinDate)).toList();
                    }
                    if (filter.MaxDate != null &&
                        filter.MaxDate!.isAfter(DateTime(1))) {
                      FilteredTransactions = FilteredTransactions.where(
                          (x) => !x.TransactionDate!.isAfter(filter.MaxDate)).toList();
                    }
                    if (filter.TransactionType != null) {
                      FilteredTransactions = FilteredTransactions.where(
                          (x) => x.TransactionType == filter.TransactionType).toList();
                    }
                    if (filter.MinAmount != null && filter.MinAmount! > 0) {
                      FilteredTransactions = FilteredTransactions = FilteredTransactions.where(
                          (x) => x.Amount.abs() >= filter.MinAmount).toList();
                    }
                    if (filter.MaxAmount != null && filter.MaxAmount! > 0) {
                      FilteredTransactions = FilteredTransactions.where(
                          (x) => x.Amount.abs() <= filter.MaxAmount).toList();
                    }

                    if(filter.Amount != null && filter.Amount! > 0){
                      FilteredTransactions = FilteredTransactions.where((x)=> x.Amount > 0).toList();
                    }
                    else if(filter.Amount != null && filter.Amount! < 0){
                      FilteredTransactions = FilteredTransactions.where((x)=> x.Amount < 0).toList();
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UText(
                      Localizer.Get(Localizer.filter),
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
                  itemCount: FilteredTransactions.length,
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
                                FilteredTransactions[index].Amount > 0
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
                                  fontSize: 13,
                                  color: UColor.BarrierColor,
                                )
                              ],
                            ),
                            UText(
                                "${HelperMethods.RemoveZerosAndFormat(FilteredTransactions[index].Amount.abs())} ${FilteredTransactions[index].Currency}"),
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
