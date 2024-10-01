// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/helpers/USize.dart';

class ALLTRNSC extends StatefulWidget {
  DTOCustomer customer;
  List Transactions;
  ALLTRNSC({super.key, required this.customer, required this.Transactions});

  @override
  State<ALLTRNSC> createState() => _ALLTRNSCState();
}

class _ALLTRNSCState extends State<ALLTRNSC> {
  @override
  Widget build(BuildContext context) {
    return UScaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: USize.Width,
              height: USize.Height * 0.8,
              child: ListView.builder(itemCount: widget.Transactions.length, itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: widget.Transactions[index][1],
                  child: Container(
                      height: USize.Height/15,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration:
                          const BoxDecoration(border: Border(bottom: BorderSide())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UText(widget.Transactions[index][0]),
                          UIcon(Icons.keyboard_arrow_right_outlined)
                        ],
                      ),
                    ),
                );
              },)
            ),
          ],
        ),
      ),
    );
  }
}
