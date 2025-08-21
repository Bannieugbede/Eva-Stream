import 'package:dartz/dartz.dart';
import '../../../core/data/error/failure.dart';
import '../entities/search_result_item.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResultItem>>> search(String title);
}
