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

  Future<void> _loadSavedJobs() async {
  final savedIds = _prefs.getStringList('saved_job_ids') ?? [];
  final allJobs = (state is JobLoaded) ? (state as JobLoaded).jobs : [];
  savedJobs = List<Job>.from(
    allJobs.where((job) => job.id != null && savedIds.contains(job.id.toString())),
  );
  emit(JobSavedUpdated(List.from(savedJobs)));
}
  Future<void> fetchJobs(int page) async {
  try {
    emit(JobLoading());
    final jobModels = await repository.getJobs(page);
    final jobs = jobModels.map((model) => Job(
      id: model.id,
      title: '${model.firstName} ${model.lastName} Position',
      company: model.email.split('@')[1].split('.')[0],
      email: model.email,
      avatar: model.avatar,
    )).toList();
    emit(JobLoaded(jobs));
    _loadSavedJobs();
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
    emit(JobSavedUpdated(List.from(savedJobs)));
  }
}

abstract class JobState {}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<Job> jobs;
  JobLoaded(this.jobs);
}

class JobError extends JobState {
  final String message;
  JobError(this.message);
}

class JobSavedUpdated extends JobState {
  final List<Job> savedJobs;
  JobSavedUpdated(this.savedJobs);
}