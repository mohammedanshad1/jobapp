import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/presentation/bloc/job_bloc.dart';
import '../widgets/job_card.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Jobs')),
      body: BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          final savedJobs = state is JobLoaded ? state.savedJobs : [];
          if (savedJobs.isEmpty) {
            return const Center(child: Text('No saved jobs yet'));
          }
          return ListView.builder(
            itemCount: savedJobs.length,
            itemBuilder: (context, index) {
              return JobCard(job: savedJobs[index]);
            },
          );
        },
      ),
    );
  }
}