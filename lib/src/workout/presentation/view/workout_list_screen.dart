import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_bloc.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_event.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_state.dart';
import 'package:magic_fit_app/src/workout/presentation/view/add_workout_screen.dart';

class WorkoutListScreen extends StatefulWidget {
  static const routeName = '/workouts';

  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<WorkoutBloc>()
        .add(LoadWorkouts()); // Load workouts when the screen is opened
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WorkoutLoaded) {
            return ListView.builder(
              itemCount: state.workouts.length,
              itemBuilder: (context, index) {
                final workout = state.workouts[index];
                return ListTile(
                  title: Text('Workout ${index + 1}'),
                  subtitle: Text('Total sets: ${workout.sets.length}'),
                  onTap: () {
                    context.goNamed(
                      'add-workout',
                      extra: {
                        'index': index.toString(),
                        'workout': workout,
                      },
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<WorkoutBloc>().add(DeleteWorkout(index));
                    },
                  ),
                );
              },
            );
          } else if (state is WorkoutError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No workouts available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(AddWorkoutScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
