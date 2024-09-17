import 'package:flutter_test/flutter_test.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_event.dart';

void main() {
  group('WorkoutEvent', () {
    test('LoadWorkouts should have correct props', () {
      // Arrange
      final event1 = LoadWorkouts();
      final event2 = LoadWorkouts();

      // Act & Assert
      expect(event1.props, []);
      expect(event1, equals(event2)); // Since both instances should be equal
    });

    test('AddWorkout should pass correct props and maintain equality', () {
      // Arrange
      final workout = WorkoutEntity(sets: [
        SetEntity(exercise: 'Push-Up', weight: 75.0, repetitions: 20)
      ]);
      final event1 = AddWorkout(workout);
      final event2 = AddWorkout(workout);

      // Act & Assert
      expect(event1.props, [workout]);
      expect(event1, equals(event2)); // Both instances should be equal if they have the same workout
    });

    test('DeleteWorkout should pass correct props and maintain equality', () {
      // Arrange
      final index = 1;
      final event1 = DeleteWorkout(index);
      final event2 = DeleteWorkout(index);

      // Act & Assert
      expect(event1.props, [index]);
      expect(event1, equals(event2)); // Both instances should be equal if they have the same index
    });

    test('UpdateWorkout should pass correct props and maintain equality', () {
      // Arrange
      final workout = WorkoutEntity(sets: [
        SetEntity(exercise: 'Push-Up', weight: 75.0, repetitions: 20)
      ]);
      final index = 1;
      final event1 = UpdateWorkout(index, workout);
      final event2 = UpdateWorkout(index, workout);

      // Act & Assert
      expect(event1.props, [index, workout]);
      expect(event1, equals(event2)); // Both instances should be equal if they have the same index and workout
    });
  });
}
