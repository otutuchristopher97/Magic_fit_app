import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';

import 'workout_model.dart';

class WorkoutMapper {
  static WorkoutModel toModel(WorkoutEntity entity) {
    return WorkoutModel(
      sets: entity.sets.map((set) => SetModel(
        exercise: set.exercise,
        weight: set.weight,
        repetitions: set.repetitions,
      )).toList(),
    );
  }

  static WorkoutEntity toEntity(WorkoutModel model) {
    return WorkoutEntity(
      sets: model.sets.map((set) => SetEntity(
        exercise: set.exercise,
        weight: set.weight,
        repetitions: set.repetitions,
      )).toList(),
    );
  }
}
