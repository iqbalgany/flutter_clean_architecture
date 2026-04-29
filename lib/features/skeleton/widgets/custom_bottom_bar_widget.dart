import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/skeleton/cubits/cubit/selected_page_cubit.dart';
import 'package:flutter_clean_architecture/features/skeleton/widgets/custom_bottom_bar_icon_widget.dart';

class CustomBottomBarWidget extends StatelessWidget {
  const CustomBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedPage = context.watch<SelectedPageCubit>().state.selectedPage;
    return SafeArea(
      child: BottomAppBar(
        elevation: 0,
        color: Colors.orangeAccent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: selectedPage == 0
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Divider(height: 0, color: Colors.white, thickness: 2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBottomBarIconWidget(
                  callback: () =>
                      context.read<SelectedPageCubit>().changePage(0),
                  isSelected: selectedPage == 0,
                  iconDataSelected: Icons.search_outlined,
                  iconDataUnselected: Icons.search_outlined,
                ),
                CustomBottomBarIconWidget(
                  callback: () =>
                      context.read<SelectedPageCubit>().changePage(1),
                  isSelected: selectedPage == 1,
                  iconDataSelected: Icons.menu,
                  iconDataUnselected: Icons.menu,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
