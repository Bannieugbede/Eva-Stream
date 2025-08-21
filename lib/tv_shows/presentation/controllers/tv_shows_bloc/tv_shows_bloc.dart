import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/entities/media.dart';
import '../../../../core/domain/usecase/base_use_case.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_tv_shows_usecase.dart';

part 'tv_shows_event.dart';
part 'tv_shows_state.dart';

class TVShowsBloc extends Bloc<TVShowsEvent, TVShowsState> {
  TVShowsBloc(this._getTvShowsUseCase) : super(const TVShowsState()) {
    on<GetTVShowsEvent>(_getTvShows);
  }

  final GetTVShowsUseCase _getTvShowsUseCase;

  Future<void> _getTvShows(
      TVShowsEvent event, Emitter<TVShowsState> emit) async {
    emit(
      const TVShowsState(
        status: RequestStatus.loading,
      ),
    );
    final result = await _getTvShowsUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        const TVShowsState(
          status: RequestStatus.error,
        ),
      ),
      (r) => emit(
        TVShowsState(
          status: RequestStatus.loaded,
          tvShows: r,
        ),
      ),
    );
  }
}
