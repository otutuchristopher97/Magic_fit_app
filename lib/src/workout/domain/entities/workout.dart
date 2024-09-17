import 'package:equatable/equatable.dart';

class SetEntity extends Equatable {
  final String exercise;
  final double weight;
  final int repetitions;

  const SetEntity({
    required this.exercise,
    required this.weight,
    required this.repetitions,
  });

  @override
  List<Object?> get props => [exercise, weight, repetitions];
}

class WorkoutEntity extends Equatable {
  final List<SetEntity> sets;

  const WorkoutEntity({
    required this.sets,
  });

  @override
  List<Object?> get props => [sets];
}
