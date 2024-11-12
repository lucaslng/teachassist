import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/course.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// import 'dart:io';
import 'package:teachassist/loginpage.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xff89b4fa), brightness: Brightness.dark).copyWith(
    error: const Color(0xfff38ba8),
    primary: const Color(0xff89b4fa),
    // onPrimary: const Color(0xff1e1e2e),
    // surface: const Color(0xff181825),
    // surfaceContainerLow: const Color(0xff1e1e2e),
    // surfaceContainer: const Color(0xff313244),
    // surfaceContainerHigh: const Color(0xff45475a),
    // surfaceContainerHighest: const Color(0xff585b70),
    // onSurface: const Color(0xffcdd6f4),
    // onSurfaceVariant: const Color(0xff6c7086),
  );


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Teachassist',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          fontFamily: GoogleFonts.overpass().fontFamily,
          elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(elevation: WidgetStatePropertyAll(3))),
        ),
        home: const LoginPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<Course>? data;
}
