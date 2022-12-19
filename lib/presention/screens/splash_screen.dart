import 'package:al_quran/presention/configs/configs.dart';
import 'package:al_quran/presention/cubits/bookmarks/cubit.dart';
import 'package:al_quran/presention/cubits/juz/cubit.dart';
import 'package:al_quran/presention/resource/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:al_quran/presention/configs/app.dart';
import 'package:al_quran/presention/cubits/chapter/cubit.dart';
import 'package:al_quran/presention/providers/app_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../componts/animations/bottom_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _next() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      appProvider.initTheme();
    });

    bool isNew = appProvider.init();

    final bookmarkCubit = BookmarkCubit.cubit(context);
    final chapterCubit = ChapterCubit.cubit(context);
    final juzCubit = JuzCubit.cubit(context);

    await chapterCubit.fetch();

    await bookmarkCubit.fetch();

    for (int i = 1; i <= 30; i++) {
      await juzCubit.fetch(i);
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          isNew ? '/intro' : '/home',
        );
      }
    });
  }

  @override
  void initState() {
    _next();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final bookmarkCubit = BookmarkCubit.cubit(context);
    final juzCubit = JuzCubit.cubit(context);

    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: appProvider.isDark ? Colors.grey[850] : Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetAnimator(
              child: Image.asset(
                appProvider.isDark ? ImageManager.gradLogo : ImageManager.logo,
                height: AppDimensions.normalize(100),
              ),
            ),
            Space.y1!,
            Shimmer.fromColors(
              enabled: true,
              baseColor: appProvider.isDark ? Colors.white : Colors.black,
              highlightColor: appProvider.isDark ? Colors.grey : Colors.white,
              child: BlocBuilder<ChapterCubit, ChapterState>(
                builder: (context, state) {
                  if (state is ChapterFetchLoading) {
                    return const Text('Getting all Surahs...');
                  } else if (bookmarkCubit.state is BookmarkFetchLoading) {
                    return const Text('Setting up Bookmarks...');
                  } else if (juzCubit.state is JuzFetchLoading) {
                    return const Text('Setting up offline mode...');
                  }
                  return const Text('Initializing data...');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
