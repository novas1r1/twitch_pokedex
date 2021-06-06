part of 'new_pokemon_list_cubit.dart';

enum NewPokemonListStatus {
  inital,
  loading,
  loaded,
  error,
}

class NewPokemonListState extends Equatable {
  final NewPokemonListStatus status;
  final List<Pokemon>? data;

  NewPokemonListState({
    required this.status,
    this.data,
  });

  @override
  List<Object?> get props => [status, data];
}
