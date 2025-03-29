import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/Common/themes/themes.dart';
import 'app/routes/app_pages.dart';

void main() {
  //Build common input decoration theme
  InputDecorationTheme buildInputDecorationTheme(Color color) {
    return InputDecorationTheme(
      hintStyle: TextStyle(color: color),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 1),
      ),
    );
  }

  //Build light theme
  ThemeData buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: buildInputDecorationTheme(Colors.black),
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      extensions: <ThemeExtension<dynamic>>[
        ImageTheme(iconColor: Colors.grey),
      ],
    );
  }

  ThemeData buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      inputDecorationTheme: buildInputDecorationTheme(Colors.white),
      appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      extensions: <ThemeExtension<dynamic>>[
        ImageTheme(iconColor: Colors.white),
      ],
    );
  }

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
    ),
  );
}
