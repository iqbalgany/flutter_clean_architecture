import 'package:flutter_clean_architecture/features/pokemon/data/models/sub_models.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel({
    required super.name,
    required super.id,
    required super.sprites,
    required super.types,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'sprites': (sprites as SpritesModel).toJson(),
      'types': types.map((e) => (e as TypeModel).toJson()).toList(),
    };
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'] ?? '',
      id: json['id'] ?? 0,
      sprites: SpritesModel.fromJson(json['sprites'] as Map<String, dynamic>),
      types: (json['types'] as List)
          .map((e) => TypesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
