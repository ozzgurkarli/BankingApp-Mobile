// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class MRKTINFO extends StatefulWidget {
  List Currencies;
  MRKTINFO({super.key, required this.Currencies});

  @override
  State<MRKTINFO> createState() => _MRKTINFOState();
}

class _MRKTINFOState extends State<MRKTINFO> {
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
            SizedBox(
              width: USize.Width,
              height: USize.Height * 0.86,
              child: ListView.builder(
                itemCount: widget.Currencies.length,
                itemBuilder: (context, index) {
                  List<String> currencyLocalizer =
                      widget.Currencies[index].Detail1.split(';');
                  return Container(
                      height: USize.Height / 6,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide())),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                width: USize.Width / 3.5,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    UText(Localizer.Get(currencyLocalizer)),
                                    UText(
                                        widget.Currencies[index].Description),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: USize.Width / 3.5,
                                child: arrowDirections(
                                    double.parse(widget
                                        .Currencies[index].Detail3
                                        .replaceAll(',', '.')),
                                    double.parse(widget
                                        .Currencies[index].Detail4
                                        .replaceAll(',', '.'))),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: USize.Width / 3.5,
                                height: USize.Height / 14,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: UColor.WhiteHeavyColor),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    UText("Alış"),
                                    UText(
                                        "${(double.parse(widget.Currencies[index].Detail4.replaceAll(',', '.')) * (100 + int.parse(widget.Currencies[index].Detail5)) / 100).toStringAsFixed(2)} TL")
                                  ],
                                ),
                              ),
                              Container(
                                width: USize.Width / 3.5,
                                height: USize.Height / 14,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: UColor.WhiteHeavyColor),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    UText("Satış"),
                                    UText(
                                        "${(double.parse(widget.Currencies[index].Detail4.replaceAll(',', '.')) * (100 - int.parse(widget.Currencies[index].Detail5)) / 100).toStringAsFixed(2)} TL")
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  UIcon arrowDirections(double oldValue, double newValue) {
    if (oldValue > newValue) {
      return UIcon(
        Icons.arrow_drop_down,
        color: UColor.RedColor,
        size: 44,
      );
    } else if (oldValue == newValue) {
      return UIcon(
        Icons.unfold_less,
        color: const Color.fromARGB(255, 177, 177, 177),
        size: 44,
      );
    } else {
      return UIcon(
        Icons.arrow_drop_up,
        color: UColor.GreenColor,
        size: 44,
      );
    }
  }
}
