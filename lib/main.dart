import 'package:device_preview/device_preview.dart';
import 'package:emebet/core/router/router.dart';
import 'package:emebet/core/utils/bloc_providers.dart';
import 'package:emebet/features/int/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/styles/app_theme.dart';
import 'core/utils/injections.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  // );
  await initInjections();
  runApp(
    DevicePreview(
      builder: (context) {
        return const MyApp();
      },
      enabled: false,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: providers(),
            child: MaterialApp(
              key: navigatorKey,
              title: 'emebet',
              scaffoldMessengerKey: snackBarKey,
              onGenerateRoute: AppRouter.generateRoute,
              theme: appTheme,
              debugShowCheckedModeBanner: false,
              builder: DevicePreview.appBuilder,
              home: const SplashScreen(),
            ),
          );
        });
  }
}
