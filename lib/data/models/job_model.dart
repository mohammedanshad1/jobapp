import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
class JobModel with _$JobModel {
  const factory JobModel({
    required int id,
    required String? email, // Made nullable to match previous fix
    @JsonKey(name: 'first_name') required String? firstName, // Match API key, nullable
    @JsonKey(name: 'last_name') required String? lastName, // Match API key, nullable
    required String? avatar, // Made nullable to match previous fix
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
}

@freezed
class Support with _$Support {
  const factory Support({
    required String url,
    required String text,
  }) = _Support;

  factory Support.fromJson(Map<String, dynamic> json) => _$SupportFromJson(json);
}

@freezed
class JobResponse with _$JobResponse {
  const factory JobResponse({
    required int? page, // Made nullable to match previous fix
    @JsonKey(name: 'per_page') required int? perPage, // Match API key, nullable
    required int? total, // Made nullable to match previous fix
    @JsonKey(name: 'total_pages') required int? totalPages, // Match API key, nullable
    required List<JobModel> data,
    required Support support,
  }) = _JobResponse;

  factory JobResponse.fromJson(Map<String, dynamic> json) => _$JobResponseFromJson(json);
}