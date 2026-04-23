import 'package:flutter_clean_architecture/features/pokemon/domain/entities/sub_entities.dart';

class OfficialArtworkModel extends OfficialArtworkEntity {
  OfficialArtworkModel({
    required super.frontDefault,
    required super.frontShiny,
  });

  factory OfficialArtworkModel.fromJson(Map<String, dynamic> json) {
    return OfficialArtworkModel(
      frontDefault: json['front_deault'] ?? '',
      frontShiny: json['front_shiny'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'front_default': frontDefault, 'front_shiny': frontShiny};
  }
}

class OtherModel extends OtherEntity {
  OtherModel({required super.officialArtwork});

  factory OtherModel.fromJson(Map<String, dynamic> json) {
    return OtherModel(
      officialArtwork: OfficialArtworkModel.fromJson(json['official-artwork']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'official-artwork': (officialArtwork as OfficialArtworkModel).toJson(),
    };
  }
}

class SpritesModel extends SpritesEntity {
  SpritesModel({required OtherModel other}) : super(other: other);

  factory SpritesModel.fromJson(Map<String, dynamic> json) {
    return SpritesModel(other: OtherModel.fromJson(json['other']));
  }

  Map<String, dynamic> toJson() {
    return {'other': (other as OtherModel).toJson()};
  }
}

class TypeModel extends TypeEntity {
  TypeModel({required super.name});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(name: json['name'] as String? ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class TypesModel extends TypesEntity {
  TypesModel({required TypeModel type}) : super(type: type);

  factory TypesModel.fromJson(Map<String, dynamic> json) {
    return TypesModel(
      type: TypeModel.fromJson(json['type'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': (type as TypeModel).toJson()};
  }
}
