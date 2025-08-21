import 'package:dartz/dartz.dart';

import '../../../core/data/error/failure.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../repository/watchlist_repository.dart';

class CheckIfItemAddedUseCase extends BaseUseCase<int, int> {
  final WatchlistRepository _watchlistRepository;

  CheckIfItemAddedUseCase(this._watchlistRepository);
  @override
  Future<Either<Failure, int>> call(int p) async {
    return await _watchlistRepository.checkIfItemAdded(p);
  }
}
