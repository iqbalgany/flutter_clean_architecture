import 'dart:convert';

import 'package:flutter_clean_architecture/features/pokemon_image/domain/entities/pokemon_image_entity.dart';

class PokemonImageModel extends PokemonImageEntity {
  PokemonImageModel({required super.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'imageUrl': imageUrl};
  }

  factory PokemonImageModel.fromMap(Map<String, dynamic> map) {
    return PokemonImageModel(imageUrl: map['imageUrl'] as String);
  }

  factory PokemonImageModel.fromJson(String source) {
    return PokemonImageModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }
  String toJson() => json.encode(toMap());
}
