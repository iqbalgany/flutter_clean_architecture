// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_clean_architecture/features/pokemon/domain/entities/sub_entities.dart';

class PokemonEntity {
  final String name;
  final int id;
  final SpritesEntity sprites;
  final List<TypesEntity> types;

  PokemonEntity({
    required this.name,
    required this.id,
    required this.sprites,
    required this.types,
  });
}
