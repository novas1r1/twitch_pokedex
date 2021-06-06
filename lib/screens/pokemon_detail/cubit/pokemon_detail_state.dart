part of 'pokemon_detail_cubit.dart';

enum PokemonDetailStatus {
  loading,
  loaded,
  error,
}

class PokemonDetailState extends Equatable {
  final PokemonDetailStatus status;
  final PokemonDetail? data;
  final String? errorMessage;

  const PokemonDetailState({
    this.status = PokemonDetailStatus.loading,
    this.data,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, data, errorMessage];

  PokemonDetailState copyWith({
    PokemonDetailStatus? status,
    PokemonDetail? data,
    String? errorMessage,
  }) {
    return PokemonDetailState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
