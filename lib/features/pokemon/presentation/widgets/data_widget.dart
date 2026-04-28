import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/cubits/pokemon/pokemon_cubit.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PokemonEntity? pokemon = context.read<PokemonCubit>().state.pokemon;
    Failure? failure = context.read<PokemonCubit>().state.failure;
    late Widget widget;
    if (pokemon != null) {
      widget = SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Text('API'),
              title: Text('https://pokeapi.co/api/v2/pokemon/${pokemon.id}'),
              tileColor: Colors.orange,
            ),
            ListTile(title: Text('Name'), subtitle: Text(pokemon.name)),
            Divider(),
            ListTile(title: Text('Id'), subtitle: Text(pokemon.id.toString())),
            Divider(),
            ListTile(leading: Text('{ }'), title: Text('sprites')),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  ListTile(leading: Text('{ }'), title: Text('other')),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('{ }'),
                          title: Text('official-artwork'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('official-artwork'),
                                subtitle: Text(
                                  pokemon
                                      .sprites
                                      .other
                                      .officialArtwork
                                      .frontDefault,
                                ),
                              ),
                              ListTile(
                                title: Text('front_shiny'),
                                subtitle: Text(
                                  pokemon
                                      .sprites
                                      .other
                                      .officialArtwork
                                      .frontShiny,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(leading: Text('[ ]'), title: Text('types')),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: List.generate(
                  pokemon.types.length,
                  (index) => Column(
                    children: [
                      ListTile(leading: Text('{ }'), title: Text('type')),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ListTile(
                          title: Text('name'),
                          subtitle: Text(
                            pokemon.types.elementAt(index).type.name,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (failure != null) {
      widget = Center(child: Text(failure.message));
    } else {
      widget = Center(child: CircularProgressIndicator());
    }
    return widget;
  }
}
