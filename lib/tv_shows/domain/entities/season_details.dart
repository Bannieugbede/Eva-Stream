import 'package:equatable/equatable.dart';
import 'package:eva_stream/tv_shows/domain/entities/episode.dart';

class SeasonDetails extends Equatable {
  const SeasonDetails({
    required this.episodes,
  });

  final List<Episode> episodes;

  @override
  List<Object?> get props => [
        episodes,
      ];
}
