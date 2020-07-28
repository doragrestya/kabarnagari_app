import 'package:flutter/material.dart';
import 'package:flutter_news_app/ui_page/DashboardPage.dart';
import 'package:flutter_news_app/ui_page/RegisterLogin/LoginPage.dart';
import 'package:flutter_news_app/ui_page/SplashScreenPage.dart';
import 'package:flutter_news_app/ui_page/home/PageHome.dart';
import 'ui_page/RegisterLogin/RegisterPage.dart';

void main() => runApp(MaterialApp(
    home: SplashScreenPage(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.pink,
    //Color(0xFF512DA8),
    accentColor: Color(0xFFEDE7F6),
    scaffoldBackgroundColor: Color(0xFFF3F5F7),
  ),
));



