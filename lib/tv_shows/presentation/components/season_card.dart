import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/components/error_text.dart';
import '../../../core/presentation/components/image_with_shimmer.dart';
import '../../../core/presentation/components/loading_indicator.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/functions.dart';
import '../../domain/entities/season.dart';
import '../controllers/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'episodes_widget.dart';

class SeasonCard extends StatelessWidget {
  const SeasonCard({
    super.key,
    required this.season,
    required this.tvShowId,
  });

  final Season season;
  final int tvShowId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        _showBottomSheet(context, tvShowId, season.seasonNumber);
      },
      child: SizedBox(
        width: double.infinity,
        height: AppSize.s160,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: AppPadding.p16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s8),
                child: ImageWithShimmer(
                  imageUrl: season.posterUrl,
                  width: AppSize.s110,
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    season.name,
                    style: textTheme.bodyMedium,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p6),
                    child: Text(
                      '${season.episodeCount} ${AppStrings.episodes.toLowerCase()}',
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  if (season.airDate.isNotEmpty) ...[
                    Text(
                      '${AppStrings.airDate} ${season.airDate}',
                      style: textTheme.bodyLarge,
                    ),
                  ],
                  if (season.overview.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p4),
                      child: Text(
                        season.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primaryText,
              size: AppSize.s18,
            )
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(context, id, seasonNumber) {
  showCustomBottomSheet(
    context,
    BlocProvider.value(
      value: sl<TVShowDetailsBloc>()
        ..add(GetSeasonDetailsEvent(id: id, seasonNumber: seasonNumber)),
      child: BlocBuilder<TVShowDetailsBloc, TVShowDetailsState>(
        builder: (context, state) {
          switch (state.seasonDetailsStatus) {
            case RequestStatus.loading:
              return const LoadingIndicator();
            case RequestStatus.loaded:
              return EpisodesWidget(episodes: state.seasonDetails!.episodes);
            case RequestStatus.error:
              return const ErrorText();
          }
        },
      ),
    ),
  );
}
