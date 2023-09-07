import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_native_flutter/constants.dart';
import 'package:the_native_flutter/provider/crop_monitioring_provider.dart';
import 'package:the_native_flutter/provider/login_provider.dart';
import 'package:the_native_flutter/provider/refresh_token_provider.dart';
import 'package:the_native_flutter/provider/report_history_provider.dart';
import 'package:the_native_flutter/provider/successed_report_history_provider.dart';
import 'package:the_native_flutter/provider/user_provider.dart';
import 'package:the_native_flutter/view/pages/chatting/chat_page.dart';
import 'package:the_native_flutter/view/pages/file_pick_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_native_flutter/provider/user_provider.dart';
import 'package:the_native_flutter/view/pages/splash_screen_page.dart';



class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main(){

  HttpOverrides.global = MyHttpOverrides();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => RefreshTokenProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ReportHistoryProvider()),
          ChangeNotifierProvider(create: (_) => SuccessedReportHistoryProvider()),
          ChangeNotifierProvider(create: (_) => CropMonitoringProvider()),

        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: kPrimaryColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),

            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            )),

        // home: UploadScreen(),
        home: SplashScreen(),
        // home:ChatPage(),
        // home: NewsPage(),
        // home: SmsVerificationPage("","",""),
        // home: FilePickPage(),
      ),
    )
  );
}
