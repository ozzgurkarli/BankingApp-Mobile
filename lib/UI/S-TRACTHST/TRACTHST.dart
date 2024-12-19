// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:parbank/UI/S-TRCHSDTL/TRCHSDTL.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/api/URequestTypes.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/DTOTransactionHistory.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class TRACTHST extends StatefulWidget {
  DTOCustomer customer;
  List Transactions;
  TRACTHST({super.key, required this.customer, required this.Transactions});

  @override
  State<TRACTHST> createState() => _TRACTHSTState();
}

class _TRACTHSTState extends State<TRACTHST> {
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
            Gap(USize.Height/100),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USize.Width/10),
              child: UButton(
                onPressed: ()async {HelperMethods.SetLoadingScreen(context);
                    List transactionList;

                    try {
                      transactionList = await UProxy.Request(
                        URequestTypes.GET,
                          IService.GET_TRANSACTION_HISTORY,
                          MessageContainer.builder({
                            "DTOTransactionHistory": DTOTransactionHistory(
                                CustomerNo: widget.customer.CustomerNo,
                                MinDate: DateTime.now()
                                    .add(const Duration(days: -7)))
                          })).then((value) {
                        return value.GetWithKey("TransactionList");
                      });
                    } catch (e) {
                      HelperMethods.ApiException(context, e.toString());
                      return;
                    }
                    for (var i = 0; i < transactionList.length; i++) {
                      transactionList[i] = DTOTransactionHistory.fromJson(transactionList[i]);
                    }
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TRCHSDTL(Transactions: transactionList)));},
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UText(
                        Localizer.Get(Localizer.view_all_transactions),
                        color: UColor.WhiteColor,
                      ),
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
                                widget.Transactions[index].Amount > 0 ? UText(Localizer.Get(Localizer.incoming), color: Colors.green,) : UText(Localizer.Get(Localizer.outgoing), color: Colors.red,) ,
                                UText(DateFormat('dd/MM/yyyy').format(widget.Transactions[index].TransactionDate), fontSize: 13, color: UColor.BarrierColor,)
                              ],
                            ),
                            UText("${HelperMethods.RemoveZerosAndFormat(widget.Transactions[index].Amount.abs())} ${widget.Transactions[index].Currency}"),
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
