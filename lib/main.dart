import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/presentation/bloc/job_bloc.dart';
import 'package:jobapp/presentation/screen/job_list_screen.dart';
import 'package:jobapp/presentation/screen/saved_job_screen.dart';
import 'package:jobapp/presentation/theme/app_theme.dart';
import 'data/repositories/job_repository.dart';
import 'data/services/api_service.dart';


void main() {
  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (context) => JobCubit(JobRepository(ApiService())),
        child: const JobListScreen(),
      ),
    ),
  );
}
class JobListingApp extends StatelessWidget {
  const JobListingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final jobRepository = JobRepository(ApiService());

    return BlocProvider(
      create: (_) => JobCubit(jobRepository),
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // Switches between light/dark based on system
        initialRoute: '/',
        routes: {
          '/': (_) => const JobListScreen(),
          '/saved': (_) => const SavedJobsScreen(),
        },
      ),
    );
  }
}