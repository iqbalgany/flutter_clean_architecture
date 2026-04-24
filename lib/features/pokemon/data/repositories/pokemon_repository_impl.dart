import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/connection/network_info.dart';
import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:flutter_clean_architecture/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  final PokemonLocalDataSource localDataSource;

  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PokemonEntity>> getPokemon({
    required PokemonParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemon = await remoteDataSource.getPokemon(params: params);

        await localDataSource.cachePokemon(remotePokemon);

        return Right(remotePokemon);
      } on ServerException {
        return Left(ServerFailure('This is a server exception'));
      }
    } else {
      try {
        final localPokemon = await localDataSource.getLastPokemon();
        return Right(localPokemon);
      } on CacheException {
        return Left(CacheFailure('No local data found'));
      }
    }
  }
}
