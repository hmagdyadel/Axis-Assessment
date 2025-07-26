import 'package:dio/dio.dart';

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_services.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/hive_service.dart';
import '../../../../core/services/network_connection_service.dart';
import '../../domain/repository/people_repository.dart';
import '../models/people_model.dart';
import '../models/person_details_model.dart';

/// Repository implementation for handling people data with offline-first approach.
///
/// This class manages data fetching with the following strategy:
/// - Online: Fetch from API and cache the data
/// - Offline: Use cached data when available
/// - Network Recovery: Automatically switch back to API when connection returns
class PeopleRepositoryImpl implements PeopleRepository {
  final ApiService _apiService;

  PeopleRepositoryImpl(this._apiService);

  /// Fetches people data with intelligent offline/online handling.
  ///
  /// Behavior:
  /// - Online: Tries API first, caches successful responses, falls back to cache on API errors
  /// - Offline: Returns cached data if available, empty response if not (for silent pagination stop)
  /// - Network Recovery: Automatically uses API when connection returns
  ///
  /// [pageNum] The page number to fetch (defaults to 1)
  /// Returns [ApiResult<PeopleModel>] with success/failure status
  @override
  Future<ApiResult<PeopleModel>> getPeople(int? pageNum) async {
    final page = pageNum ?? 1;

    try {
      if (_isNetworkAvailable()) {
        return await _fetchFromApi(page);
      } else {
        return _handleOfflineData(page);
      }
    } catch (error) {
      return _handleFallbackData(page);
    }
  }

  /// Checks if network connection is available for API calls
  bool _isNetworkAvailable() {
    return NetworkConnectivityService.instance.isConnected;
  }

  /// Fetches data from API and caches it for offline use.
  ///
  /// On API errors (except 401), tries to return cached data as fallback.
  /// This ensures users get data even when API is temporarily unavailable.
  Future<ApiResult<PeopleModel>> _fetchFromApi(int page) async {
    try {
      final response = await _apiService.getPeople(page);
      await HiveService.instance.savePeopleData(page, response);
      return ApiResult.success(response);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return ApiResult.failure(
          Failure(
            "Unauthorized: Invalid API key",
            statusCode: e.response?.statusCode,
          ),
        );
      }

      // Try cache as fallback for API errors
      return _handleFallbackData(page);
    }
  }

  /// Handles data retrieval when device is offline.
  ///
  /// Returns cached data if available, otherwise returns empty response.
  /// Empty responses allow pagination to stop gracefully without showing errors.
  ApiResult<PeopleModel> _handleOfflineData(int page) {
    final cachedData = HiveService.instance.getPeopleData(page);

    if (cachedData != null) {
      return ApiResult.success(cachedData);
    } else {
      // For offline mode, return empty response to stop pagination silently
      return ApiResult.success(_createEmptyResponse(page));
    }
  }

  /// Fallback data handling for API errors when online.
  ///
  /// Returns cached data if available, otherwise returns failure.
  /// Failures allow the cubit to handle errors appropriately without
  /// permanently breaking pagination (unlike empty responses).
  ApiResult<PeopleModel> _handleFallbackData(int page) {
    final cachedData = HiveService.instance.getPeopleData(page);

    if (cachedData != null) {
      return ApiResult.success(cachedData);
    } else {
      // When online but API fails and no cache, return failure
      // This allows the cubit to handle it properly without stopping pagination permanently
      return ApiResult.failure(
        Failure("API error and no cached data available for page $page"),
      );
    }
  }

  /// Creates an empty response for missing cached data during offline mode.
  ///
  /// Sets totalPages to current page - 1 to signal "no more pages available".
  /// This makes pagination stop gracefully without showing error messages.
  PeopleModel _createEmptyResponse(int page) {
    return PeopleModel(
      page: page,
      results: [],
      totalResults: 0,
      totalPages: page > 1 ? page - 1 : 1,
    );
  }

  /// Fetches detailed information for a specific person.
  ///
  /// Unlike getPeople, this doesn't implement offline caching since
  /// person details are typically viewed once and don't need pagination.
  @override
  Future<ApiResult<PersonDetailsModel>> getPeopleDetails(int? personId) async {
    try {
      final response = await _apiService.getPeopleDetails(personId ?? 0);
      return ApiResult.success(response);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 401) {
        return ApiResult.failure(
          Failure("Unauthorized: Invalid API key", statusCode: statusCode),
        );
      } else {
        return ApiResult.failure(
          Failure("Unexpected error: ${e.message}", statusCode: statusCode),
        );
      }
    } catch (error) {
      return ApiResult.failure(Failure("Unknown error occurred: $error"));
    }
  }
}
