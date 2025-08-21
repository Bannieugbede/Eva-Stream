import 'package:hive_flutter/hive_flutter.dart';
import 'package:dartz/dartz.dart';

import '../../../core/data/error/failure.dart';
import '../../../core/domain/entities/media.dart';
import '../../domain/repository/watchlist_repository.dart';
import '../datasource/watchlist_local_data_source.dart';
import '../models/watchlist_item_model.dart';

class WatchListRepositoryImpl extends WatchlistRepository {
  final WatchlistLocalDataSource _baseWatchlistLocalDataSource;

  WatchListRepositoryImpl(this._baseWatchlistLocalDataSource);

  @override
  Future<Either<Failure, List<Media>>> getWatchListItems() async {
    final result = (await _baseWatchlistLocalDataSource.getWatchListItems());
    try {
      return Right(result);
    } on HiveError catch (failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, int>> addWatchListItem(Media media) async {
    try {
      int id = await _baseWatchlistLocalDataSource.addWatchListItem(
        WatchlistItemModel.fromEntity(media),
      );
      return Right(id);
    } on HiveError catch (failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeWatchListItem(int index) async {
    try {
      await _baseWatchlistLocalDataSource.removeWatchListItem(index);
      return const Right(unit);
    } on HiveError catch (failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, int>> checkIfItemAdded(int tmdbId) async {
    try {
      final result = await _baseWatchlistLocalDataSource.isItemAdded(tmdbId);
      return Right(result);
    } on HiveError catch (failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }
}
