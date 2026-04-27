import 'dart:convert';

import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/data/models/pokemon_image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PokemonImageLocalDataSource {
  Future<void> cachePokemonImage({
    required PokemonImageModel? pokemonImageToCache,
  });
  Future<PokemonImageModel> getLastPokemonImage();
}

const cachedPokemonImage = 'CACHED_POKEMON_IMAGE';

class PokemonImageLocalDataSourceImpl implements PokemonImageLocalDataSource {
  final SharedPreferences sharedPreferences;

  PokemonImageLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cachePokemonImage({
    required PokemonImageModel? pokemonImageToCache,
  }) async {
    if (pokemonImageToCache != null) {
      await sharedPreferences.setString(
        cachedPokemonImage,
        jsonEncode(pokemonImageToCache.toJson()),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<PokemonImageModel> getLastPokemonImage() {
    final jsonString = sharedPreferences.getString(cachedPokemonImage);

    if (jsonString != null) {
      return Future.value(PokemonImageModel.fromJson(jsonString));
    } else {
      throw CacheException();
    }
  }
}
