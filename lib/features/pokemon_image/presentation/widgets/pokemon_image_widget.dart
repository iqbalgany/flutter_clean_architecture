import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/presentation/cubits/cubit/pokemon_image_cubit.dart';

import '../../domain/entities/pokemon_image_entity.dart';

class PokemonImageWidget extends StatelessWidget {
  final Widget child;
  const PokemonImageWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    PokemonImageEntity? pokemonImageEntity = context
        .read<PokemonImageCubit>()
        .state
        .pokemonImage;
    Failure? failure = context.read<PokemonImageCubit>().state.failure;
    late Widget widget;
    if (pokemonImageEntity != null) {
      widget = Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange,
            image: DecorationImage(
              image: FileImage(File(pokemonImageEntity.imageUrl)),
            ),
          ),
          child: child,
        ),
      );
    } else if (failure != null) {
      widget = Expanded(
        child: Center(
          child: Text(failure.message, style: TextStyle(fontSize: 20)),
        ),
      );
    } else {
      widget = Expanded(child: Center(child: CircularProgressIndicator()));
    }
    return widget;
  }
}
