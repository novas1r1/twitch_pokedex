import '../common/utils/capitalize_extension.dart';

class Pokemon {
  final String name;
  final String url;

  Pokemon({
    required this.name,
    required this.url,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      name: (map['name'] as String).inCaps,
      url: map['url'],
    );
  }

  int get id {
    final splitString = url.split('/pokemon/');
    final parsedId = splitString[1].replaceFirst(r'/', '');

    return int.parse(parsedId);
  }

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
}
