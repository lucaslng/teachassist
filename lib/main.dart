import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// import 'dart:io' show Platform;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/utils/authprovider.dart';
// import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:teachassist/utils/debug.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'route/router.dart';


void main() async {
  // if (Platform.isAndroid) {await FlutterDisplayMode.setHighRefreshRate();}
  // debug(await FlutterDisplayMode.active);s
  runApp(Phoenix(child: App()));
}

class App extends StatelessWidget {
  App({super.key});

  final ColorScheme colorScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xff89b4fa), brightness: Brightness.dark)
      .copyWith(
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

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    final authProvider = AuthProvider();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => authProvider,)
      ],
      child: MaterialApp.router(
        title: 'Teachassist',
        routerConfig: _appRouter.config(
          reevaluateListenable: authProvider,
        ),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          fontFamily: GoogleFonts.overpass().fontFamily,
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(elevation: WidgetStatePropertyAll(3))),
        ),
      ),
    );
  }
}