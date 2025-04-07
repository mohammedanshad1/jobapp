import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/data/repositories/job_repository.dart';
import 'package:jobapp/data/services/api_service.dart';
import 'package:jobapp/presentation/bloc/job_bloc.dart';
import 'package:jobapp/presentation/screen/job_list_screen.dart';
import 'package:jobapp/presentation/screen/saved_job_screen.dart';
import 'package:jobapp/presentation/screen/splas_screen.dart';
import 'package:jobapp/presentation/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<ThemeMode> _themeModeNotifier =
      ValueNotifier(ThemeMode.light);

  void toggleTheme() {
    _themeModeNotifier.value = _themeModeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  @override
  void dispose() {
    _themeModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeModeNotifier,
      builder: (context, themeMode, child) {
        return BlocProvider(
          create: (context) => JobCubit(JobRepository(ApiService())),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Job App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: '/splash',
            routes: {
              '/splash': (context) => SplashScreen(onThemeToggle: toggleTheme),
              '/saved': (context) => const SavedJobsScreen(),
            },
          ),
        );
      },
    );
  }
}