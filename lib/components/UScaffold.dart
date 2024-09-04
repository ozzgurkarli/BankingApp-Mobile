// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/S-LGNIDNTY/LGNIDNTY.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/UAsset.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class UScaffold extends StatefulWidget {
  Widget? body;
  List<Widget>? actions;
  Widget? leading;
  Widget? title;
  FloatingActionButton? floatingActionButton;

  UScaffold(
      {super.key,
      this.body,
      this.actions,
      this.leading,
      this.floatingActionButton,
      this.title});

  @override
  State<UScaffold> createState() => _UScaffoldState();
}

class _UScaffoldState extends State<UScaffold> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColor.WhiteColor,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))),
        leadingWidth: widget.leading == null ? USize.Width / 4.5 : 56,
        toolbarHeight: USize.Height / 13,
        title: widget.leading == null ? widget.title : SizedBox(
          width: USize.Width/4.5,
          height: USize.Height/13,
          child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LGNIDNTY()),
                    (route) => false);
              },
              child: HelperMethods.ShowAsset(UAsset.LOGO_WITH_SIDE_TEXT,
                  width: USize.Width, height: USize.Height),
            ),
        ),
        leading: widget.leading ?? Padding(
          padding: EdgeInsets.only(left: USize.Width / 44),
          child: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LGNIDNTY()),
                  (route) => false);
            },
            child: HelperMethods.ShowAsset(UAsset.LOGO_WITH_SIDE_TEXT,
                width: USize.Width, height: USize.Height),
          ),
        ),
        centerTitle: true,
        actions: widget.actions,
        backgroundColor: UColor.PrimaryColor,
      ),
      body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(child: widget.body)),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
