import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa27/logic/bloc/puzzle_bloc.dart';
import 'package:vazifa27/logic/bloc/puzzle_event.dart';
import 'package:vazifa27/ui/screens/puzzle_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PuzzleBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PuzzleBloc()..add(PuzzleInitialized()),
        child: const PuzzleScreen(),
      ),
    );
  }
}