// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'selected_pokemon_item_cubit.dart';

class SelectedPokemonItemState extends Equatable {
  final int? number;
  const SelectedPokemonItemState({this.number = 0});

  @override
  List<Object?> get props => [number];

  SelectedPokemonItemState copyWith({int? number}) {
    return SelectedPokemonItemState(number: number ?? this.number);
  }
}
