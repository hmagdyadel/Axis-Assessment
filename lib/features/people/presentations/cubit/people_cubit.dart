import 'package:axis_assessment/core/networking/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/people_model.dart';
import '../../domain/repository/people_repository.dart';
import 'pagination_state.dart';
import 'people_states.dart';

class PeopleCubit extends Cubit<PeopleStates> {
  final PeopleRepository _peopleRepository;

  PeopleCubit(this._peopleRepository) : super(const PeopleStates.initial());

  final List<PersonResult> _peopleResult = [];
  PaginationState _pagination = const PaginationState();

  bool get hasMorePeople => _pagination.hasMore;

  Future<void> getPeople({bool isNextPage = false}) async {
    if (_pagination.isLoading || (!hasMorePeople && isNextPage)) return;

    try {
      _pagination = _pagination.copyWith(isLoading: true);

      if (!isNextPage) {
        resetPeoplePage();
        emit(const PeopleStates.loading());
      } else {
        _pagination = _pagination.copyWith(
          currentPage: _pagination.currentPage + 1,
        );
        emit(
          PeopleStates.success(
            PeopleModel(results: _peopleResult),
            isLoadingMore: true,
          ),
        );
      }

      final response = await _peopleRepository.getPeople(
        _pagination.currentPage + 1,
      ); // 1-based

      await response.when(
        success: (data) async {
          if (data.results != null && data.results!.isNotEmpty) {
            if (_pagination.currentPage == 0) {
              _peopleResult.clear();
            }

            _pagination = _pagination.copyWith(
              totalPages: data.page ?? _pagination.totalPages,
            );

            _peopleResult.addAll(data.results!);

            emit(
              PeopleStates.success(
                PeopleModel(
                  results: _peopleResult,
                  page: _pagination.totalPages,
                ),
                isLoadingMore: false,
              ),
            );
          } else if (_pagination.currentPage == 0) {
            emit(const PeopleStates.emptyInput());
          }
        },
        failure: (error) {
          emit(PeopleStates.error(message: error.toString()));
        },
      );
    } catch (_) {
      emit(PeopleStates.error(message: 'some_error'));
    } finally {
      _pagination = _pagination.copyWith(isLoading: false);
    }
  }

  void resetPeoplePage() {
    _pagination = const PaginationState();
    _peopleResult.clear();
  }
}
