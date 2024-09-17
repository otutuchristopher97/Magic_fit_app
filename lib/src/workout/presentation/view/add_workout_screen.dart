import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_fit_app/core/res/pallet.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_bloc.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_event.dart';
import 'package:magic_fit_app/src/workout/presentation/view/workout_list_screen.dart';

class AddWorkoutScreen extends StatefulWidget {
  static const routeName = '/add-workout';

  final WorkoutEntity? workout;
  final int? index;

  const AddWorkoutScreen({
    Key? key,
    this.workout,
    this.index,
  }) : super(key: key);

  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedExercise;
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repetitionsController = TextEditingController();

  List<SetEntity> _sets = [];

  @override
  void initState() {
    super.initState();

    if (widget.workout != null) {
      _sets = List.from(widget.workout!.sets);

      if (_sets.isNotEmpty) {
        _selectedExercise = _sets.first.exercise;
        _weightController.text = _sets.first.weight.toString();
        _repetitionsController.text = _sets.first.repetitions.toString();
      }
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repetitionsController.dispose();
    super.dispose();
  }

  void _addSet() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _sets.add(SetEntity(
          exercise: _selectedExercise!,
          weight: double.parse(_weightController.text),
          repetitions: int.parse(_repetitionsController.text),
        ));
        _selectedExercise = null;
        _weightController.clear();
        _repetitionsController.clear();
      });
    }
  }

  void _saveWorkout() {
    if (_sets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one set.')),
      );
      return;
    }

    final workout = WorkoutEntity(sets: _sets);
    final index = widget.index;

    if (index != null) {
      context.read<WorkoutBloc>().add(UpdateWorkout(index, workout));
    } else {
      context.read<WorkoutBloc>().add(AddWorkout(workout));
    }

    context.go(WorkoutListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index != null ? 'Edit Workout' : 'Add New Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedExercise,
                    decoration: const InputDecoration(
                      labelText: 'Select Exercise',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      'Barbell row',
                      'Bench press',
                      'Shoulder press',
                      'Deadlift',
                      'Squat'
                    ]
                        .map((exercise) => DropdownMenuItem<String>(
                              value: exercise,
                              child: Text(exercise),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedExercise = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an exercise';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter weight';
                      }
                      final weight = double.tryParse(value);
                      if (weight == null || weight <= 0) {
                        return 'Please enter a valid weight';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _repetitionsController,
                    decoration: const InputDecoration(
                      labelText: 'Repetitions',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter repetitions';
                      }
                      final reps = int.tryParse(value);
                      if (reps == null || reps <= 0) {
                        return 'Please enter valid repetitions';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addSet,
                    child: const Text('Add Set'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _sets.isEmpty
                  ? const Center(child: Text('No sets added yet.'))
                  : ListView.builder(
                      itemCount: _sets.length,
                      itemBuilder: (context, index) {
                        final set = _sets[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                                '${set.exercise} - ${set.weight}kg, ${set.repetitions} reps'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _sets.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallet.primary,
                  
                ),
                onPressed: _saveWorkout,
                child: Text(
                    widget.index != null ? 'Update Workout' : 'Save Workout', style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
