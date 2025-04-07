import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/presentation/bloc/job_bloc.dart';
import '../widgets/job_card.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JobCubit>().fetchJobs(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Listings',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor ?? Colors.white,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.primaryColor,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: theme.appBarTheme.foregroundColor ?? Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, '/saved'),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Colors.teal.shade800, Colors.grey.shade900]
                : [Colors.blue.shade50, theme.scaffoldBackgroundColor],
          ),
        ),
        child: BlocConsumer<JobCubit, JobState>(
          listener: (context, state) {
            if (state is JobError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message, style: GoogleFonts.roboto()),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is JobLoading) {
              return Center(
                child: CircularProgressIndicator(color: theme.primaryColor),
              );
            } else if (state is JobLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.jobs.length,
                itemBuilder: (context, index) {
                  final job = state.jobs[index];
                  return JobCard(job: job);
                },
              );
            } else if (state is JobError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: theme.textTheme.bodyMedium?.color ?? Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<JobCubit>().fetchJobs(1),
                      style: theme.elevatedButtonTheme.style,
                      child: Text(
                        'Retry',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: theme.elevatedButtonTheme.style?.foregroundColor
                                  ?.resolve({}) ??
                              Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text(
                'Press refresh to load jobs',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: theme.textTheme.bodyMedium?.color ?? Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<JobCubit>().fetchJobs(1),
        backgroundColor: theme.primaryColor,
        child: Icon(
          Icons.refresh,
          color: theme.elevatedButtonTheme.style?.foregroundColor?.resolve({}) ??
              Colors.white,
        ),
        elevation: 6,
      ),
    );
  }
}