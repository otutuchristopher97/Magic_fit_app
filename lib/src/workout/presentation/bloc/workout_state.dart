import 'package:equatable/equatable.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object?> get props => [];
}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  final List<WorkoutEntity> workouts;

  const WorkoutLoaded(this.workouts);

  @override
  List<Object?> get props => [workouts];
}

class WorkoutError extends WorkoutState {
  final String message;

  const WorkoutError(this.message);

  @override
  List<Object?> get props => [message];
}
