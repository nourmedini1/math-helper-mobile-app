import 'package:equatable/equatable.dart';

class Operation extends Equatable {
  final dynamic operationResult;
  final DateTime doneAt;
  final String label;

  const Operation({
    required this.operationResult,
    required this.doneAt,
    required this.label,
  });

  Map<String, dynamic> toJson() {
    return {
      'operationResult': operationResult.toJson(),
      'doneAt': doneAt.toIso8601String(),
      'label': label,
    };
  }

  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      operationResult: json['operationResult'],
      doneAt: DateTime.parse(json['doneAt']),
      label: json['label'],
    );
  }

  @override
  List<Object?> get props => [operationResult, doneAt, label];
}
