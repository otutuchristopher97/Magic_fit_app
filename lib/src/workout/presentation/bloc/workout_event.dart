import 'package:equatable/equatable.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object?> get props => [];
}

class LoadWorkouts extends WorkoutEvent {}

class AddWorkout extends WorkoutEvent {
  final WorkoutEntity workout;

  const AddWorkout(this.workout);

  @override
  List<Object?> get props => [workout];
}

class DeleteWorkout extends WorkoutEvent {
  final int index;

  const DeleteWorkout(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateWorkout extends WorkoutEvent {
  final int index;
  final WorkoutEntity workout;

  const UpdateWorkout(this.index, this.workout);

  @override
  List<Object?> get props => [index, workout];
}
