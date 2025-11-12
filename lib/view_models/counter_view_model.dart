import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/counter_model.dart';

/// State notifier for managing counter state
class CounterViewModel extends StateNotifier<CounterModel> {
  CounterViewModel() : super(const CounterModel(value: 0));

  /// Increment the counter value
  void increment() {
    state = state.copyWith(value: state.value + 1);
  }

  /// Decrement the counter value
  void decrement() {
    state = state.copyWith(value: state.value - 1);
  }

  /// Reset the counter to zero
  void reset() {
    state = const CounterModel(value: 0);
  }
}

/// Provider for the counter view model
final counterViewModelProvider =
    StateNotifierProvider<CounterViewModel, CounterModel>((ref) {
  return CounterViewModel();
});
