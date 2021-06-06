import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/screens/pokemon_detail/pokemon_detail_screen.dart';
import 'package:pokedex/screens/pokemon_list/cubit/new_pokemon_list_cubit.dart';
import 'package:pokedex/widgets/pokemon_tile.dart';

class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPokemonListCubit(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('All Pokémon')),
          body: BlocBuilder<NewPokemonListCubit, NewPokemonListState>(
            builder: (context, state) {
              switch (state.status) {
                case NewPokemonListStatus.inital:
                  return Column(
                    children: [
                      Text('Current List State: Initial'),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<NewPokemonListCubit>(context)
                                .fetchAllData();
                          },
                          child: Text('Load List Event'),
                        ),
                      ),
                    ],
                  );
                case NewPokemonListStatus.loading:
                  return CircularProgressIndicator();
                case NewPokemonListStatus.loaded:
                  return GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                      state.data!.length,
                      (index) => InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PokemonDetailScreen(
                                pokemon: state.data![index]),
                          ),
                        ),
                        child: Card(
                          color: Colors.grey, // TODO type of pokemon
                          child: Column(
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: 'title_${state.data![index].name}',
                                  child: Image.network(
                                      state.data![index].imageUrl),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '#${state.data![index].id}',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                /*ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PokemonTile(pokemon: state.data![index]);
                    },
                  );*/
                case NewPokemonListStatus.error:
                  return Center(
                    child: Text('Server error'),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

// bloc
// events - fetch list
// states - initial, loading, loaded 


/*class PokemonListScreen extends StatelessWidget {
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
}*/
