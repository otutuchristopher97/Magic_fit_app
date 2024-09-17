import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_bloc.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_event.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_state.dart';
import 'package:magic_fit_app/src/workout/presentation/view/workout_list_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Mock classes
class MockWorkoutBloc extends MockBloc<WorkoutEvent, WorkoutState>
    implements WorkoutBloc {}

class FakeWorkoutEvent extends Fake implements WorkoutEvent {}

class FakeWorkoutState extends Fake implements WorkoutState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeWorkoutEvent());
    registerFallbackValue(FakeWorkoutState());
  });

  group('WorkoutListScreen Widget Tests', () {
    late MockWorkoutBloc mockWorkoutBloc;

    setUp(() {
      mockWorkoutBloc = MockWorkoutBloc();
    });

    // Test 1: Check if CircularProgressIndicator is shown when loading
    testWidgets('renders CircularProgressIndicator when loading', (tester) async {
      when(() => mockWorkoutBloc.state).thenReturn(WorkoutLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<WorkoutBloc>.value(
            value: mockWorkoutBloc,
            child: const WorkoutListScreen(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    // Test 2: Check if workout list is rendered correctly
    testWidgets('renders workout list when loaded', (tester) async {
      final workouts = [
        WorkoutEntity(sets: [SetEntity(exercise: 'Squat', weight: 100, repetitions: 10)]),
        WorkoutEntity(sets: [SetEntity(exercise: 'Deadlift', weight: 150, repetitions: 8)]),
      ];

      when(() => mockWorkoutBloc.state).thenReturn(WorkoutLoaded(workouts));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<WorkoutBloc>.value(
            value: mockWorkoutBloc,
            child: const WorkoutListScreen(),
          ),
        ),
      );

      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text('Workout 1'), findsOneWidget);
      expect(find.text('Workout 2'), findsOneWidget);
    });

    // Test 3: Check if error message is shown
    testWidgets('renders error message when state is WorkoutError', (tester) async {
      when(() => mockWorkoutBloc.state).thenReturn(const WorkoutError('Failed to load workouts'));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<WorkoutBloc>.value(
            value: mockWorkoutBloc,
            child: const WorkoutListScreen(),
          ),
        ),
      );

      expect(find.text('Error: Failed to load workouts'), findsOneWidget);
    });

    // Test 4: Simulate deleting a workout
    testWidgets('deletes a workout when delete icon is tapped', (tester) async {
      final workouts = [
        WorkoutEntity(sets: [SetEntity(exercise: 'Squat', weight: 100, repetitions: 10)]),
      ];

      when(() => mockWorkoutBloc.state).thenReturn(WorkoutLoaded(workouts));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<WorkoutBloc>.value(
            value: mockWorkoutBloc,
            child: const WorkoutListScreen(),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      verify(() => mockWorkoutBloc.add(DeleteWorkout(0))).called(1);
    });
  });
}
