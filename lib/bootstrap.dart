import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';
import 'package:zombie_conga_flame/gen/assets.gen.dart';

// class AppBlocObserver extends BlocObserver {
//   @override
//   void onChange(
//     BlocBase<dynamic> bloc,
//     Change<dynamic> change,
//   ) {
//     super.onChange(bloc, change);
//     log(
//       'onChange(${bloc.runtimeType}, $change)',
//     );
//   }
//
//   @override
//   void onError(
//     BlocBase<dynamic> bloc,
//     Object error,
//     StackTrace stackTrace,
//   ) {
//     log(
//       'onError(${bloc.runtimeType}, $error, $stackTrace)',
//     );
//     super.onError(bloc, error, stackTrace);
//   }
// }

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Check to see if device is Desktop and if so then set window sizes and title
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    await windowManager.setMinimumSize(const Size(1024, 768));
    await windowManager.setMaximumSize(const Size(2048, 1536));
    await windowManager.setSize(const Size(1024, 768));
    await windowManager.setAspectRatio(16.0 / 9.0); // aspect ratio supported, 16:9 (1.77)
    await windowManager.setMaximizable(false);

    await windowManager.setTitle('Zombie Conga'); //Window title
  }

  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  //Bloc.observer = AppBlocObserver();

  // LicenseRegistry.addLicense(() async* {
  //   final poppins = await rootBundle.loadString(
  //     Assets.licenses.poppins.ofl,
  //   );
  //   yield LicenseEntryWithLineBreaks(
  //     ['poppins'],
  //     poppins,
  //   );
  // });

  // Add cross-flavor configuration here

  runApp(
    await builder(),
  );
}
