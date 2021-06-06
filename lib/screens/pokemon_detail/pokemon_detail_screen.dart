import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/pokemon.dart';
import '../../model/pokemon_detail.dart';
import '../../repository/api_repository.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'cubit/pokemon_detail_cubit.dart';

class PokemonDetailScreen extends StatelessWidget {
  final String routeName = '/pokemonDetails';
  final Pokemon pokemon;

  const PokemonDetailScreen({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailCubit(
          apiRepository: RepositoryProvider.of<ApiRepository>(context))
        ..fetchPokemonDetails(pokemon.id),
      child: Scaffold(
        appBar: AppBar(title: Text('#${pokemon.id} ${pokemon.name}')),
        body: Column(
          children: [
            Hero(
              tag: 'title_${pokemon.name}',
              child: Image.network(pokemon.imageUrl),
            ),
            Container(
              child: Text(
                pokemon.name,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
              builder: (context, state) {
                switch (state.status) {
                  case PokemonDetailStatus.loading:
                    return LoadingWidget();
                  case PokemonDetailStatus.loaded:
                    return _buildPokemonDetails(state.data!);
                  case PokemonDetailStatus.error:
                    return CustomErrorWidget(message: state.errorMessage!);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonDetails(PokemonDetail data) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: List.generate(
              data.types.length,
              (index) => Row(
                children: [
                  Chip(
                    backgroundColor: data.types[index].color,
                    avatar: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: data.types[index].icon,
                    ),
                    label: Text(data.types[index].title),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
          Row(
            children: List.generate(
              data.abilities.length,
              (index) => Text(
                data.abilities[index].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
