import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/presentation/bloc/job_bloc.dart';
import '../../domain/entities/job.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(job.avatar)),
        title: Text(job.title, style: Theme.of(context).textTheme.headlineMedium),
        subtitle: Text(job.company, style: Theme.of(context).textTheme.bodyMedium),
        trailing: IconButton(
          icon: Icon(
            context.read<JobCubit>().savedJobs.contains(job) ? Icons.bookmark : Icons.bookmark_border,
          ),
          onPressed: () => context.read<JobCubit>().toggleSavedJob(job),
        ),
        onTap: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(job.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Company: ${job.company}'),
                Text('Email: ${job.email}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}