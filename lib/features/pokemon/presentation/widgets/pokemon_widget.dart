import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/cubits/pokemon/pokemon_cubit.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/presentation/widgets/pokemon_image_widget.dart';

class PokemonWidget extends StatelessWidget {
  const PokemonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PokemonEntity? pokemon = context.read<PokemonCubit>().state.pokemon;
    Failure? failure = context.read<PokemonCubit>().state.failure;
    late Widget widget;
    if (pokemon != null) {
      widget = PokemonImageWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: SingleChildScrollView(
                  child: FittedBox(
                    child: Text(
                      '#${pokemon.id} ${pokemon.name.toUpperCase()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(blurRadius: 20, color: Colors.black45),
                        ],
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 5,
                runSpacing: 5,
                children: List.generate(
                  pokemon.types.length,
                  (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text(
                      pokemon.types.elementAt(index).type.name.toUpperCase(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (failure != null) {
      widget = Expanded(
        child: Center(
          child: Text(failure.message, style: TextStyle(fontSize: 20)),
        ),
      );
    } else {
      widget = Expanded(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.orangeAccent,
          ),
        ),
      );
    }
    return widget;
  }
}
