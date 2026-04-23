part of 'selected_pokemon_item_cubit.dart';

class SelectedPokemonItemState extends Equatable {
  final int? number;
  const SelectedPokemonItemState({this.number = 0});

  @override
  List<Object?> get props => [number];
}
