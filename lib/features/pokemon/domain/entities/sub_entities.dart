class SpritesEntity {
  final OtherEntity other;

  SpritesEntity({required this.other});
}

class OtherEntity {
  final OfficialArtworkEntity officialArtwork;

  OtherEntity({required this.officialArtwork});
}

class OfficialArtworkEntity {
  final String frontDefault;
  final String frontShiny;

  OfficialArtworkEntity({required this.frontDefault, required this.frontShiny});
}

class TypesEntity {
  final TypeEntity type;

  TypesEntity({required this.type});
}

class TypeEntity {
  final String name;

  TypeEntity({required this.name});
}
