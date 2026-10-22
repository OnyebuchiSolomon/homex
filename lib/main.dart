import 'package:flutter/material.dart';
import 'package:homex/features/splash/presentation/screens/splash_screen.dart';

import 'core/configs/size_config.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/navigator/page_navigator.dart';
import 'core/theme/app_theme.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const HomeXApp());
}

class HomeXApp extends StatelessWidget {
  const HomeXApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'HomeX',

      navigatorKey: AppNavigator.navigatorKey,

      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRoutes.generateRoute,
      darkTheme: AppTheme.darkTheme,
      builder: (context, child) {
        return child!;
      },
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splashScreen,
     // home: const _AppInitializer(),
    );
  }
}

class _AppInitializer extends StatelessWidget {
  const _AppInitializer();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return const SplashScreen();
  }
}