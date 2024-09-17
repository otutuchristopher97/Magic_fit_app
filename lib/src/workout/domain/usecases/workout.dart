import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';
import 'package:magic_fit_app/src/workout/domain/repos/workout_repo.dart';

class AddWorkoutUseCase {
  final WorkoutRepository repository;

  AddWorkoutUseCase(this.repository);

  Future<void> call(WorkoutEntity workout) {
    return repository.addWorkout(workout);
  }
}

class GetWorkoutsUseCase {
  final WorkoutRepository repository;

  GetWorkoutsUseCase(this.repository);

  List<WorkoutEntity> call() {
    return repository.getWorkouts();
  }
}

class DeleteWorkoutUseCase {
  final WorkoutRepository repository;

  DeleteWorkoutUseCase(this.repository);

  Future<void> call(int index) {
    return repository.deleteWorkout(index);
  }
}

class UpdateWorkoutUseCase {
  final WorkoutRepository repository;

  UpdateWorkoutUseCase(this.repository);

  Future<void> call(int index, WorkoutEntity workout) {
    return repository.updateWorkout(index, workout);
  }
}
