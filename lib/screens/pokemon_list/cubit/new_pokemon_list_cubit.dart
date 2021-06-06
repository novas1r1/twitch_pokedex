import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/model/pokemon.dart';
import 'package:pokedex/repository/api_repository.dart';

part 'new_pokemon_list_state.dart';

class NewPokemonListCubit extends Cubit<NewPokemonListState> {
  NewPokemonListCubit()
      : super(NewPokemonListState(status: NewPokemonListStatus.inital));

  Future<void> fetchAllData() async {
    emit(NewPokemonListState(status: NewPokemonListStatus.loading));

    // TODO load from api
    try {
      ApiRepository apiRepository = ApiRepository();

      final data = await apiRepository.fetchAllPokemon();
      emit(NewPokemonListState(
        status: NewPokemonListStatus.loaded,
        data: data,
      ));
    } on Exception {
      emit(NewPokemonListState(status: NewPokemonListStatus.error));
    }
  }
}
