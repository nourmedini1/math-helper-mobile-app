import 'package:equatable/equatable.dart';

class PolarFormResponse extends Equatable {
  final String algebraicForm;
  final String polarForm;

  const PolarFormResponse({
    required this.algebraicForm,
    required this.polarForm,
  });

  factory PolarFormResponse.fromJson(Map<String, dynamic> json) {
    return PolarFormResponse(
      algebraicForm: json['algebraicForm'],
      polarForm: json['polarForm'],
    );
  }

  @override
  List<Object> get props => [algebraicForm, polarForm];
}
