import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zombie_conga_flame/l10n/l10n.dart';
import 'package:zombie_conga_flame/loading/loading.dart';

late String deviceSize; // = 'medium';
late double width;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PreloadCubit(
            Images(prefix: ''),
            AudioCache(prefix: ''),
          )..loadSequentially(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine size of screen

    // Get width of device.  Use longestSide for landscape apps, shortestSide for portrait.
    width = MediaQuery.of(context).size.longestSide;

    // Set deviceSize based on width.  This is used for font scaling.
    deviceSize = width >= 1024
        ? 'extra large'
        : width >= 700
            ? 'large'
            : width > 380
                ? 'medium'
                : 'small';

    //print('deviceSize: $deviceSize, width: $width');

    // final scaleMultiplier = deviceSize == 'extra large'
    //     ? 1.5
    //     : deviceSize == 'large'
    //         ? 1.0
    //         : deviceSize == 'small'
    //             ? -0.10
    //             : 0.0;
    //
    // final value = 20.0 * scaleMultiplier;
    // print('scaleMultiplier: $scaleMultiplier  value: $value');
    //
    // final textSize = 20.0 + (20.0 * scaleMultiplier);
    // print('textSize: $textSize');
    //
    // final isTablet = MediaQuery.of(context).size.shortestSide >= 700;
    // print('isTablet: $isTablet');
    //
    // final isSmallPhone = MediaQuery.of(context).size.shortestSide <= 380;
    // print('isSmallPhone: $isSmallPhone');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2A48DF),
        appBarTheme: const AppBarTheme(color: Color(0xFF2A48DF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF2A48DF),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              const Color(0xFF2A48DF),
            ),
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoadingPage(),
    );
  }
}
