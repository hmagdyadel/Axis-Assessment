import 'package:dio/dio.dart';
import 'package:axis_assessment/core/networking/api_result.dart';

import 'package:axis_assessment/features/people/data/models/people_model.dart';
import '../../../../core/networking/api_services.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repository/people_repository.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final ApiService _apiService;

  PeopleRepositoryImpl(this._apiService);

  @override
  Future<ApiResult<PeopleModel>> getPeople(int? pageNum) async {
    try {
      final response = await _apiService.getPeople(pageNum);
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
