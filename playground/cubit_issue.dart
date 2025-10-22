import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  Future<void> incrementSlowly() async {
    final current = state;
    await Future.delayed(Duration(seconds: 1));
    emit(current + 1);
  }
}

void main() async {
  final cubit = CounterCubit();

  cubit.stream.listen((s) => print('State: $s'));

  /// Call to methods that emit new states
  cubit.incrementSlowly();
  cubit.incrementSlowly();
  cubit.incrementSlowly();

  await Future.delayed(Duration(seconds: 3));
}