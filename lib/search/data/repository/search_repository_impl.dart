import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../core/data/error/exceptions.dart';
import '../../../core/data/error/failure.dart';
import '../../domain/entities/search_result_item.dart';
import '../../domain/repository/search_repository.dart';
import '../datasource/search_remote_data_source.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource _baseSearchRemoteDataSource;

  SearchRepositoryImpl(this._baseSearchRemoteDataSource);

  @override
  Future<Either<Failure, List<SearchResultItem>>> search(String title) async {
    try {
      final result = await _baseSearchRemoteDataSource.search(title);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioError catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }
}
