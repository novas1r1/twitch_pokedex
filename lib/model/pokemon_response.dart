import 'package:pokedex/model/pokemon.dart';
import 'package:pokedex/model/pokemon_detail.dart';

abstract class PokemonResponse {}

class SuccessPokemonListResponse extends PokemonResponse {
  final List<Pokemon> pokemonList;

  SuccessPokemonListResponse(this.pokemonList);
}

class SuccessPokemonDetailResponse extends PokemonResponse {
  final PokemonDetail pokemonDetail;

  SuccessPokemonDetailResponse(this.pokemonDetail);
}

class ErrorResponse extends PokemonResponse {
  final String errorMessage;

  ErrorResponse(this.errorMessage);
}
