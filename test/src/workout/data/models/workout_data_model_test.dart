import 'package:flutter_test/flutter_test.dart';
import 'package:magic_fit_app/src/workout/data/models/workout_data_model.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';
import 'package:magic_fit_app/src/workout/data/models/workout_model.dart';

void main() {
  group('WorkoutMapper', () {
    test('should convert WorkoutEntity to WorkoutModel correctly', () {
      // Arrange
      final workoutEntity = WorkoutEntity(
        sets: [
          SetEntity(exercise: 'Push-Up', weight: 0, repetitions: 20),
          SetEntity(exercise: 'Squat', weight: 50, repetitions: 15),
        ],
      );

      // Act
      final workoutModel = WorkoutMapper.toModel(workoutEntity);

      // Assert
      expect(workoutModel.sets.length, equals(2));
      expect(workoutModel.sets[0].exercise, equals('Push-Up'));
      expect(workoutModel.sets[0].weight, equals(0));
      expect(workoutModel.sets[0].repetitions, equals(20));
      expect(workoutModel.sets[1].exercise, equals('Squat'));
      expect(workoutModel.sets[1].weight, equals(50));
      expect(workoutModel.sets[1].repetitions, equals(15));
    });

    test('should convert WorkoutModel to WorkoutEntity correctly', () {
      // Arrange
      final workoutModel = WorkoutModel(
        sets: [
          SetModel(exercise: 'Push-Up', weight: 0, repetitions: 20),
          SetModel(exercise: 'Squat', weight: 50, repetitions: 15),
        ],
      );

      // Act
      final workoutEntity = WorkoutMapper.toEntity(workoutModel);

      // Assert
      expect(workoutEntity.sets.length, equals(2));
      expect(workoutEntity.sets[0].exercise, equals('Push-Up'));
      expect(workoutEntity.sets[0].weight, equals(0));
      expect(workoutEntity.sets[0].repetitions, equals(20));
      expect(workoutEntity.sets[1].exercise, equals('Squat'));
      expect(workoutEntity.sets[1].weight, equals(50));
      expect(workoutEntity.sets[1].repetitions, equals(15));
    });
  });
}
