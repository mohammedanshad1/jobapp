import 'package:dio/dio.dart';
import 'package:jobapp/data/models/job_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api/'));

  Future<JobResponse> fetchJobs(int page) async {
    try {
      final response = await _dio.get('users?page=$page');
      print('Raw response: ${response.data}');
      final jobResponse = JobResponse.fromJson(response.data);
      print('Parsed jobs: ${jobResponse.data.map((job) => job.firstName).toList()}');
      return jobResponse;
    } catch (e) {
      print('Error fetching jobs: $e');
      throw Exception('Failed to load jobs');
    }
  }
}
