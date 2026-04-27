import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/domain/entities/pokemon_image_entity.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/domain/usecases/get_pokemon_image.dart';

part 'pokemon_image_state.dart';

class PokemonImageCubit extends Cubit<PokemonImageState> {
  final GetPokemonImage getPokemonImage;
  PokemonImageCubit(this.getPokemonImage) : super(const PokemonImageState());

  bool isShiny = true;

  void fetchPokemonImage({required PokemonEntity pokemonEntity}) async {
    emit(state.copyWith(errorMessage: null));

    String imageUrl = isShiny
        ? pokemonEntity.sprites.other.officialArtwork.frontShiny
        : pokemonEntity.sprites.other.officialArtwork.frontDefault;

    final failureOrTemplate = await getPokemonImage.call(
      pokemonImageParams: PokemonImageParams(
        name: pokemonEntity.name,
        imageUrl: imageUrl,
      ),
    );

    failureOrTemplate.fold(
      (failure) => emit(state.copyWith(failure: failure, pokemonImage: null)),
      (pokemonImage) =>
          emit(state.copyWith(failure: null, pokemonImage: pokemonImage)),
    );
  }
}
