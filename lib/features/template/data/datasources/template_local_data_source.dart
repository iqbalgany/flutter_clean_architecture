import 'dart:convert';

import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/features/template/data/models/template_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TemplateLocalDataSource {
  Future<void> cacheTemplate({required TemplateModel? templateToCache});
  Future<TemplateModel> getLastTemplate();
}

const cachedTemplate = 'CACHED_TEMPLATE';

class TemplateLocalDataSourceImpl implements TemplateLocalDataSource {
  final SharedPreferences sharedPreferences;

  TemplateLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheTemplate({required TemplateModel? templateToCache}) async {
    if (templateToCache != null) {
      await sharedPreferences.setString(
        cachedTemplate,
        jsonEncode(templateToCache.toJson()),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<TemplateModel> getLastTemplate() {
    final jsonString = sharedPreferences.getString(cachedTemplate);

    if (jsonString != null) {
      return Future.value(TemplateModel.fromJson(jsonString));
    } else {
      throw CacheException();
    }
  }
}
