import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa27/logic/bloc/puzzle_bloc.dart';
import 'package:vazifa27/logic/bloc/puzzle_event.dart';
import 'package:vazifa27/logic/bloc/puzzle_state.dart';

class PuzzleScreen extends StatelessWidget {
  const PuzzleScreen({super.key});

  void _showWinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
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

  Widget buildTile(BuildContext context, int tile) {
    return GestureDetector(
      onTap: tile == 0
          ? null
          : () {
              context.read<PuzzleBloc>().add(TileMoved(tile));
            },
      child: Container(
        decoration: BoxDecoration(
          color: tile == 0 ? Colors.grey[300] : Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            tile == 0 ? '' : '$tile',
            style: TextStyle(
              fontSize: 28,
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 78, 176),
        centerTitle: true,
        title: const Text(
          'Puzzle Game',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<PuzzleBloc, PuzzleState>(
        listener: (context, state) {
          if (state.isCompleted) {
            _showWinDialog(context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  'https://bogatyr.club/uploads/posts/2023-03/1678896872_bogatyr-club-p-fon-geim-foni-krasivo-20.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: 16,
                        itemBuilder: (context, index) {
                          return buildTile(context, state.tiles[index]);
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PuzzleBloc>().add(PuzzleShuffled());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Restart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
