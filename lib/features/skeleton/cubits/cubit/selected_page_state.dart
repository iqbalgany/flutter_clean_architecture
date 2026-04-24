// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'selected_page_cubit.dart';

class SelectedPageState extends Equatable {
  final int? selectedPage;
  const SelectedPageState({this.selectedPage = 0});

  @override
  List<Object?> get props => [selectedPage];

  SelectedPageState copyWith({int? selectedPage}) {
    return SelectedPageState(selectedPage: selectedPage ?? this.selectedPage);
  }
}
