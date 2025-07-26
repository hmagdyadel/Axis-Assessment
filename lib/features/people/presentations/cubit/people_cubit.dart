import 'package:axis_assessment/core/networking/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;

import '../../data/models/people_model.dart';
import '../../domain/repository/people_repository.dart';
import 'pagination_state.dart';
import 'people_states.dart';

class PeopleCubit extends Cubit<PeopleStates> {
  final PeopleRepository _peopleRepository;

  PeopleCubit(this._peopleRepository) : super(const PeopleStates.initial());

  // Private state variables
  final List<PersonResult> _peopleResult = [];
  PaginationState _pagination = const PaginationState();

  // Public getters for external access
  bool get hasMorePeople => _pagination.hasMore;

  List<PersonResult> get currentPeople => List.unmodifiable(_peopleResult);

  //isNextPage true for pagination, false for initial/refresh
  Future<void> getPeople({bool isNextPage = false}) async {
    if (_pagination.isLoading || (!hasMorePeople && isNextPage)) return;

    try {
      _pagination = _pagination.copyWith(isLoading: true);

      if (!isNextPage) {
        resetPeoplePage();
        emit(const PeopleStates.loading());
      } else {
        emit(
          PeopleStates.success(
            PeopleModel(results: _peopleResult),
            isLoadingMore: true,
          ),
        );
      }

      final nextPage = isNextPage ? _pagination.currentPage + 1 : 1;

      final response = await _peopleRepository.getPeople(nextPage);

      await response.when(
        success: (data) async {
          if (data.results != null && (data.results?.isNotEmpty ?? false)) {
            if (!isNextPage) {
              _peopleResult.clear();
              _pagination = _pagination.copyWith(currentPage: 1);
            } else {
              _pagination = _pagination.copyWith(
                currentPage: _pagination.currentPage + 1,
              );
            }

            final estimatedTotalPages = data.totalPages;

            _pagination = _pagination.copyWith(totalPages: estimatedTotalPages);

            _peopleResult.addAll(data.results ?? []);

            emit(
              PeopleStates.success(
                PeopleModel(results: List.from(_peopleResult), page: data.page),
                isLoadingMore: false,
              ),
            );
          } else if (!isNextPage) {
            emit(const PeopleStates.emptyInput());
          }
        },
        failure: (error) {
          emit(PeopleStates.error(message: error.toString()));
        },
      );
    } catch (e) {
      emit(PeopleStates.error(message: 'An unexpected error occurred: $e'));
    } finally {
      _pagination = _pagination.copyWith(isLoading: false);
    }
  }

  //  function for getting person details
  Future<void> getPersonDetails({required int personId}) async {
    try {
      emit(const PeopleStates.loading());

      final response = await _peopleRepository.getPeopleDetails(personId);

      response.when(
        success: (personDetails) async {
          emit(PeopleStates.successPersonDetails(personDetails));
        },
        failure: (error) {
          emit(PeopleStates.error(message: error.message));
        },
      );
    } catch (e) {
      emit(PeopleStates.error(message: 'Failed to load person details: $e'));
    }
  }



  void resetPeoplePage() {
    _pagination = const PaginationState();
    _peopleResult.clear();
  }

  void refresh() {
    resetPeoplePage();
    getPeople();
  }
}
