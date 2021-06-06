import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/model/pokemon_response.dart';

import '../../../model/pokemon_detail.dart';
import '../../../repository/api_repository.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final ApiRepository apiRepository;

  PokemonDetailCubit({required this.apiRepository})
      : super(PokemonDetailState());

  Future<void> fetchPokemonDetails(int id) async {
    emit(state.copyWith(status: PokemonDetailStatus.loading));

    final pokemonDetailsResponse = await apiRepository.fetchPokemonDetails(id);

    if (pokemonDetailsResponse is SuccessPokemonDetailResponse) {
      emit(
        state.copyWith(
          status: PokemonDetailStatus.loaded,
          data: pokemonDetailsResponse.pokemonDetail,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: PokemonDetailStatus.error,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }
}
