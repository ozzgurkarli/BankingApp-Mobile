// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:parbank/S-ALLTRNSC/ALLTRNSC.dart';
import 'package:parbank/S-CRDAPPLC/CRDAPPLC.dart';
import 'package:parbank/S-HOMESCRN/HOMESCRN.dart';
import 'package:parbank/S-LGNIDNTY/LGNIDNTY.dart';
import 'package:parbank/S-MNYTRNSFR/MNYTRNSFR.dart';
import 'package:parbank/S-OPENACCT/OPENACCT.dart';
import 'package:parbank/S-TRACTHST/TRACTHST.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/dto/DTOAccount.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/DTOParameter.dart';
import 'package:parbank/dto/DTOTransactionHistory.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UAsset.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class BTMGNRTR extends StatefulWidget {
  DTOCustomer customer;
  BTMGNRTR({super.key, required this.customer});

  @override
  State<BTMGNRTR> createState() => _BTMGNRTRState();
}

class _BTMGNRTRState extends State<BTMGNRTR> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        HOMESCRN(customer: widget.customer),
        ALLTRNSC(
          customer: widget.customer,
          Transactions: [
            [
              Localizer.Get(Localizer.open_an_account),
              () async {
                HelperMethods.SetLoadingScreen(context);

                List parList = [
                  DTOParameter(GroupCode: "City"),
                  DTOParameter(GroupCode: "District"),
                  DTOParameter(GroupCode: "Currency")
                ];
                List cityList;
                List districtList;
                List currencyList;

                try {
                  parList = await UProxy.Get(IService.GET_MULTIPLE_GROUP_CODE,
                          MessageContainer.builder({"ParameterList": parList}))
                      .then((value) {
                    return value.GetWithKey("ParameterList");
                  });
                } catch (e) {
                  Navigator.pop(context);
                  HelperMethods.ApiException(context, e.toString());
                  return;
                }
                for (var i = 0; i < parList.length; i++) {
                  parList[i] = DTOParameter.fromJson(parList[i]);
                }

                cityList = parList.where((x) => x.GroupCode == "City").toList();
                districtList =
                    parList.where((x) => x.GroupCode == "District").toList();
                currencyList =
                    parList.where((x) => x.GroupCode == "Currency").toList();

                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OPENACCT(
                          dtoCustomer: widget.customer,
                          cityList: cityList,
                          districtList: districtList,
                          currencyList: currencyList),
                    ));
              }
            ],
            [
              Localizer.Get(Localizer.card_application),
              () async {
                HelperMethods.SetLoadingScreen(context);
                List cardTypeList;

                try {
                  cardTypeList = await UProxy.Get(
                      IService.GET_PARAMETERS_BY_GROUP_CODE,
                      MessageContainer.builder({
                        "Parameter": DTOParameter(GroupCode: "CardType")
                      })).then((value) {
                    return value.GetWithKey("ParameterList");
                  });
                } catch (e) {
                  Navigator.pop(context);
                  HelperMethods.ApiException(context, e.toString());
                  return;
                }
                for (var i = 0; i < cardTypeList.length; i++) {
                  cardTypeList[i] = DTOParameter.fromJson(cardTypeList[i]);
                }
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CRDAPPLC(
                        dtoCustomer: widget.customer,
                        cardTypeList: cardTypeList,
                      ),
                    ));
              }
            ],
            [
              Localizer.Get(Localizer.money_transfer),
              () async {
                HelperMethods.SetLoadingScreen(context);
                List accountList;

                try {
                  accountList = await UProxy.Get(
                      IService.GET_ACCOUNTS,
                      MessageContainer.builder({
                        "DTOAccount":
                            DTOAccount(CustomerNo: widget.customer.CustomerNo),
                      })).then((value) {
                    return value.GetWithKey("AccountList");
                  });
                } catch (e) {
                  Navigator.pop(context);
                  HelperMethods.ApiException(context, e.toString());
                  return;
                }

                if (accountList.isNotEmpty && accountList.first is Map) {
                  for (var i = 0; i < accountList.length; i++) {
                    accountList[i] = DTOAccount.fromJson(accountList[i]);
                  }
                }

                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MNYTRNSFR(
                              accountList: accountList,
                              customer: widget.customer,
                            )));
              }
            ],
            [Localizer.Get(Localizer.last_transactions), () async{
              HelperMethods.SetLoadingScreen(context);
                    List transactionList;

                    try {
                      transactionList = await UProxy.Get(
                          IService.GET_TRANSACTION_HISTORY,
                          MessageContainer.builder({
                            "DTOTransactionHistory": DTOTransactionHistory(
                                CustomerNo: widget.customer.CustomerNo,
                                Count: 10,
                                MinDate: DateTime.now()
                                    .add(const Duration(days: -7)))
                          })).then((value) {
                        return value.GetWithKey("TransactionList");
                      });
                    } catch (e) {
                      Navigator.pop(context);
                      HelperMethods.ApiException(context, e.toString(),
                          popUntil: 1);
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
                                TRACTHST(Transactions: transactionList, customer: widget.customer,)));
            }],
            [Localizer.Get(Localizer.market_information), () {}],
            [Localizer.Get(Localizer.qr_code_operations), () {}],
            [Localizer.Get(Localizer.credit_calculation), () {}],
            [Localizer.Get(Localizer.settings), () {}],
            [
              Localizer.Get(Localizer.log_out),
              () {
                HelperMethods.SetBottomSheet(
                    context,
                    Localizer.Get(Localizer.customer_will_logged_out),
                    UAsset.LOGOUT,
                    Localizer.Get(Localizer.approve),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: UText(
                              Localizer.Get(Localizer.nevermind),
                              color: UColor.WhiteColor,
                            )),
                        Gap(USize.Width / 33),
                        UButton(
                          onPressed: () async {
                            await HelperMethods.DeleteData();
                            setState(() {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LGNIDNTY()),
                                  (route) => false);
                            });
                          },
                          redButton: true,
                          child: UText(
                            Localizer.Get(Localizer.log_out),
                            color: UColor.WhiteColor,
                          ),
                        ),
                      ],
                    ));
              }
            ],
          ],
        ),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: UColor.PrimaryLightColor,
        selectedIndex: currentPageIndex,
        backgroundColor: UColor.WhiteColor,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(
              Icons.home,
            ),
            icon: const Icon(Icons.home_outlined),
            label: Localizer.Get(Localizer.home),
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.menu),
            icon: const Icon(Icons.menu_outlined),
            label: Localizer.Get(Localizer.all_transactions),
          ),
        ],
      ),
    );
  }
}
