import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qr_reader/core/services/locator.dart';
import 'package:qr_reader/core/utils/colors.dart';
import 'package:qr_reader/core/utils/strings.dart';
import 'package:qr_reader/features/history/domain/history_item_entity.dart';
import 'package:qr_reader/features/home/presentation/views/bottom_nav_bar.dart';

import 'core/utils/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter<HistoryItemEntity>(HistoryItemEntityAdapter());
  await Future.wait([
    Hive.openBox<HistoryItemEntity>(AppStrings.scannedHistoryBoxName),
    Hive.openBox<HistoryItemEntity>(AppStrings.generatedHistoryBoxName),
  ]);

  runApp(const QrReader());
}

class QrReader extends StatelessWidget {
  const QrReader({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        useMaterial3: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: AppColors.blackGreyish,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.blackGreyish,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          border: InputBorder.none,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: AppColors.primary.withOpacity(0.25),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.primary,
          size: 45,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const BottomNavBar(),
    );
  }
}
