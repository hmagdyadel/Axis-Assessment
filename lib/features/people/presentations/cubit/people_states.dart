import 'package:freezed_annotation/freezed_annotation.dart';

part 'people_states.freezed.dart';

@Freezed()
class PeopleStates<T> with _$PeopleStates<T> {
  const factory PeopleStates.initial() = _Initial;
  const factory PeopleStates.loading() = LoadingPeopleStates;
  const factory PeopleStates.emptyInput() = EmptyPeopleStates;
  const factory PeopleStates.success(
      T response, {
        @Default(false) bool isLoadingMore,
      }) = SuccessPeopleStates;
  const factory PeopleStates.successPeopleDetails(T data)=SuccessPeopleDetailsStates<T>;
  const factory PeopleStates.error({required String message}) = ErrorPeopleStates;
}