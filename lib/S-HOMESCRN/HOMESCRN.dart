// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/components/UCircularProgressIndicator.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/dto/DTOAccount.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class HOMESCRN extends StatefulWidget {
  DTOCustomer customer;
  HOMESCRN({super.key, required this.customer});

  @override
  State<HOMESCRN> createState() => _HOMESCRNState();
}

class _HOMESCRNState extends State<HOMESCRN> {
  @override
  Widget build(BuildContext context) {
    return UScaffold(
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: UIconButton(
            icon: const Icon(
              Icons.person_outline,
              color: UColor.WhiteColor,
            ),
            iconSize: 27,
          ),
        )
      ],
      body: Center(
        child: Column(
          children: [
            Gap(USize.Height / 33),
            ULabel(
              label: Localizer.Get(Localizer.my_accounts),
              labelPadding: 32,
              child: SizedBox(
                  width: USize.Width,
                  height: USize.Height / 4.7,
                  child: FutureBuilder(
                    future: UProxy.Get(
                        IService.GET_ACCOUNTS,
                        MessageContainer.builder({
                          "DTOAccount": DTOAccount(
                              CustomerNo: widget.customer.CustomerNo),
                        })),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List accList = snapshot.data!.GetWithKey("AccountList");

                        if (accList.isNotEmpty && accList.first is Map) {
                          for (var i = 0; i < accList.length; i++) {
                            accList[i] = DTOAccount.fromJson(accList[i]);
                          }
                        }
                        return PageView.builder(
                          itemCount: accList.length,
                          itemBuilder: (context, index) {
                            return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                color: UColor.PrimaryLightColor,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 18),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          UText(
                                            "${Localizer.Get(Localizer.currency_type)}:",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: UColor.WhiteColor,
                                          ),
                                          UText(
                                                accList[index].Currency,
                                                fontWeight: FontWeight.w600,
                                                color: UColor.WhiteColor,
                                              ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        padding: const EdgeInsets.all(18),
                                        child: UText(
                                          HelperMethods.accountNoToIBAN(
                                              accList[index].Branch,
                                              accList[index].AccountNo,
                                              true),
                                          fontWeight: FontWeight.w600,
                                          color: UColor.WhiteColor,
                                        )),
                                    Container(
                                      alignment: Alignment.topRight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 18),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          UText(
                                            "${Localizer.Get(Localizer.balance)}:",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: UColor.WhiteColor,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              UText(
                                                HelperMethods.FormatBalance(accList[index].Balance),
                                                fontWeight: FontWeight.w600,
                                                color: UColor.WhiteColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const UCircularProgressIndicator();
                      } else {
                        return const UCircularProgressIndicator();
                      }
                    },
                  )),
            ),
            Gap(USize.Height / 33),
            ULabel(
              label: Localizer.Get(Localizer.my_cards),
              labelPadding: 35,
              child: SizedBox(
                width: USize.Width,
                height: USize.Height / 4.7,
                child: PageView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: UColor.GoldPlusGradient),
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
                                      "1238 7182 1892 1827",
                                      fontWeight: FontWeight.w700,
                                      color: UColor.WhiteColor,
                                      fontSize: 22,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        UText("SKT: 11/30",
                                            fontWeight: FontWeight.w600,
                                            color: UColor.WhiteColor),
                                        UText("CVV: 721",
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
                                "Pure Gold",
                                fontWeight: FontWeight.w600,
                                color: UColor.WhiteColor,
                                fontSize: 22,
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
                                    "Kullanılabilir Limit:",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
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
                                        "32,471.14",
                                        fontWeight: FontWeight.w600,
                                        color: UColor.WhiteColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
