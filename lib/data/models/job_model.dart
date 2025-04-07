// lib/data/models/job_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
class JobModel with _$JobModel {
  const factory JobModel({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
}

@freezed
class JobResponse with _$JobResponse {
  const factory JobResponse({
    required int page,
    @JsonKey(name: 'per_page') required int perPage,
    required int total,
    @JsonKey(name: 'total_pages') required int totalPages,
    required List<JobModel> data,
  }) = _JobResponse;

  factory JobResponse.fromJson(Map<String, dynamic> json) => _$JobResponseFromJson(json);
}