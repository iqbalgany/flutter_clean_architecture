import 'dart:convert';

import 'package:flutter_clean_architecture/features/template/domain/entities/template_entity.dart';

class TemplateModel extends TemplateEntity {
  TemplateModel({required super.template});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'template': template};
  }

  factory TemplateModel.fromMap(Map<String, dynamic> map) {
    return TemplateModel(template: map['template'] as String);
  }

  factory TemplateModel.fromJson(String source) {
    return TemplateModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }
  String toJson() => json.encode(toMap());
}
