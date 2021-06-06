part of 'pokemon_list_cubit.dart';

enum PokemonListStatus {
  loading,
  loaded,
  error,
}

class PokemonListState extends Equatable {
  final PokemonListStatus status;
  final List<Pokemon>? data;
  final String? errorMessage;

  const PokemonListState({
    this.status = PokemonListStatus.loading,
    this.data,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, data, errorMessage];

  PokemonListState copyWith({
    PokemonListStatus? status,
    List<Pokemon>? data,
    String? errorMessage,
  }) {
    return PokemonListState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
