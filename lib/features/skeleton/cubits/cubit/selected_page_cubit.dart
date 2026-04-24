import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_page_state.dart';

class SelectedPageCubit extends Cubit<SelectedPageState> {
  SelectedPageCubit() : super(const SelectedPageState());

  void changePage(int newValue) {
    emit(state.copyWith(selectedPage: newValue));
  }
}
