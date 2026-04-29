import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/cubits/pokemon/pokemon_cubit.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/cubits/selected_pokemon_item/selected_pokemon_item_cubit.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/pages/data_page.dart';
import 'package:flutter_clean_architecture/features/pokemon/presentation/pages/pokemon_page.dart';
import 'package:flutter_clean_architecture/features/skeleton/cubits/cubit/selected_page_cubit.dart';
import 'package:flutter_clean_architecture/features/skeleton/widgets/custom_bottom_bar_widget.dart';

List<Widget> pages = [PokemonPage(), DataPage()];

class Skeleton extends StatefulWidget {
  const Skeleton({super.key});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  @override
  void initState() {
    final selectedPokemonItem = context.read<SelectedPokemonItemCubit>().state;

    context.read<PokemonCubit>().fetchPokemon(
      id: (selectedPokemonItem.number! + 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int selectedPage = context.read<SelectedPageCubit>().state.selectedPage;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Poke-Mapp')),
      body: pages[selectedPage],
      bottomNavigationBar: CustomBottomBarWidget(),
    );
  }
}
