import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon.dart';
import 'package:pokedex/screens/pokemon_detail/pokemon_detail_screen.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonTile({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PokemonDetailScreen(pokemon: pokemon),
      )),
      leading: Hero(
        tag: 'title_${pokemon.name}',
        child: CircleAvatar(
          child: Image.network(pokemon.imageUrl),
        ),
      ),
      title: Text(pokemon.name),
      // subtitle: Text(type),
      trailing: Text('#${pokemon.id}'),
    );
  }
}
