import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/api_repository.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/pokemon_tile.dart';
import 'cubit/pokemon_list_cubit.dart';

class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonListCubit(
          pokemonRepository: RepositoryProvider.of<ApiRepository>(context))
        ..fetchAllPokemon(),
      child: Scaffold(
        appBar: AppBar(title: Text('All Pokémon')),
        body: BlocBuilder<PokemonListCubit, PokemonListState>(
          builder: (context, state) {
            switch (state.status) {
              case PokemonListStatus.initial:
              case PokemonListStatus.loading:
                return LoadingWidget();
              case PokemonListStatus.loaded:
                return ListView.builder(
                  itemCount: state.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PokemonTile(
                      pokemon: state.data![index],
                    );
                  },
                );
              case PokemonListStatus.error:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(state.errorMessage!)
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
