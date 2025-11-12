/// Model class representing a counter
class CounterModel {
  final int value;

  const CounterModel({required this.value});

  CounterModel copyWith({int? value}) {
    return CounterModel(value: value ?? this.value);
  }
}
