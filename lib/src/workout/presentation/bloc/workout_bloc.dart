import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_fit_app/src/workout/domain/entities/workout.dart';
import 'package:magic_fit_app/src/workout/domain/usecases/workout.dart';
import 'workout_event.dart';
import 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final GetWorkoutsUseCase getWorkoutsUseCase;
  final AddWorkoutUseCase addWorkoutUseCase;
  final DeleteWorkoutUseCase deleteWorkoutUseCase;
  final UpdateWorkoutUseCase updateWorkoutUseCase;

  WorkoutBloc({
    required this.getWorkoutsUseCase,
    required this.addWorkoutUseCase,
    required this.deleteWorkoutUseCase,
    required this.updateWorkoutUseCase,
  }) : super(WorkoutInitial()) {
    on<LoadWorkouts>((event, emit) async {
      emit(WorkoutLoading());
      try {
        final workouts = getWorkoutsUseCase();
        emit(WorkoutLoaded(workouts as List<WorkoutEntity>));
      } catch (e) {
        emit(WorkoutError(e.toString()));
      }
    });

    on<AddWorkout>((event, emit) async {
      try {
        await addWorkoutUseCase(event.workout);
        add(LoadWorkouts()); // Reload after adding
      } catch (e) {
        emit(WorkoutError(e.toString()));
      }
    });

    on<DeleteWorkout>((event, emit) async {
      try {
        await deleteWorkoutUseCase(event.index);
        add(LoadWorkouts()); // Reload after deletion
      } catch (e) {
        emit(WorkoutError(e.toString()));
      }
    });

    on<UpdateWorkout>((event, emit) async {
      try {
        await updateWorkoutUseCase(event.index, event.workout);
        add(LoadWorkouts()); // Reload after updating
      } catch (e) {
        emit(WorkoutError(e.toString()));
      }
    });
  }
}
