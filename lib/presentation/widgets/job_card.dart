import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/presentation/bloc/job_bloc.dart';
import '../../domain/entities/job.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Colors.grey.shade800, Colors.grey.shade900]
                : [Colors.white, Colors.grey.shade100],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(job.avatar),
            backgroundColor: isDarkMode
                ? Colors.grey.shade700
                : Colors.grey.shade200,
          ),
          title: Text(
            job.title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.teal.shade200 : Colors.blue.shade900,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                job.company,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium!.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                job.email,
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              context.read<JobCubit>().savedJobs.contains(job)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: theme.primaryColor,
            ),
            onPressed: () => context.read<JobCubit>().toggleSavedJob(job),
          ),
          onTap: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: Text(
                job.title,
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Company: ${job.company}',
                      style: GoogleFonts.roboto(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Email: ${job.email}',
                      style: GoogleFonts.roboto(fontSize: 14)),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Close',
                    style:
                        GoogleFonts.poppins(color: theme.textTheme.bodyMedium!.color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}