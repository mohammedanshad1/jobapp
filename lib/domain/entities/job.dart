import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final int? id; // Already nullable
  final String title;
  final String company;
  final String email;
  final String avatar;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.email,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, title, company, email, avatar];
}