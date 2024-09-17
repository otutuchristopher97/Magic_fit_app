import 'package:hive/hive.dart';

part 'workout_model.g.dart'; // Required for Hive code generation

@HiveType(typeId: 0)
class SetModel {
  @HiveField(0)
  final String exercise;
  @HiveField(1)
  final double weight;
  @HiveField(2)
  final int repetitions;

  SetModel({required this.exercise, required this.weight, required this.repetitions});
}

@HiveType(typeId: 1)
class WorkoutModel {
  @HiveField(0)
  final List<SetModel> sets;

  WorkoutModel({required this.sets});
}
