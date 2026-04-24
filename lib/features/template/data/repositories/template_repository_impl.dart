import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/connection/network_info.dart';
import 'package:flutter_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture/core/errors/failure.dart';
import 'package:flutter_clean_architecture/core/params/params.dart';
import 'package:flutter_clean_architecture/features/template/data/datasources/template_local_data_source.dart';
import 'package:flutter_clean_architecture/features/template/data/datasources/template_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/template/data/models/template_model.dart';
import 'package:flutter_clean_architecture/features/template/domain/entities/template_entity.dart';
import 'package:flutter_clean_architecture/features/template/domain/repositories/template_repository.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  final TemplateRemoteDataSource remoteDataSource;
  final TemplateLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TemplateRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TemplateEntity>> getTemplate({
    required TemplateParams templateParams,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        TemplateModel remoteTemplate = await remoteDataSource.getTemplate(
          templateParams: templateParams,
        );

        await localDataSource.cacheTemplate(templateToCache: remoteTemplate);

        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure('This is server Exception'));
      }
    } else {
      try {
        final localTemplate = await localDataSource.getLastTemplate();
        return Right(localTemplate);
      } on CacheException {
        return Left(CacheFailure('No local data found'));
      }
    }
  }
}
