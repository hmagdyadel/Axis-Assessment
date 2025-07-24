import '../../../../core/networking/api_result.dart';
import '../../data/models/people_model.dart';

abstract class BasePeopleRepository {

  Future<ApiResult<PeopleModel>>  getPeople(int? pageNm);
}