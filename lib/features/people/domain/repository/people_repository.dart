import '../../../../core/networking/api_result.dart';
import '../../data/models/people_model.dart';
import '../../data/models/person_details_model.dart';

abstract class PeopleRepository {

  Future<ApiResult<PeopleModel>>  getPeople(int? pageNm);
  Future<ApiResult<PersonDetailsModel>>  getPeopleDetails(int? personId);
}