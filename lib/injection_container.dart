import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/connection/network_info.dart';
import 'package:flutter_clean_architecture/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:flutter_clean_architecture/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/usecases/get_pokemon.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/cubits/pokemon/pokemon_cubit.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/data/datasources/pokemin_image_local_data_source.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/data/datasources/pokemon_image_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/domain/usecases/get_pokemon_image.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDepedencies() async {
  sl.registerFactory(() => PokemonCubit(getPokemon: sl()));

  sl.registerLazySingleton(() => GetPokemon(sl()));

  sl.registerLazySingleton(() => GetPokemonImage(pokemonImageRepository: sl()));

  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<PokemonLocalDataSource>(
    () => PokemonLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<PokemonImageRemoteDataSource>(
    () => PokemonImageRemoteDataSourceimpl(dio: sl()),
  );

  sl.registerLazySingleton<PokemonImageLocalDataSource>(
    () => PokemonImageLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPref);

  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
}
