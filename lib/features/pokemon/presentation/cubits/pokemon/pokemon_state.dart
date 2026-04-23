// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_cubit.dart';

class PokemonState extends Equatable {
  final PokemonEntity? pokemon;
  final Failure? failure;
  final String? errorMessage;
  const PokemonState({this.pokemon, this.failure, this.errorMessage = ''});

  @override
  List<Object?> get props => [pokemon, failure, errorMessage];

  PokemonState copyWith({
    PokemonEntity? pokemon,
    Failure? failure,
    String? errorMessage,
  }) {
    return PokemonState(
      pokemon: pokemon ?? this.pokemon,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
