import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stream_transform/stream_transform.dart';

// Debounce transformer
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => Switch(events.debounceTime(duration)).switchMap(mapper);
}

abstract class CounterEvent {}
class IncrementEvent extends CounterEvent {}

// Bloc
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementEvent>((event, emit) async {
      print('Processing event, current state: $state');
      await Future.delayed(Duration(seconds: 1));
      emit(state + 1);
      print('Event processed, new state: $state');
    },
      transformer: debounce(const Duration(milliseconds: 0)),
      /// Sequential ensures that events are processed one after another in the order they were added
      /// Concurrent would allow multiple events to be processed simultaneously
      /// Droppable would drop new events if one is already being processed
      /// Restartable would cancel the current processing and start with the new event
      /// Debounce would wait for a pause in events before processing the latest one
    );
  }
}

void main() async {
  final bloc = CounterBloc();

  bloc.stream.listen((s) => print('State: $s'));

  bloc.add(IncrementEvent());
  bloc.add(IncrementEvent());
  bloc.add(IncrementEvent());

  await Future.delayed(Duration(seconds: 4));
  await bloc.close();
}