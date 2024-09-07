import 'package:flutter/material.dart';
import 'package:parbank/S-SPLSHSCR/SPLSHSCR.dart';
import 'package:parbank/helpers/USize.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    USize.Height = MediaQuery.of(context).size.height - kToolbarHeight;
    USize.Width = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(  )
          }
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SPLSHSCR(),
    );
  }
}
