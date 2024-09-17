# magic_fit_app

Magic Fit App is a Flutter-based application developed to allow users to track their workout routines efficiently. Built using clean architecture principles, the app separates concerns and organizes the code into distinct layers to enhance scalability, maintainability, and testability. The app includes two primary screens:

Workout List Screen: Displays all the recorded workouts.
Add/Edit Workout Screen: Allows users to create new workouts or edit existing ones by adding/removing sets, updating exercises, weights, and repetitions.

# Features:
* Add/Edit Workouts: Users can record workout sets, choose exercises, enter weights, and set repetitions.
* Workout List: Displays all recorded workouts, allowing users to delete or edit them.
* Persistence: Data is stored locally using Hive, making the workouts persist between app sessions.
* Navigation: Utilizes go_router for seamless navigation between the workout list and add/edit screens.
* Clean Architecture: Codebase is structured with clean architecture principles, ensuring a separation of concerns.
* Bloc State Management: Uses flutter_bloc for predictable state management.
* Testing: Implements unit, widget, and integration testing using mocktail, bloc_test, and flutter_test.

# App Architecture:
This app follows the Clean Architecture pattern, which divides the application into several layers:

# Domain Layer:

* Contains business logic.
Includes entities, use cases, and repositories.
Entities: Core objects (e.g., WorkoutEntity, SetEntity).
Use Cases: Interactors that manage business logic (e.g., AddWorkoutUseCase, GetWorkoutsUseCase).
Data Layer:

* Responsible for data access, including Hive-based local storage.
Includes models (e.g., WorkoutModel, SetModel), mappers, and repository implementations.
Hive is used as a lightweight, key-value storage for persisting data locally.
WorkoutRepositoryImpl provides the implementation for CRUD operations on workouts.
Presentation Layer:

* Contains UI and state management (via Bloc).
WorkoutBloc: Manages states like loading, loaded, and error for the workout data.
Screens: UI components (WorkoutListScreen, AddWorkoutScreen) render data and trigger events like adding or updating a workout.
go_router is used to handle navigation between screens.

# Package Breakdown:
hive (v2.2.3): A lightweight, NoSQL database used to store workout data locally.
hive_flutter (v1.1.0): Adds support for using Hive with Flutter applications.
equatable (v2.0.5): Used to simplify equality checks within entity classes.
lottie (v3.1.2): Utilized for animations to improve user experience.
dartz (v0.10.1): Functional programming package for modeling errors using Either types.
flutter_bloc (v8.1.6): State management library for managing application state via Blocs and Events.
go_router (v14.2.7): A declarative router for Flutter applications, simplifying navigation and deep linking.
path_provider (v2.1.4): Provides access to commonly used directories, such as temporary files and app directories.

# Testing:
Testing is a key part of the Magic Fit App. Here's how the app is tested:

Unit Tests: Verify that individual classes and methods, such as mappers, repositories, and use cases, work as expected.

Example: Testing WorkoutRepositoryImpl for adding, deleting, and fetching workouts.
Widget Tests: Validate the UI components and interactions between the widget and Bloc.

Example: Ensure that the WorkoutListScreen correctly updates when workouts are loaded.
Integration Tests: Cover end-to-end testing to ensure that the app behaves correctly, from user interaction to data persistence.

# Testing Packages:

flutter_test: Flutter's default testing framework for writing unit, widget, and integration tests.
mocktail (v1.0.4) & mockito (v5.4.4): Mocking frameworks for simulating dependencies and mocking data during tests.
bloc_test (v9.1.7): Provides tools for testing Bloc components.
hive_test (v1.0.1): A Hive-specific testing package for setting up in-memory databases for testing without disk IO.