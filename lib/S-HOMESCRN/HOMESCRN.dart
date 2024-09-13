// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:parbank/S-MNYTRNSFR/MNYTRNSFR.dart';
import 'package:parbank/S-TRACTHST/TRACTHST.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UCircularProgressIndicator.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/dto/DTOAccount.dart';
import 'package:parbank/dto/DTOCreditCard.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UAsset.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class HOMESCRN extends StatefulWidget {
  DTOCustomer customer;
  HOMESCRN({super.key, required this.customer});

  @override
  State<HOMESCRN> createState() => _HOMESCRNState();
}

class _HOMESCRNState extends State<HOMESCRN> {
  List? accountList;
  bool isAccountsAvailable = false;

  @override
  Widget build(BuildContext context) {
    return UScaffold(
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: UIconButton(
            icon: UIcon(
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

                        isAccountsAvailable = true;
                        accountList = accList;
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
                                                HelperMethods.FormatBalance(
                                                    accList[index].Balance),
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
                        return HelperMethods.ApiException(context, "exception");
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
                  child: FutureBuilder(
                    future: UProxy.Get(
                        IService.GET_CREDIT_CARDS,
                        MessageContainer.builder({
                          "DTOCreditCard": DTOCreditCard(
                              CustomerNo: widget.customer.CustomerNo),
                        })),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List cardList = snapshot.data!.GetWithKey("CCList");

                        if (cardList.isNotEmpty && cardList.first is Map) {
                          for (var i = 0; i < cardList.length; i++) {
                            cardList[i] = DTOCreditCard.fromJson(cardList[i]);
                          }
                        }

                        if (cardList.isEmpty) {
                          return Center(
                            child: GestureDetector(
                              onTap: (){HelperMethods.SetSnackBar(context, Localizer.Get(Localizer.no_credit_card));},
                              child: HelperMethods.ShowAsset(
                                UAsset.NOT_FOUND,
                                height: USize.Height / 8,
                                width: USize.Height / 8,
                              ),
                            ),
                          );
                        }

                        return PageView.builder(
                          itemCount: cardList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: UColor.CardGradients[
                                            cardList[index].Type],
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
                                                  cardList[index].CardNo),
                                              fontWeight: FontWeight.w700,
                                              color: UColor.WhiteColor,
                                              fontSize: 20,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                UText(
                                                    "SKT: ${HelperMethods.toExpirationDate(cardList[index].ExpirationDate)}",
                                                    fontWeight: FontWeight.w600,
                                                    color: UColor.WhiteColor),
                                                UText(
                                                    "CVV: ${cardList[index].CVV}",
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
                                        cardList[index].TypeName,
                                        fontWeight: FontWeight.w600,
                                        color: UColor.WhiteColor,
                                        fontSize: 20,
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
                                                HelperMethods.FormatBalance(
                                                    cardList[index]
                                                        .OutstandingBalance),
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
                        return Center(
                          child: HelperMethods.ShowAsset(
                            UAsset.NETWORK_ERROR,
                            height: USize.Height / 8,
                            width: USize.Height / 8,
                          ),
                        );
                      }
                    },
                  )),
            ),
            Gap(USize.Height / 17),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USize.Width / 5),
              child: UButton(
                  onPressed: () {
                    if(!isAccountsAvailable){
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MNYTRNSFR(
                                  accountList: accountList,
                                  customer: widget.customer,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UIcon(
                        HugeIcons.strokeRoundedMoney02,
                        color: UColor.WhiteColor,
                      ),
                      Gap(USize.Width / 50),
                      UText(
                        Localizer.Get(Localizer.money_transfer),
                        color: UColor.WhiteColor,
                      ),
                    ],
                  )),
            ),
            Gap(USize.Height / 67),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: USize.Width / 5),
              child: UButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TRACTHST(Transactions: List.empty())));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UIcon(
                        Icons.history,
                        color: UColor.WhiteColor,
                      ),
                      Gap(USize.Width / 50),
                      UText(
                        Localizer.Get(Localizer.last_transactions),
                        color: UColor.WhiteColor,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
