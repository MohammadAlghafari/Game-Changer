import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_changer/modules/settings/business_logic/settings_provider.dart';
import 'package:game_changer/routes/router.dart';
import 'package:game_changer/routes/routes_provider.dart';
import 'package:provider/provider.dart';

import 'constants/themes/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/singletons/singletons.dart';
import 'modules/add_game_screen/business_logic/add_game_screen_provider.dart';
import 'modules/games_screen/business_logic/games_screen_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSingletonInstances();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => getIt<GamesScreenProvider>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<AddGameScreenProvider>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<SettingsProvider>()),
            ],
            child: Consumer<SettingsProvider>(builder: (context, settings, _) {
              return MaterialApp(
                title: 'Game Changer',
                navigatorKey: RoutingProvider.navigatorKey,
                locale: settings.setting.mobileLanguage,
                theme: AppThemes.appTheme,
                onGenerateRoute: (settings) => generateRoute(settings),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('ar', ''),
                ],
              );
            }),
          );
        });
  }
}
