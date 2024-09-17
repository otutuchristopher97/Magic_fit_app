import 'package:flutter_test/flutter_test.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_state.dart';

void main() {
  group('WorkoutState', () {
    test('WorkoutInitial should have correct props and equality', () {
      // Arrange
      final state1 = WorkoutInitial();
      final state2 = WorkoutInitial();

      // Act & Assert
      expect(state1.props, []);
      expect(state1, equals(state2));
    });

    test('WorkoutLoading should have correct props and equality', () {
      // Arrange
      final state1 = WorkoutLoading();
      final state2 = WorkoutLoading();

      // Act & Assert
      expect(state1.props, []);
      expect(state1, equals(state2)); 
    });

    test('WorkoutLoaded should have correct props and equality', () {
      // Arrange
      final workouts = [
        WorkoutEntity(sets: [SetEntity(exercise: 'Push-Up', weight: 75.0, repetitions: 20)]),
        WorkoutEntity(sets: [SetEntity(exercise: 'Squat', weight: 100.0, repetitions: 15)]),
      ];
      final state1 = WorkoutLoaded(workouts);
      final state2 = WorkoutLoaded(workouts);

      // Act & Assert
      expect(state1.props, [workouts]);
      expect(state1, equals(state2));
    });

    test('WorkoutError should have correct props and equality', () {
      // Arrange
      const errorMessage = 'An error occurred';
      final state1 = WorkoutError(errorMessage);
      final state2 = WorkoutError(errorMessage);

      // Act & Assert
      expect(state1.props, [errorMessage]);
      expect(state1, equals(state2));
    });
  });
}
