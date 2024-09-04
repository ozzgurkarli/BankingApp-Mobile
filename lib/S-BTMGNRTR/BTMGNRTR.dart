// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:parbank/S-ALLTRNSC/ALLTRNSC.dart';
import 'package:parbank/S-HOMESCRN/HOMESCRN.dart';
import 'package:parbank/S-OPENACCT/OPENACCT.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/dto/DTOCustomer.dart';
import 'package:parbank/dto/DTOParameter.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/Localizer.dart';
import 'package:parbank/helpers/UColor.dart';

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

                List cityList = await UProxy.Get(
                        IService.GET_PARAMETERS_BY_GROUP_CODE,
                        MessageContainer.builder(
                            {"Parameter": DTOParameter(GroupCode: "City")}))
                    .then((value) {
                  return value.GetWithKey("ParameterList");
                });
                List districtList = await UProxy.Get(
                        IService.GET_PARAMETERS_BY_GROUP_CODE,
                        MessageContainer.builder(
                            {"Parameter": DTOParameter(GroupCode: "District")}))
                    .then((value) {
                  return value.GetWithKey("ParameterList");
                });

                List currencyList = await UProxy.Get(
                        IService.GET_PARAMETERS_BY_GROUP_CODE,
                        MessageContainer.builder(
                            {"Parameter": DTOParameter(GroupCode: "Currency")}))
                    .then((value) {
                  return value.GetWithKey("ParameterList");
                });

                for (var i = 0; i < cityList.length; i++) {
                  cityList[i] = DTOParameter.fromJson(cityList[i]);
                }
                for (var i = 0; i < districtList.length; i++) {
                  districtList[i] = DTOParameter.fromJson(districtList[i]);
                }
                for (var i = 0; i < currencyList.length; i++) {
                  currencyList[i] = DTOParameter.fromJson(currencyList[i]);
                }
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OPENACCT(
                        dtoCustomer: widget.customer,
                        cityList: cityList,
                        districtList: districtList,
                        currencyList: currencyList
                      ),
                    ));
              }
            ],
            [Localizer.Get(Localizer.card_application), () {}],
            [Localizer.Get(Localizer.market_information), () {}],
            [Localizer.Get(Localizer.qr_code_operations), () {}],
            [Localizer.Get(Localizer.credit_calculation), () {}],
            [Localizer.Get(Localizer.settings), () {}],
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
