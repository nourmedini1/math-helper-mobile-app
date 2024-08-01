import 'package:equatable/equatable.dart';

class Operation extends Equatable {
  final List<String> results;
  final DateTime doneAt;
  final String label;
  final String title;

  const Operation({
    required this.title,
    required this.results,
    required this.doneAt,
    required this.label,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'results': results,
      'doneAt': doneAt.toIso8601String(),
      'label': label,
    };
  }

  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      title: json['title'],
      doneAt: DateTime.parse(json['doneAt']),
      label: json['label'],
      results: List<String>.from(json['results']),
    );
  }

  @override
  List<Object?> get props => [results, doneAt, label, title];
}
