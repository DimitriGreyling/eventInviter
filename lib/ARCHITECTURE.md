# Event Inviter - Architecture Documentation

## Overview
This application follows the **MVVM (Model-View-ViewModel)** architecture pattern with **Riverpod** for state management and **GoRouter** for navigation.

## Architecture Layers

### 1. Models (`lib/models/`)
- Contains data models and business entities
- Pure Dart classes with no Flutter dependencies
- Example: `CounterModel` - Represents counter state

### 2. Views (`lib/views/`)
- UI layer built with Flutter widgets
- Uses `ConsumerWidget` to watch Riverpod providers
- Should be as "dumb" as possible - only display data and handle user interactions
- Examples:
  - `HomeView` - Main screen with counter
  - `DetailView` - Secondary screen demonstrating navigation

### 3. ViewModels (`lib/view_models/`)
- Business logic layer
- Manages state using Riverpod's `StateNotifier`
- Handles data transformations and business rules
- Example: `CounterViewModel` - Manages counter state and operations

### 4. Router (`lib/router/`)
- Navigation configuration using GoRouter
- Defines all application routes
- Handles route parameters and navigation logic

## State Management - Riverpod

### Why Riverpod?
- Type-safe and compile-time safe
- No BuildContext needed for providers
- Better testability
- Excellent DevTools support

### Provider Types Used:
- **StateNotifierProvider**: For managing complex state with ViewModels

### Example Usage:
```dart
// Watching state
final counterState = ref.watch(counterViewModelProvider);

// Accessing ViewModel methods
final counterViewModel = ref.read(counterViewModelProvider.notifier);
counterViewModel.increment();
```

## Navigation - GoRouter

### Why GoRouter?
- Declarative routing
- Deep linking support
- Type-safe navigation
- Web URL support

### Navigation Methods:
```dart
// Push new route
context.push(AppRoutes.detail);

// Replace current route
context.go(AppRoutes.home);

// Pop back
context.pop();
```

## Project Structure

```
lib/
├── main.dart                 # App entry point with ProviderScope
├── models/                   # Data models
│   └── counter_model.dart
├── views/                    # UI screens
│   ├── home_view.dart
│   └── detail_view.dart
├── view_models/             # Business logic
│   └── counter_view_model.dart
└── router/                  # Navigation
    └── app_router.dart
```

## Adding New Features

### 1. Create a Model
```dart
class MyModel {
  final String data;
  const MyModel({required this.data});
  
  MyModel copyWith({String? data}) {
    return MyModel(data: data ?? this.data);
  }
}
```

### 2. Create a ViewModel
```dart
class MyViewModel extends StateNotifier<MyModel> {
  MyViewModel() : super(const MyModel(data: ''));
  
  void updateData(String newData) {
    state = state.copyWith(data: newData);
  }
}

final myViewModelProvider = 
    StateNotifierProvider<MyViewModel, MyModel>((ref) {
  return MyViewModel();
});
```

### 3. Create a View
```dart
class MyView extends ConsumerWidget {
  const MyView({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myViewModelProvider);
    final viewModel = ref.read(myViewModelProvider.notifier);
    
    return Scaffold(
      body: Text(state.data),
    );
  }
}
```

### 4. Add Route
```dart
GoRoute(
  path: '/my-route',
  name: 'myRoute',
  pageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: const MyView(),
  ),
),
```

## Best Practices

1. **Separation of Concerns**: Keep business logic in ViewModels, not in Views
2. **Immutability**: Use `copyWith` for state updates
3. **ConsumerWidget**: Always use for widgets that need to access providers
4. **Named Routes**: Use constants for route names to avoid typos
5. **Type Safety**: Leverage Dart's type system for compile-time safety

## Testing

- **Models**: Unit test with pure Dart tests
- **ViewModels**: Test business logic with `ProviderContainer`
- **Views**: Widget tests with `ProviderScope` override
- **Router**: Test navigation flows

## Dependencies

- `flutter_riverpod`: ^2.5.1 - State management
- `riverpod_annotation`: ^2.3.5 - Code generation annotations
- `go_router`: ^14.2.7 - Routing and navigation
- `build_runner`: ^2.4.12 - Code generation tool
- `riverpod_generator`: ^2.4.3 - Riverpod code generation
