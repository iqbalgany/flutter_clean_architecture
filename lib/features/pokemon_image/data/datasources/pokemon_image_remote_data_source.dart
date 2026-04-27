import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/data/models/pokemon_image_model.dart';
import 'package:path_provider/path_provider.dart';

abstract class PokemonImageRemoteDataSource {
  Future<PokemonImageModel> getPokemonImage({
    required PokemonImageParams pokemonImageParams,
  });
}

class PokemonImageRemoteDataSourceimpl implements PokemonImageRemoteDataSource {
  final Dio dio;

  PokemonImageRemoteDataSourceimpl({required this.dio});

  @override
  Future<PokemonImageModel> getPokemonImage({
    required PokemonImageParams pokemonImageParams,
  }) async {
    Directory directory = await getApplicationDocumentsDirectory();
    directory.deleteSync(recursive: true);
    final String pathFile = '${directory.path}/${pokemonImageParams.name}.png';

    final response = await dio.download(pokemonImageParams.imageUrl, pathFile);

    if (response.statusCode == 200) {
      return PokemonImageModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
