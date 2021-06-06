import 'dart:convert';

import 'package:pokedex/model/pokemon_detail.dart';

import '../model/pokemon.dart';
import 'package:http/http.dart' as http;
import '../model/pokemon_response.dart';

class ApiRepository {
  static const String pokeApiUrl = 'pokeapi.co';
  static const String pokeApiBasePath = '/api/v2/';

  late http.Client _httpClient;

  ApiRepository({
    http.Client? httpClient,
  }) {
    _httpClient = httpClient ?? http.Client();
  }

  Future<List<Pokemon>> fetchAllPokemon() async {
    return _httpClient
        .get(Uri.https(
            pokeApiUrl, '${pokeApiBasePath}pokemon', {'limit': '151'}))
        .then((http.Response response) {
      if (response.statusCode == 200) {
        final List<Pokemon> pokemonList = [];
        final body = jsonDecode(response.body) as Map<String, dynamic>;

        final resultList = body['results'];

        for (final pokemon in resultList) {
          final pokemonMap = pokemon as Map<String, dynamic>;

          pokemonList.add(Pokemon.fromMap(pokemonMap));
        }

        return pokemonList;
      } else {
        return [];
        //return ErrorResponse('Something went wrong');
      }
    });
  }

  Future<PokemonResponse> fetchPokemonDetails(int id) async {
    return _httpClient
        .get(Uri.https(pokeApiUrl, '${pokeApiBasePath}pokemon/$id'))
        .then((http.Response response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;

        final pokemonDetail = PokemonDetail.fromMap(body);
        return SuccessPokemonDetailResponse(pokemonDetail);
      } else {
        return ErrorResponse('${response.statusCode}:Something went wrong');
      }
    });
  }
}
