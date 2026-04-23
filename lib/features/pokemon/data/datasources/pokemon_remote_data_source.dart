import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/constants/constants.dart';
import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/pokemon/data/models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonModel> getPokemon({required PokemonParams params});
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonModel> getPokemon({required PokemonParams params}) async {
    final response = await dio.get(
      '$baseUrl/pokemon/${params.id}',
      queryParameters: {'api_key': ''},
    );

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
