import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_pokemon_item_state.dart';

class SelectedPokemonItemCubit extends Cubit<SelectedPokemonItemState> {
  SelectedPokemonItemCubit() : super(const SelectedPokemonItemState());

  // void changeNumber({required int newNumber}) {
  //   number = newNumber;
  // }
}
