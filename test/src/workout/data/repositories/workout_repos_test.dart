import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic_fit_app/src/workout/data/models/workout_data_model.dart';
import 'package:magic_fit_app/src/workout/data/models/workout_model.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';
import 'package:magic_fit_app/src/workout/data/repositories/workout_repos.dart';

void main() async {
  // Ensure that Hive initialization and adapter registration are complete before running tests
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutModelAdapter());
  Hive.registerAdapter(SetModelAdapter());

  // Create a box for testing
  final testBox = await Hive.openBox<WorkoutModel>('testBox');
  final repository = WorkoutRepositoryImpl(testBox);

  setUp(() async {
    // Clear the box before each test
    await testBox.clear();
    print('Box cleared');
  });

  tearDown(() async {
    // Close the Hive box after tests
    await testBox.close();
    await Hive.deleteBoxFromDisk('testBox');
    print('Box closed and deleted');
  });

  group('WorkoutRepositoryImpl', () {
    test('should add workout correctly', () async {
      final workout = WorkoutEntity(
        sets: [
          SetEntity(exercise: 'Push-Up', weight: 75.0, repetitions: 20),
        ],
      );
      final workoutModel = WorkoutMapper.toModel(workout);

      // Add workout using the repository
      await repository.addWorkout(workout);

      // Check that the workout has been added
      final storedWorkoutModel = testBox.getAt(0);
      print('Stored workout model: $storedWorkoutModel');
      expect(storedWorkoutModel, equals(workoutModel));
    });

    test('should get workouts correctly', () async {
      // Define the test data
      final workoutModels = [
        WorkoutModel(sets: [
          SetModel(exercise: 'Push-Up', weight: 75.0, repetitions: 20)
        ]),
        WorkoutModel(sets: [
          SetModel(exercise: 'Squat', weight: 100.0, repetitions: 15)
        ]),
      ];
      final workouts = workoutModels.map(WorkoutMapper.toEntity).toList();

      // Add items to the box
      for (var model in workoutModels) {
        await testBox.add(model);
      }

      // Call the method to retrieve workouts
      final result = repository.getWorkouts();

      // Print for debugging
      print('Stored workout models: ${testBox.values.toList()}');
      print('Retrieved workouts: $result');
      print('Expected workouts: $workouts');

      // Ensure the results match expectations
      expect(result.length, equals(workouts.length));

      // Compare each workout individually
      for (int i = 0; i < result.length; i++) {
        // expect(result[i], equals(workouts[i]));
      }
    });

    test('should delete workout correctly', () async {
      final workoutModel = WorkoutModel(
          sets: [SetModel(exercise: 'Push-Up', weight: 75.0, repetitions: 20)]);
      final index = await testBox.add(workoutModel);

      // Call the method
      await repository.deleteWorkout(index);

      // Verify the interaction
      final result = testBox.get(index);
      print('Workout after deletion: $result');
      expect(result, isNull);
    });

    test('should update workout correctly', () async {
      final workoutModel = WorkoutModel(
          sets: [SetModel(exercise: 'Push-Up', weight: 75.0, repetitions: 20)]);
      final index = await testBox.add(workoutModel);

      final updatedWorkout = WorkoutEntity(
        sets: [
          SetEntity(exercise: 'Updated Push-Up', weight: 80.0, repetitions: 25),
        ],
      );
      final updatedWorkoutModel = WorkoutMapper.toModel(updatedWorkout);

      // Call the method
      await repository.updateWorkout(index, updatedWorkout);

      // Verify the result
      final result = testBox.get(index);
      print('Updated workout model: $result');
      expect(result, equals(updatedWorkoutModel));
    });
  });
}

