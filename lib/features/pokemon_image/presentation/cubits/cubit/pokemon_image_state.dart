// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_image_cubit.dart';

class PokemonImageState extends Equatable {
  final PokemonImageEntity? pokemonImage;
  final Failure? failure;
  final String? errorMessage;
  const PokemonImageState({
    this.pokemonImage,
    this.failure,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [pokemonImage, failure, errorMessage];

  PokemonImageState copyWith({
    PokemonImageEntity? pokemonImage,
    Failure? failure,
    String? errorMessage,
  }) {
    return PokemonImageState(
      pokemonImage: pokemonImage ?? this.pokemonImage,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
