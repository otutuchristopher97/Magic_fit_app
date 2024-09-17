import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:magic_fit_app/core/services/router.main.dart';
import 'package:magic_fit_app/src/workout/data/repositories/workout_repos.dart';
import 'package:magic_fit_app/src/workout/domain/usecases/workout.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_bloc.dart';
import 'package:magic_fit_app/src/workout/presentation/bloc/workout_event.dart';
import 'package:magic_fit_app/src/workout/presentation/view/workout_list_screen.dart';
import 'package:magic_fit_app/src/workout/presentation/view/add_workout_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:magic_fit_app/src/workout/data/models/workout_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(SetModelAdapter());
  Hive.registerAdapter(WorkoutModelAdapter());

  final workoutBox = await Hive.openBox<WorkoutModel>('workoutsBox');
  final workoutRepository = WorkoutRepositoryImpl(workoutBox);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp(workoutRepository: workoutRepository));
}

class MyApp extends StatelessWidget {
  final WorkoutRepositoryImpl workoutRepository;

  const MyApp({Key? key, required this.workoutRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter().router; // Use your AppRouter

    return RepositoryProvider.value(
      value: workoutRepository,
      child: BlocProvider(
        create: (context) => WorkoutBloc(
          getWorkoutsUseCase: GetWorkoutsUseCase(workoutRepository),
          addWorkoutUseCase: AddWorkoutUseCase(workoutRepository),
          deleteWorkoutUseCase: DeleteWorkoutUseCase(workoutRepository),
          updateWorkoutUseCase: UpdateWorkoutUseCase(workoutRepository),
        )..add(LoadWorkouts()),
        child: MaterialApp.router(
          routerDelegate: appRouter.routerDelegate,
          routeInformationParser: appRouter.routeInformationParser,
          routeInformationProvider: appRouter.routeInformationProvider,
          title: 'Magic Fit App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ),
      ),
    );
  }
}
