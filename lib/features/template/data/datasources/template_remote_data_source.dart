import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/template/data/models/template_model.dart';

import '../../../../core/constants/constants.dart';

abstract class TemplateRemoteDataSource {
  Future<TemplateModel> getTemplate({required TemplateParams templateParams});
}

class TemplateRemoteDataSourceimpl implements TemplateRemoteDataSource {
  final Dio dio;

  TemplateRemoteDataSourceimpl({required this.dio});

  @override
  Future<TemplateModel> getTemplate({
    required TemplateParams templateParams,
  }) async {
    final response = await dio.get(
      '$baseUrl/pokemon/',
      queryParameters: {'api_key': 'if needed'},
    );

    if (response.statusCode == 200) {
      return TemplateModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
