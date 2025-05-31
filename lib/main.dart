import 'package:flutter/material.dart';
import 'package:grozaar_delivery/view/grozaar.dart';

import 'core/singleton/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(debugShowCheckedModeBanner: true, home: Grozaar());
      },
    );
  }
}

