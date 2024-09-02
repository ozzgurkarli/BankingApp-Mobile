// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/dto/DTOCustomer.dart';

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
      
    );
  }
}