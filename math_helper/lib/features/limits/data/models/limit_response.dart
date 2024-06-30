import 'package:equatable/equatable.dart';

class LimitResponse extends Equatable {
  final String limit;
  final String result;

  const LimitResponse({required this.limit, required this.result});

  factory LimitResponse.fromJson(Map<String, dynamic> json) {
    return LimitResponse(
      limit: json['limit'],
      result: json['result'],
    );
  }

  @override
  List<Object?> get props => [limit, result];
}
