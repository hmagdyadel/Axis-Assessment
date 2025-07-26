import 'package:axis_assessment/core/networking/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/people_model.dart';
import '../../domain/repository/people_repository.dart';
import 'pagination_state.dart';
import 'people_states.dart';

/// Cubit for managing people list state with intelligent pagination.
///
/// Features:
/// - Seamless online/offline experience
/// - Infinite scroll pagination
/// - Network recovery handling
/// - Error management without breaking user experience
///
/// State Flow:
/// initial → loading → success (with pagination) → success/error
class PeopleCubit extends Cubit<PeopleStates> {
  final PeopleRepository _peopleRepository;

  PeopleCubit(this._peopleRepository) : super(const PeopleStates.initial());

  /// Internal list storing all loaded people data
  final List<PersonResult> _peopleResult = [];

  /// Pagination state tracking current page, total pages, and loading status
  PaginationState _pagination = const PaginationState();

  /// Public getter to check if more pages are available for loading
  bool get hasMorePeople => _pagination.hasMore;

  /// Public getter providing read-only access to current people list
  List<PersonResult> get currentPeople => List.unmodifiable(_peopleResult);

  /// Main method for fetching people data with pagination support.
  ///
  /// [isNextPage] true for pagination requests, false for initial/refresh loads
  ///
  /// Behavior:
  /// - Initial load: Shows loading state, clears existing data
  /// - Pagination: Shows loading indicator at bottom, appends new data
  /// - Handles both online/offline scenarios gracefully
  /// - Recovers automatically when network returns
  Future<void> getPeople({bool isNextPage = false}) async {
    if (_shouldSkipRequest(isNextPage)) return;

    try {
      _startLoading(isNextPage);
      final nextPage = _getNextPage(isNextPage);
      final response = await _peopleRepository.getPeople(nextPage);

      response.when(
        success: (data) => _handleSuccess(data, isNextPage),
        failure: (error) => _handleFailure(error.toString(), isNextPage),
      );
    } catch (e) {
      _handleFailure('An unexpected error occurred: $e', isNextPage);
    } finally {
      _pagination = _pagination.copyWith(isLoading: false);
    }
  }

  /// Fetches detailed information for a specific person.
  ///
  /// Emits loading state during fetch and either success or error state based on result.
  /// This is separate from the main people list and doesn't affect pagination.
  Future<void> getPersonDetails({required int personId}) async {
    emit(const PeopleStates.loading());

    final response = await _peopleRepository.getPeopleDetails(personId);

    response.when(
      success: (details) => emit(PeopleStates.successPersonDetails(details)),
      failure: (error) => emit(PeopleStates.error(message: error.message)),
    );
  }

  /// Refreshes the people list by clearing all data and reloading from page 1.
  /// Useful for pull-to-refresh functionality.
  void refresh() {
    resetPeoplePage();
    getPeople();
  }

  /// Resets pagination state and clears all loaded data.
  /// Used internally for refresh operations and initial cleanup.
  void resetPeoplePage() {
    _pagination = const PaginationState();
    _peopleResult.clear();
  }

  // ========== Private Helper Methods ==========

  /// Determines if the current request should be skipped.
  /// Prevents multiple simultaneous requests and respects pagination limits.
  bool _shouldSkipRequest(bool isNextPage) {
    return _pagination.isLoading || (!hasMorePeople && isNextPage);
  }

  /// Starts the loading process and emits appropriate loading states.
  ///
  /// For initial loads: Shows full loading screen and resets data
  /// For pagination: Shows bottom loading indicator and keeps existing data
  void _startLoading(bool isNextPage) {
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
  }

  /// Calculates the next page number to fetch based on current pagination state.
  int _getNextPage(bool isNextPage) {
    return isNextPage ? _pagination.currentPage + 1 : 1;
  }

  /// Handles successful data responses from the repository.
  ///
  /// Processes the data and either updates the people list or handles empty results.
  /// Differentiates between initial loads and pagination requests.
  void _handleSuccess(PeopleModel data, bool isNextPage) {
    final hasResults = data.results?.isNotEmpty ?? false;

    if (hasResults) {
      _updatePeopleData(data, isNextPage);
      _emitSuccessState(data);
    } else {
      _handleEmptyResults(isNextPage);
    }
  }

  /// Updates internal people data and pagination state with new results.
  ///
  /// CRITICAL: Only updates totalPages when we have valid server data with results.
  /// This prevents cached/empty responses from corrupting pagination state,
  /// which is essential for proper network recovery functionality.
  void _updatePeopleData(PeopleModel data, bool isNextPage) {
    if (!isNextPage) {
      _peopleResult.clear();
      _pagination = _pagination.copyWith(currentPage: 1);
    } else {
      _pagination = _pagination.copyWith(
        currentPage: _pagination.currentPage + 1,
      );
    }

    // CRITICAL FIX: Only update totalPages if we get valid server data
    // This prevents cached/empty responses from corrupting pagination state
    if (data.totalPages != null &&
        data.totalPages! > 0 &&
        data.results?.isNotEmpty == true) {
      _pagination = _pagination.copyWith(totalPages: data.totalPages);
    }

    _peopleResult.addAll(data.results ?? []);
  }

  /// Emits success state with updated people data to the UI.
  void _emitSuccessState(PeopleModel data) {
    emit(
      PeopleStates.success(
        PeopleModel(results: List.from(_peopleResult), page: data.page),
        isLoadingMore: false,
      ),
    );
  }

  /// Handles cases where the repository returns empty results.
  ///
  /// For initial loads: Shows "no data" state
  /// For pagination: Stops loading without permanently disabling pagination
  /// (allows retry when network recovers)
  void _handleEmptyResults(bool isNextPage) {
    if (!isNextPage) {
      emit(const PeopleStates.emptyInput());
    } else {
      // Only stop pagination temporarily for empty results
      // Don't update totalPages permanently - this allows retry when network recovers
      emit(
        PeopleStates.success(
          PeopleModel(results: List.from(_peopleResult)),
          isLoadingMore: false,
        ),
      );
    }
  }

  /// Handles repository failures (network errors, API errors, etc.).
  ///
  /// For initial loads: Shows error message to user
  /// For pagination: Fails silently to avoid disrupting user experience
  /// Doesn't permanently break pagination - user can retry later
  void _handleFailure(String errorMessage, bool isNextPage) {
    if (!isNextPage) {
      emit(PeopleStates.error(message: errorMessage));
    } else {
      // For pagination failures, don't permanently stop pagination
      // Just stop this attempt - user can try again later
      emit(
        PeopleStates.success(
          PeopleModel(results: List.from(_peopleResult)),
          isLoadingMore: false,
        ),
      );
    }
  }
}
