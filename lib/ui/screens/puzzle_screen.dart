import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa27/logic/bloc/puzzle_bloc.dart';
import 'package:vazifa27/logic/bloc/puzzle_event.dart';
import 'package:vazifa27/logic/bloc/puzzle_state.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({super.key});

  void _showWinDialog(BuildContext context, int timeElapsed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You completed the puzzle in $timeElapsed seconds!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  buildTile(BuildContext context, int tile) {
    return GestureDetector(
      onTap: tile == 0
          ? null
          : () {
              context.read<PuzzleBloc>().add(TileMoved(tile));
            },
      child: Container(
        decoration: BoxDecoration(
          color: tile == 0
              ? Colors.grey[300]
              : const Color.fromARGB(255, 33, 61, 243),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            tile == 0 ? '' : '$tile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: tile == 0 ? Colors.transparent : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(182, 22, 23, 26),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(39, 22, 23, 26),
        centerTitle: true,
        title: const Text(
          '15 Puzzle',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<PuzzleBloc, PuzzleState>(
        listener: (context, state) {
          if (state.isCompleted) {
            _showWinDialog(context, state.timeElapsed);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton(
                        onPressed: () {
                          context.read<PuzzleBloc>().add(PuzzleShuffled());
                        },
                        child: const Text(
                          'Restart',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Text(
                        'Time: ${state.timeElapsed}s',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      return buildTile(context, state.tiles[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}