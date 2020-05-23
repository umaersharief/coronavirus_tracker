import 'package:coronavirus_tracker/screens/intro_splash_screen.dart';
import 'package:coronavirus_tracker/screens/internet_test_screen.dart';
import 'package:coronavirus_tracker/screens/dashboard.dart';
import 'package:coronavirus_tracker/screens/loading_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coronavirus_tracker/services/connection_status_singleton.dart';
import 'package:coronavirus_tracker/utils/app_utils.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  RenderErrorBox.backgroundColor = primaryColor;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: primaryColor,
      statusBarColor: primaryColor,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coronavirus Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: primaryColor,
        cardColor: secondaryColor,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: secondaryColor,
          modalBackgroundColor: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
            color: Colors.white60,
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
          bodyText1: TextStyle(
            color: Colors.white38,
            fontSize: 10,
          ),
          bodyText2: TextStyle(
            color: Colors.white38,
            fontSize: 14,
          ),
          subtitle2: TextStyle(
            color: Colors.white38,
            fontSize: 12,
          ),
        ),
        dialogBackgroundColor: secondaryColor,
        appBarTheme: AppBarTheme(
          color: primaryColor,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: appBar_icons_text_color,
              fontSize: 16,
            ),
          ),
          iconTheme: IconThemeData(
            color: appBar_icons_text_color,
            size: 25,
          ),
        ),
      ),
      initialRoute: IntroSplashScreen.routeName,
      routes: {
        IntroSplashScreen.routeName: (context) => IntroSplashScreen(),
        InternetTestScreen.routeName: (context) => InternetTestScreen(),
        Dashboard.routeName: (context) => Dashboard(),
        LoadingScreen.routeName: (context) => LoadingScreen(),
      },
    );
  }
}