import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa27/core/pozzle.dart';
import 'package:vazifa27/logic/bloc/puzzle_bloc.dart';

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