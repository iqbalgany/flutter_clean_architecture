import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/usecases/get_pokemon.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/presentation/cubits/cubit/pokemon_image_cubit.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final GetPokemon getPokemon;

  PokemonCubit({required this.getPokemon}) : super(const PokemonState());

  void fetchPokemon({
    required int id,
    PokemonImageCubit? pokemonImageCubit,
  }) async {
    emit(state.copyWith(errorMessage: null));

    final failureOrPokemon = await getPokemon.call(
      params: PokemonParams(id: id),
    );

    failureOrPokemon.fold(
      (failure) => emit(state.copyWith(failure: failure, pokemon: null)),
      (pokemon) {
        emit(state.copyWith(failure: null, pokemon: pokemon));
        pokemonImageCubit?.fetchPokemonImage(pokemonEntity: pokemon);
      },
    );
  }
}
