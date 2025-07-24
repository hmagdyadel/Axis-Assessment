import '../../../../core/networking/api_result.dart';
import '../../data/models/people_model.dart';

abstract class PeopleRepository {

  Future<ApiResult<PeopleModel>>  getPeople(int? pageNm);
}