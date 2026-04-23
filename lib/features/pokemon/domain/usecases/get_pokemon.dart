import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemon {
  final PokemonRepository repository;

  GetPokemon(this.repository);

  Future<Either<Failure, PokemonEntity>> call({
    required PokemonParams params,
  }) async {
    return await repository.getPokemon(params: params);
  }
}
