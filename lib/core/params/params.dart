class NoParams {}

class TemplateParams {
  final String name;
  final String imageUrl;

  TemplateParams({required this.name, required this.imageUrl});
}

class PokemonParams {
  final int id;

  PokemonParams({required this.id});
}

class PokemonImageParams {
  final String name;
  final String imageUrl;

  PokemonImageParams({required this.name, required this.imageUrl});
}
