import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:flutter_clean_architecture/features/template/domain/entities/template_entity.dart';
import 'package:flutter_clean_architecture/features/template/domain/usecases/get_template.dart';

part 'template_state.dart';

class TemplateCubit extends Cubit<TemplateState> {
  final GetTemplate getTemplate;
  TemplateCubit(this.getTemplate) : super(const TemplateState());

  bool isShiny = true;

  void fetchTemplate({required PokemonEntity pokemonEntity}) async {
    emit(state.copyWith(errorMessage: null));

    String imageUrl = isShiny
        ? pokemonEntity.sprites.other.officialArtwork.frontShiny
        : pokemonEntity.sprites.other.officialArtwork.frontDefault;

    final failureOrTemplate = await getTemplate.call(
      templateParams: TemplateParams(
        name: pokemonEntity.name,
        imageUrl: imageUrl,
      ),
    );

    failureOrTemplate.fold(
      (failure) => emit(state.copyWith(failure: failure, template: null)),
      (template) => emit(state.copyWith(failure: null, template: template)),
    );
  }
}
