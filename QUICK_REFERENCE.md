# Event Inviter - Quick Reference

## 🚀 Running the App

```bash
flutter run
```

## 📁 Project Structure (MVVM)

```
lib/
├── main.dart                      # Entry point with ProviderScope
├── models/                        # 📦 Data models
│   └── counter_model.dart
├── views/                         # 🎨 UI layer (ConsumerWidget)
│   ├── home_view.dart
│   └── detail_view.dart
├── view_models/                   # 🧠 Business logic (StateNotifier)
│   └── counter_view_model.dart
└── router/                        # 🧭 Navigation (GoRouter)
    └── app_router.dart
```

## 🔑 Key Concepts

### 1. Riverpod State Management

**Watch state (rebuilds on change):**
```dart
final state = ref.watch(counterViewModelProvider);
```

**Read ViewModel (doesn't rebuild):**
```dart
final viewModel = ref.read(counterViewModelProvider.notifier);
viewModel.increment();
```

### 2. GoRouter Navigation

**Push route:**
```dart
context.push(AppRoutes.detail);
```

**Go to route (replace):**
```dart
context.go(AppRoutes.home);
```

**Pop back:**
```dart
context.pop();
```

### 3. MVVM Pattern

**Model** → Data structure
```dart
class CounterModel {
  final int value;
  const CounterModel({required this.value});
}
```

**ViewModel** → Business logic
```dart
class CounterViewModel extends StateNotifier<CounterModel> {
  void increment() => state = state.copyWith(value: state.value + 1);
}
```

**View** → UI
```dart
class HomeView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterViewModelProvider);
    return Text('${state.value}');
  }
}
```

## 🛠️ Common Tasks

### Add a New Screen

1. **Create Model** (`lib/models/my_model.dart`)
2. **Create ViewModel** (`lib/view_models/my_view_model.dart`)
3. **Create View** (`lib/views/my_view.dart`)
4. **Add Route** in `lib/router/app_router.dart`

### Access State Across Screens

State is shared automatically through Riverpod providers. Any screen can watch the same provider!

## 📦 Dependencies

- `flutter_riverpod` - State management
- `go_router` - Navigation
- `riverpod_annotation` - Code generation support

## 🎯 Current Features

- ✅ Counter with increment/decrement/reset
- ✅ Navigation between Home and Detail views
- ✅ Shared state across screens
- ✅ Type-safe routing
- ✅ Clean MVVM architecture

## 🔄 Next Steps

1. Add more screens for event management
2. Create event models and ViewModels
3. Integrate backend API calls
4. Add authentication
5. Implement invite functionality
