import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/cubits/pokemon/pokemon_cubit.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/cubits/selected_pokemon_item/selected_pokemon_item_cubit.dart';
import 'package:flutter_clean_architecture/features/pokemon_image/presentation/cubits/cubit/pokemon_image_cubit.dart';
import 'package:flutter_clean_architecture/features/skeleton/cubits/cubit/selected_page_cubit.dart';
import 'package:flutter_clean_architecture/features/skeleton/skeleton.dart';
import 'package:flutter_clean_architecture/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDepedencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PokemonCubit(getPokemon: sl())),
        BlocProvider(create: (context) => SelectedPokemonItemCubit()),
        BlocProvider(create: (context) => SelectedPageCubit()),
        BlocProvider(
          create: (context) => PokemonImageCubit(getPokemonImage: sl()),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Skeleton()),
    );
  }
}
