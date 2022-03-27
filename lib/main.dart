import 'package:flutter/material.dart';
import 'package:login_with_upload_image/screens/login_screen.dart';
import 'package:login_with_upload_image/viewmodel/login_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginProvider()),

      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: LogInScreen(),
    );
  }
}

