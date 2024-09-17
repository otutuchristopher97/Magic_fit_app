import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';

abstract class WorkoutRepository {
  Future<void> addWorkout(WorkoutEntity workout);
  List<WorkoutEntity> getWorkouts();
  Future<void> deleteWorkout(int index);
  Future<void> updateWorkout(int index, WorkoutEntity workout);
}
