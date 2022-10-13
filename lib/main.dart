import 'package:flutter/material.dart';
import 'package:flutterhw13/pages/account_page.dart';
import 'package:flutterhw13/pages/login_page.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';
import 'package:flutterhw13/pages/report_page.dart';
import 'package:flutterhw13/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}