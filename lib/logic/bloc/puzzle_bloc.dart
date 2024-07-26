import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa27/logic/bloc/puzzle_event.dart';
import 'package:vazifa27/logic/bloc/puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc() : super(PuzzleState.initial()) {
    on<PuzzleInitialized>((event, emit) {
      emit(PuzzleState.initial());
    });

    on<PuzzleShuffled>((event, emit) {
      final tiles = List<int>.from(state.tiles);
      tiles.shuffle();
      emit(state.copyWith(tiles: tiles, isCompleted: false));
    });

    on<TileMoved>((event, emit) {
      final newState = _moveTile(event.tile, state);
      emit(newState);
    });
  }

  PuzzleState _moveTile(int tile, PuzzleState state) {
    final tiles = List<int>.from(state.tiles);
    final emptyIndex = tiles.indexOf(0);
    final tileIndex = tiles.indexOf(tile);

    if (_canTileMove(tileIndex, emptyIndex)) {
      tiles[emptyIndex] = tile;
      tiles[tileIndex] = 0;
    }

    return state.copyWith(
      tiles: tiles,
      isCompleted: _checkIfCompleted(tiles),
    );
  }

  bool _canTileMove(int tileIndex, int emptyIndex) {
    final rowTile = tileIndex ~/ 4;
    final colTile = tileIndex % 4;
    final rowEmpty = emptyIndex ~/ 4;
    final colEmpty = emptyIndex % 4;

    return (rowTile == rowEmpty && (colTile - colEmpty).abs() == 1) ||
        (colTile == colEmpty && (rowTile - rowEmpty).abs() == 1);
  }

  bool _checkIfCompleted(List<int> tiles) {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) {
        return false;
      }
    }
    return tiles[tiles.length - 1] == 0;
  }
}
