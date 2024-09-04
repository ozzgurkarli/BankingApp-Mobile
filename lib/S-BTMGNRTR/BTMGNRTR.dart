// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/S-HOMESCRN/HOMESCRN.dart';
import 'package:parbank/S-LGNIDNTY/LGNIDNTY.dart';
import 'package:parbank/dto/DTOCustomer.dart';
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
        const LGNIDNTY()
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
            selectedIcon: const Icon(Icons.home),
            icon: const Icon(Icons.home_outlined),
            label: Localizer.Get(Localizer.home),
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.menu),
            icon: const Badge(child: Icon(Icons.menu_outlined)),
            label: Localizer.Get(Localizer.all_transactions),
          ),
        ],
      ),
    );
  }
}
