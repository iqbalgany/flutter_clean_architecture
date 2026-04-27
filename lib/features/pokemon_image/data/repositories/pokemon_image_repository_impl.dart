import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/connection/network_info.dart';
import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/data/datasources/pokemin_image_local_data_source.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/data/datasources/pokemon_image_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/data/models/pokemon_image_model.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/domain/entities/pokemon_image_entity.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/domain/repositories/pokemon_image_repository.dart';

class PokemonImageRepositoryImpl implements PokemonImageRepository {
  final PokemonImageRemoteDataSource remoteDataSource;
  final PokemonImageLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokemonImageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PokemonImageEntity>> getPokemonImage({
    required PokemonImageParams pokemonImageParams,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        PokemonImageModel remoteTemplate = await remoteDataSource
            .getPokemonImage(pokemonImageParams: pokemonImageParams);

        await localDataSource.cachePokemonImage(
          pokemonImageToCache: remoteTemplate,
        );

        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure('This is server Exception'));
      }
    } else {
      try {
        final localTemplate = await localDataSource.getLastPokemonImage();
        return Right(localTemplate);
      } on CacheException {
        return Left(CacheFailure('No local data found'));
      }
    }
  }
}
