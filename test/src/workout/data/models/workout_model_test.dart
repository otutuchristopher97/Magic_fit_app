import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic_fit_app/src/workout/data/models/workout_model.dart';

void main() {
  setUpAll(() async {
    // Initialize Hive with an in-memory storage
    Hive.init('test');
    Hive.registerAdapter(SetModelAdapter());
    Hive.registerAdapter(WorkoutModelAdapter());
  });

  group('WorkoutModel', () {
    late Box<WorkoutModel> workoutBox;

    setUp(() async {
      // Open a test box with an in-memory store
      workoutBox = await Hive.openBox<WorkoutModel>('testBox');
    });

    tearDown(() async {
      // Close and delete the test box
      await workoutBox.close();
      await Hive.deleteBoxFromDisk('testBox');
    });

    test('should serialize and deserialize WorkoutModel correctly', () async {
      // Arrange
      final setModel1 = SetModel(exercise: 'Push-Up', weight: 0.0, repetitions: 20);
      final setModel2 = SetModel(exercise: 'Squat', weight: 50.0, repetitions: 15);
      final workoutModel = WorkoutModel(sets: [setModel1, setModel2]);

      // Act
      await workoutBox.put('testKey', workoutModel);
      final retrievedModel = workoutBox.get('testKey');

      // Assert
      expect(retrievedModel, isNotNull);
      expect(retrievedModel?.sets.length, equals(2));
      expect(retrievedModel?.sets[0].exercise, equals('Push-Up'));
      expect(retrievedModel?.sets[0].weight, equals(0.0));
      expect(retrievedModel?.sets[0].repetitions, equals(20));
      expect(retrievedModel?.sets[1].exercise, equals('Squat'));
      expect(retrievedModel?.sets[1].weight, equals(50.0));
      expect(retrievedModel?.sets[1].repetitions, equals(15));
    });
  });
}
