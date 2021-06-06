import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/repository/api_repository.dart';

import 'screens/pokemon_list/pokemon_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ApiRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Pokédex',
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: TextTheme(
            headline2: TextStyle(fontSize: 32, color: Colors.black87),
          ),
        ),
        home: PokemonListScreen(),
      ),
    );
  }
}
