import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/people/data/models/people_model.dart';
import '../../features/people/data/models/person_details_model.dart';
import 'api_constants.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio,
      {String baseUrl, ParseErrorLogger? errorLogger}) = _ApiService;

  @GET(ApiConstants.peopleEndpoint)
  Future<PeopleModel> getPeople([@Query("page") int? page]);

  @GET(ApiConstants.getPeopleDetails)
  Future<PersonDetailsModel> getPeopleDetails(@Path("person_id") int personId);
}