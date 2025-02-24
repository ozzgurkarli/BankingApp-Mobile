// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/api/URequestTypes.dart';
import 'package:parbank/components/UCircularProgressIndicator.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/dto/DTOCreditCard.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class CARDDETL extends StatefulWidget {
  DTOCreditCard cc;
  CARDDETL({super.key, required this.cc});

  @override
  State<CARDDETL> createState() => _CARDDETLState();
}

class _CARDDETLState extends State<CARDDETL> {
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
              height: USize.Height / 20,
            ),
            SizedBox(
              width: USize.Width,
              height: USize.Height / 4.7,
              child: Hero(
                tag: "CreditCard",
                child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: UColor.CardGradients[widget.cc.Type!],
                            transform: const GradientRotation(45)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Stack(
                      children: [
                        Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UText(
                                  HelperMethods.cardNoWithSpaces(
                                      widget.cc.CardNo!),
                                  fontWeight: FontWeight.w700,
                                  color: UColor.WhiteColor,
                                  fontSize: 18,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    UText(
                                        "SKT: ${HelperMethods.toExpirationDate(widget.cc.ExpirationDate!)}",
                                        fontWeight: FontWeight.w600,
                                        color: UColor.WhiteColor),
                                    UText("CVV: ${widget.cc.CVV}",
                                        fontWeight: FontWeight.w600,
                                        color: UColor.WhiteColor),
                                  ],
                                ),
                              ],
                            )),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 18),
                          child: UText(
                            widget.cc.TypeName!,
                            fontWeight: FontWeight.w600,
                            color: UColor.WhiteColor,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 18),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UText(
                                "${Localizer.Get(Localizer.outstanding_balance)}:",
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: UColor.WhiteColor,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  UIcon(
                                    Icons.currency_lira,
                                    color: UColor.WhiteColor,
                                    size: 16,
                                  ),
                                  UText(
                                    HelperMethods.FormatBalance(
                                        widget.cc.OutstandingBalance!),
                                    fontWeight: FontWeight.w600,
                                    color: UColor.WhiteColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Gap(USize.Height / 22),
            FutureBuilder(
              future: UProxy.Request(
                  URequestTypes.GET,
                  IService.SELECT_CC_WITH_DETAILS,
                  MessageContainer.builder({
                    "DTOCreditCard": widget.cc,
                  })),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DTOCreditCard creditCard = DTOCreditCard.fromJson(snapshot.data!.GetWithKey("CreditCard"));

                  return SizedBox(
                    width: USize.Width - 96,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UText(
                              "Durum:",
                              fontWeight: FontWeight.w500,
                            ),
                            UText(creditCard.Active! ? "Aktif" : "Pasif")
                          ],
                        ),
                        Gap(USize.Width / 56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UText(
                              "Hesap Kesim Günü:",
                              fontWeight: FontWeight.w500,
                            ),
                            UText(creditCard.BillingDay.toString())
                          ],
                        ),
                        Gap(USize.Width / 56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UText(
                              "Hesap Kesim Tarihi:",
                              fontWeight: FontWeight.w500,
                            ),
                            UText(DateFormat('dd.MM.yyyy').format(creditCard.AccountClosingDate!))
                          ],
                        ),
                        Gap(USize.Width / 56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UText(
                              "Gelecek Hesap Kesim Tarihi:",
                              fontWeight: FontWeight.w500,
                            ),
                            UText(DateFormat('dd.MM.yyyy').format(creditCard.NextAccountClosingDate!))
                          ],
                        ),
                        Gap(USize.Width / 56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UText(
                              "Kart Türü:",
                              fontWeight: FontWeight.w500,
                            ),
                            UText(creditCard.TypeName!)
                          ],
                        ),
                        Gap(USize.Width / 56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UText(
                              "Yıllık Kart Ücreti:",
                              fontWeight: FontWeight.w500,
                            ),
                            UText("${HelperMethods.FormatBalance(creditCard.TypeFee!)} TL")
                          ],
                        ),
                        Gap(USize.Width / 56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UText(
                              "Kart Limiti:",
                              fontWeight: FontWeight.w500,
                            ),
                            UText("${HelperMethods.FormatBalance(creditCard.Limit!)} TL")
                          ],
                        ),
                        Gap(USize.Width / 56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UText(
                              "Toplam Borç:",
                              fontWeight: FontWeight.w500,
                            ),
                            UText("${HelperMethods.FormatBalance(creditCard.TotalDebt!)} TL")
                          ],
                        ),
                        Gap(USize.Width / 56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UText(
                              "Güncel Borç:",
                              fontWeight: FontWeight.w500,
                            ),
                            UText("${HelperMethods.FormatBalance(creditCard.CurrentDebt!)} TL")
                          ],
                        ),
                        Gap(USize.Width / 56),
                      ],
                    ),
                  );
                } else {
                  return const UCircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
