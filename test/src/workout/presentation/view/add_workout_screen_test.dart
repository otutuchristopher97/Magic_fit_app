import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_event.dart';
import 'package:mocktail/mocktail.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_bloc.dart';
import 'package:magic_fit_app/src/workout/presentation/view/add_workout_screen.dart';

class MockWorkoutBloc extends Mock implements WorkoutBloc {}

void main() {
  late MockWorkoutBloc mockWorkoutBloc;

  setUp(() {
    mockWorkoutBloc = MockWorkoutBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<WorkoutBloc>.value(
        value: mockWorkoutBloc,
        child: const AddWorkoutScreen(),
      ),
    );
  }

  testWidgets('renders AddWorkoutScreen correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Add New Workout'), findsOneWidget);
    expect(find.text('Select Exercise'), findsOneWidget);
    expect(find.text('Weight (kg)'), findsOneWidget);
    expect(find.text('Repetitions'), findsOneWidget);
    expect(find.text('Add Set'), findsOneWidget);
  });

  testWidgets('displays error messages for empty form fields', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Add Set'));
    await tester.pumpAndSettle();

    expect(find.text('Please select an exercise'), findsOneWidget);
    expect(find.text('Please enter weight'), findsOneWidget);
    expect(find.text('Please enter repetitions'), findsOneWidget);
  });

  testWidgets('adds a set correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Select an exercise from the dropdown
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bench press').last);
    await tester.pumpAndSettle();

    // Enter weight and repetitions
    await tester.enterText(find.byType(TextFormField).at(0), '75');
    await tester.enterText(find.byType(TextFormField).at(1), '12');

    // Add set
    await tester.tap(find.text('Add Set'));
    await tester.pumpAndSettle();

    // Verify that the set is added to the list
    expect(find.text('Bench press - 75.0kg, 12 reps'), findsOneWidget);
  });

  testWidgets('saves workout and triggers AddWorkout event', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Select an exercise from the dropdown
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bench press').last);
    await tester.pumpAndSettle();

    // Enter weight and repetitions
    await tester.enterText(find.byType(TextFormField).at(0), '75');
    await tester.enterText(find.byType(TextFormField).at(1), '12');

    // Add set
    await tester.tap(find.text('Add Set'));
    await tester.pumpAndSettle();

    // Verify that the set is added
    expect(find.text('Bench press - 75.0kg, 12 reps'), findsOneWidget);

    // Tap the Save Workout button
    await tester.tap(find.text('Save Workout'));
    await tester.pumpAndSettle();

    // Verify that the AddWorkout event is triggered
    verify(() => mockWorkoutBloc.add(any(that: isA<AddWorkout>()))).called(1);
  });

  testWidgets('displays error message when trying to save without sets', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Try to save without adding a set
    await tester.tap(find.text('Save Workout'));
    await tester.pumpAndSettle();

    // Verify that the error snackbar is shown
    expect(find.text('Please add at least one set.'), findsOneWidget);
  });
}
