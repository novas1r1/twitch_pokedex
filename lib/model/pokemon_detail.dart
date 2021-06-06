import 'dart:convert';

import 'package:flutter/material.dart';

class PokemonDetail {
  final List<PokemonType> types;
  final List<PokemonAbility> abilities;
  final int height;
  final int weight;

  PokemonDetail({
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
  });

  factory PokemonDetail.fromMap(Map<String, dynamic> map) {
    return PokemonDetail(
      types: List<PokemonType>.from(
          map['types'].map((x) => PokemonType.fromMap(x))),
      abilities: List<PokemonAbility>.from(
          map['abilities'].map((x) => PokemonAbility.fromMap(x))),
      height: map['height'],
      weight: map['weight'],
    );
  }

  factory PokemonDetail.fromJson(String source) =>
      PokemonDetail.fromMap(json.decode(source));
}

class PokemonAbility {
  final String title;
  final int slot;

  PokemonAbility({
    required this.title,
    required this.slot,
  });

  factory PokemonAbility.fromMap(Map<String, dynamic> map) {
    return PokemonAbility(
      title: map['ability']['name'],
      slot: map['slot'],
    );
  }

  factory PokemonAbility.fromJson(String source) =>
      PokemonAbility.fromMap(json.decode(source));
}

class PokemonType {
  final String title;
  final int slot;

  PokemonType({
    required this.title,
    required this.slot,
  });

  factory PokemonType.fromMap(Map<String, dynamic> map) {
    return PokemonType(
      title: map['type']['name'],
      slot: map['slot'],
    );
  }

  factory PokemonType.fromJson(String source) =>
      PokemonType.fromMap(json.decode(source));

  Color get color {
    switch (title) {
      case 'water':
        return Colors.blue;
      case 'fire':
        return Colors.red;
      case 'electro':
        return Colors.yellow;
      case 'grass':
        return Colors.green;
      case 'poison':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Image get icon {
    return Image.asset('assets/icons/types/$title.png');
  }
}
