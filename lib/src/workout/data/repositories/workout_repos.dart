import 'package:hive/hive.dart';
import 'package:magic_fit_app/src/workout/data/models/workout_data_model.dart';
import 'package:magic_fit_app/src/workout/data/models/workout_model.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';
import '../../domain/repos/workout_repo.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final Box<WorkoutModel> workoutBox;

  WorkoutRepositoryImpl(this.workoutBox);

  @override
  Future<void> addWorkout(WorkoutEntity workout) async {
    final workoutModel = WorkoutMapper.toModel(workout);
    await workoutBox.add(workoutModel);
  }

  @override
  List<WorkoutEntity> getWorkouts() {
    return workoutBox.values
        .map((workoutModel) => WorkoutMapper.toEntity(workoutModel))
        .toList();
  }

  @override
  Future<void> deleteWorkout(int index) async {
    await workoutBox.deleteAt(index);
  }

  @override
  Future<void> updateWorkout(int index, WorkoutEntity workout) async {
    final workoutModel = WorkoutMapper.toModel(workout);
    await workoutBox.putAt(index, workoutModel);
  }
}
