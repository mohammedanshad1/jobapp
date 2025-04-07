import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/presentation/bloc/job_bloc.dart';
import '../widgets/job_card.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Jobs',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor ?? Colors.white,
          ),
        ),
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.primaryColor,
        elevation: 4,
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
        child: BlocBuilder<JobCubit, JobState>(
          builder: (context, state) {
            final savedJobs = state is JobLoaded ? state.savedJobs : [];
            if (savedJobs.isEmpty) {
              return Center(
                child: Text(
                  'No saved jobs yet',
                  style: GoogleFonts.roboto(
                      fontSize: 18, color: theme.textTheme.bodyMedium!.color),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: savedJobs.length,
              itemBuilder: (context, index) {
                return JobCard(job: savedJobs[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
