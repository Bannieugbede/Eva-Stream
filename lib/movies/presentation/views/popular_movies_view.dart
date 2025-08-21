import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/presentation/components/custom_app_bar.dart';
import '../../../core/presentation/components/error_screen.dart';
import '../../../core/presentation/components/loading_indicator.dart';
import '../../../core/presentation/components/vertical_listview.dart';
import '../../../core/presentation/components/vertical_listview_card.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../controllers/popular_movies_bloc/popular_movies_bloc.dart';

class PopularMoviesView extends StatelessWidget {
  const PopularMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<PopularMoviesBloc>()..add(GetPopularMoviesEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.popularMovies,
        ),
        body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case GetAllRequestStatus.loading:
                return const LoadingIndicator();
              case GetAllRequestStatus.loaded:
                return PopularMoviesWidget(movies: state.movies);
              case GetAllRequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<PopularMoviesBloc>()
                        .add(GetPopularMoviesEvent());
                  },
                );
              case GetAllRequestStatus.fetchMoreError:
                return PopularMoviesWidget(movies: state.movies);
            }
          },
        ),
      ),
    );
  }
}

class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({
    required this.movies,
    super.key,
  });

  final List<Media> movies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (context, state) {
        return VerticalListView(
          itemCount: movies.length + 1,
          itemBuilder: (context, index) {
            if (index < movies.length) {
              return VerticalListViewCard(media: movies[index]);
            } else {
              return const LoadingIndicator();
            }
          },
          addEvent: () {
            context
                .read<PopularMoviesBloc>()
                .add(FetchMorePopularMoviesEvent());
          },
        );
      },
    );
  }
}
