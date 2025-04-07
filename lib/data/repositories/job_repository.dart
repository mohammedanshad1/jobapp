import 'package:jobapp/data/models/job_model.dart';

import '../services/api_service.dart';

class JobRepository {
  final ApiService apiService;

  JobRepository(this.apiService);

  Future<List<JobModel>> getJobs(int page) async {
    final response = await apiService.fetchJobs(page);
    return response.data;
  }
}