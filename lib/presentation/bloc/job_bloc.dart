import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/job_repository.dart';
import '../../domain/entities/job.dart';

class JobCubit extends Cubit<JobState> {
  final JobRepository repository;
  List<Job> savedJobs = [];
  late SharedPreferences _prefs;

  JobCubit(this.repository) : super(JobInitial()) {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSavedJobs();
  }

  Future<void> _loadSavedJobs({List<Job>? allJobs}) async {
    final savedIds = _prefs.getStringList('saved_job_ids') ?? [];
    final currentJobs = allJobs ?? (state is JobLoaded ? (state as JobLoaded).jobs : []);
    savedJobs = List<Job>.from(
      currentJobs.where((job) => job.id != null && savedIds.contains(job.id.toString())),
    );
    if (state is JobLoaded) {
      emit(JobLoaded((state as JobLoaded).jobs, savedJobs: savedJobs));
    }
  }

  Future<void> fetchJobs(int page) async {
    try {
      emit(JobLoading());
      print('Emitted JobLoading');
      final jobModels = await repository.getJobs(page);
      final jobs = jobModels.map((model) => Job(
        id: model.id,
        title: '${model.firstName ?? 'Unknown'} ${model.lastName ?? 'User'} Position',
        company: model.email != null ? model.email!.split('@')[1].split('.')[0] : 'Unknown',
        email: model.email ?? 'No email',
        avatar: model.avatar ?? 'https://via.placeholder.com/150',
      )).toList();
      print('Jobs to emit: ${jobs.length} items');
      emit(JobLoaded(jobs, savedJobs: savedJobs));
      print('Emitted JobLoaded with ${jobs.length} jobs');
      await _loadSavedJobs(allJobs: jobs); // Update saved jobs after loading
    } catch (e, stackTrace) {
      print('Error in fetchJobs: $e');
      print('Stack trace: $stackTrace');
      emit(JobError('Failed to load jobs: ${e.toString()}'));
    }
  }

  void toggleSavedJob(Job job) async {
    if (savedJobs.contains(job)) {
      savedJobs.remove(job);
    } else {
      savedJobs.add(job);
    }
    final savedIds = savedJobs.map((job) => job.id.toString()).toList();
    await _prefs.setStringList('saved_job_ids', savedIds);
    if (state is JobLoaded) {
      emit(JobLoaded((state as JobLoaded).jobs, savedJobs: savedJobs));
    }
  }
}

abstract class JobState {}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<Job> jobs;
  final List<Job> savedJobs;

  JobLoaded(this.jobs, {this.savedJobs = const []});
}

class JobError extends JobState {
  final String message;
  JobError(this.message);
}