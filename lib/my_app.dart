import 'package:flutter/material.dart';

import 'core/utils/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // dark
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        secondaryHeaderColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: Scaffold(
          body: Center(
        child: ElevatedButton(
          onPressed: () async {

          },
          child: Text(
            'fetch',
          ),
        ),
      )),
    );
  }
}
