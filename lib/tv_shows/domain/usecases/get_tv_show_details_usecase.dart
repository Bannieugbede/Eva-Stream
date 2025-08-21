import 'package:eva_stream/core/data/error/failure.dart';
import 'package:eva_stream/core/domain/entities/media_details.dart';
import 'package:eva_stream/tv_shows/domain/repository/tv_shows_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/domain/usecase/base_use_case.dart';

class GetTVShowDetailsUseCase extends BaseUseCase<MediaDetails, int> {
  final TVShowsRepository _baseTVShowsRepository;

  GetTVShowDetailsUseCase(this._baseTVShowsRepository);
  @override
  Future<Either<Failure, MediaDetails>> call(int p) async {
    return await _baseTVShowsRepository.getTVShowDetails(p);
  }
}
