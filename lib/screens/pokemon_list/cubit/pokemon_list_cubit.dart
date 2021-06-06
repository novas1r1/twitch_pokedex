import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/model/pokemon_response.dart';

import '../../../model/pokemon.dart';
import '../../../repository/api_repository.dart';

part 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final ApiRepository pokemonRepository;

  PokemonListCubit({
    required this.pokemonRepository,
  }) : super(PokemonListState());

  Future<void> fetchAllPokemon() async {
    emit(state.copyWith(status: PokemonListStatus.loading));

    final pokemonListResponse = await pokemonRepository.fetchAllPokemon();

    if (pokemonListResponse is SuccessPokemonListResponse) {
      emit(
        state.copyWith(
            status: PokemonListStatus.loaded,
            data: pokemonListResponse.pokemonList),
      );
    } else {
      emit(state.copyWith(errorMessage: 'Something went wrong'));
    }
  }
}
