import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/connection/network_info.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/cubits/pokemon/pokemon_cubit.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/cubits/selected_pokemon_item/selected_pokemon_item_cubit.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/presentation/cubits/cubit/pokemon_image_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'custom_elevated_button_widget.dart';

class SearchPokemonWidget extends StatelessWidget {
  const SearchPokemonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPokemonItem = context.read<SelectedPokemonItemCubit>();
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
      child: Column(
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 5,
            children: [
              ElevatedButton(
                onPressed: () {
                  selectedPokemonItem.changeNumber(
                    newNumber: Random().nextInt(1008),
                  );
                },
                child: Text('Random', style: TextStyle(fontSize: 22)),
              ),
              ElevatedButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                      height: 216,
                      padding: EdgeInsets.only(top: 6),
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      color: CupertinoColors.systemBackground.resolveFrom(
                        context,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Done'),
                          ),
                          Expanded(
                            child: SafeArea(
                              top: false,
                              child: CupertinoPicker(
                                magnification: 1.22,
                                itemExtent: 32,
                                onSelectedItemChanged: (int selectedItem) {
                                  selectedPokemonItem.changeNumber(
                                    newNumber: selectedItem,
                                  );
                                },
                                children: List<Widget>.generate(1008, (
                                  int index,
                                ) {
                                  return Center(
                                    child: Text((index + 1).toString()),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Text(
                  '# ${selectedPokemonItem.state.number! + 1}',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
          CustomElevatedButtonWidget(
            buttonColor: Colors.orangeAccent,
            textColor: Colors.white,
            iconColor: Colors.white,
            callback: () async {
              final pokemonImageCubit = context.read<PokemonImageCubit>();

              context.read<PokemonCubit>().fetchPokemon(
                id: (selectedPokemonItem.state.number! + 1),
                pokemonImageCubit: pokemonImageCubit,
              );
              if (await NetworkInfoImpl(
                    connectionChecker: InternetConnectionChecker.instance,
                  ).isConnected ==
                  false) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No connection'),
                      showCloseIcon: true,
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
