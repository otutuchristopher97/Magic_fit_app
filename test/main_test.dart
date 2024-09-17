import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic_fit_app/src/workout/data/models/workout_model.dart';

// Initialize Hive with an in-memory storage for testing
void main() async {
  await Hive.initFlutter();

  // Create a Hive box for testing
  final mockBox = await Hive.openBox<WorkoutModel>('testBox');

  // Run your tests
  test('example test', () async {
    // Use mockBox in your tests
  });

  // Close the Hive box after tests
  await mockBox.close();
}
