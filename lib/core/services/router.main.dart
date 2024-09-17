import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_fit_app/src/workout/presentation/view/add_workout_screen.dart';
import 'package:magic_fit_app/src/workout/presentation/view/workout_list_screen.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        initialLocation: WorkoutListScreen.routeName,
        routes: [
          GoRoute(
            path: WorkoutListScreen.routeName,
            pageBuilder: (context, state) => const MaterialPage(
              child: WorkoutListScreen(),
            ),
          ),
          GoRoute(
            path: AddWorkoutScreen.routeName,
            name: 'add-workout', 
            pageBuilder: (context, state) {
              final Map<String, dynamic>? extra =
                  state.extra as Map<String, dynamic>?;

              final workout = extra?['workout'];
              final index = extra?['index'] as String?;

              return MaterialPage(
                child: AddWorkoutScreen(
                  workout: workout,
                  index: index != null ? int.tryParse(index) : null,
                ),
              );
            },
          ),
        ],
      );
}
