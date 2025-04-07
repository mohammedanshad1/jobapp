import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/data/repositories/job_repository.dart';
import 'package:jobapp/data/services/api_service.dart';
import 'package:jobapp/presentation/bloc/job_bloc.dart';
import 'package:jobapp/presentation/screen/job_list_screen.dart';
import 'package:jobapp/presentation/screen/saved_job_screen.dart';
import 'package:jobapp/presentation/screen/splas_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobCubit(JobRepository(ApiService())),
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Job App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          // '/': (context) => const JobListScreen(),
          '/saved': (context) => const SavedJobsScreen(),
        },
      ),
    );
  }
}