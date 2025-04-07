import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/presentation/bloc/job_bloc.dart';
import '../widgets/job_card.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Jobs',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade50, Colors.white],
          ),
        ),
        child: BlocBuilder<JobCubit, JobState>(
          builder: (context, state) {
            final savedJobs = state is JobLoaded ? state.savedJobs : [];
            if (savedJobs.isEmpty) {
              return Center(
                child: Text(
                  'No saved jobs yet',
                  style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey.shade600),
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