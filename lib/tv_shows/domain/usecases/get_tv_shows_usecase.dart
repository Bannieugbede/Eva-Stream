import 'package:eva_stream/core/data/error/failure.dart';
import 'package:eva_stream/core/domain/entities/media.dart';
import 'package:eva_stream/core/domain/usecase/base_use_case.dart';
import 'package:eva_stream/tv_shows/domain/repository/tv_shows_repository.dart';
import 'package:dartz/dartz.dart';

class GetTVShowsUseCase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final TVShowsRepository _baseTVShowsRepository;

  GetTVShowsUseCase(this._baseTVShowsRepository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _baseTVShowsRepository.getTVShows();
  }
}
