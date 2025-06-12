part of 'graph_cubit.dart';

@immutable
sealed class GraphState {}

final class GraphInitial extends GraphState {
  final GraphData firstGraphData;
  final GraphData secondGraphData;

  GraphInitial({
    required this.firstGraphData,
    required this.secondGraphData,
  });

  factory GraphInitial.initial() => GraphInitial(
        firstGraphData: GraphData.initialiseWithSin(),
        secondGraphData: GraphData.initialiseWithCos(),
      );

  GraphInitial copyWith({
    GraphData? firstGraphData,
    GraphData? secondGraphData,
  }) {
    return GraphInitial(
      firstGraphData: firstGraphData ?? this.firstGraphData,
      secondGraphData: secondGraphData ?? this.secondGraphData,
    );
  }
}