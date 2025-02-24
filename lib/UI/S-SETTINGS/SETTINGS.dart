import 'package:flutter/material.dart';
import 'package:parbank/components/UButton.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/ULabel.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/components/UTextField.dart';
import 'package:parbank/helpers/UColor.dart';

class SETTINGS extends StatefulWidget {
  const SETTINGS({super.key});

  @override
  State<SETTINGS> createState() => _SETTINGSState();
}

class _SETTINGSState extends State<SETTINGS> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ULabel(
              label: 'Name',
              child: UTextField(
                controller: nameController,
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: 16),
            ULabel(
              label: 'Email',
              child: UTextField(
                controller: emailController,
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16),
            UButton(
              onPressed: () {
                // Save settings logic
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
