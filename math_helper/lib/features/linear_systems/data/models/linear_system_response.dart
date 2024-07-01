import 'package:equatable/equatable.dart';

class LinearSystemResponse extends Equatable {
  final String linearSystem;
  final String? result;

  const LinearSystemResponse({required this.linearSystem, this.result});

  factory LinearSystemResponse.fromJson(Map<String, dynamic> json) {
    return LinearSystemResponse(
      linearSystem: json['linearSystem'],
      result: json['result'],
    );
  }

  @override
  List<Object?> get props => [linearSystem, result];
}
