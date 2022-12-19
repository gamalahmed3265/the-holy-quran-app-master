import 'package:al_quran/presention/cubits/bookmarks/cubit.dart';
import 'package:al_quran/presention/resource/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../presention/cubits/chapter/cubit.dart';
import '../presention/cubits/juz/cubit.dart';
import '../presention/providers/app_provider.dart';
import '../presention/providers/onboarding_provider.dart';
import '../presention/resource/theme_manager.dart';
import '../presention/screens/home/home_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => JuzCubit()),
        BlocProvider(create: (_) => ChapterCubit()),
        BlocProvider(create: (_) => BookmarkCubit()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: ((context, value, child) {
          return MaterialChild(
            value: value,
          );
        }),
      ),
    );
  }
}

class MaterialChild extends StatelessWidget {
  final AppProvider? value;
  const MaterialChild({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'They Holy Qur\'an',
        debugShowCheckedModeBanner: false,
        theme: themeLight,
        darkTheme: themeDark,
        themeMode: value!.themeMode,
        initialRoute: RouterManager.splash,
        onGenerateRoute: RouterGenator.getRoute,
        routes: <String, WidgetBuilder>{
          '/home': (context) =>
              HomeScreen(maxSlide: MediaQuery.of(context).size.width * 0.835)
        });
  }
}
