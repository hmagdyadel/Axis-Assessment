// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'people_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeopleStates<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeopleStates<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PeopleStates<$T>()';
}


}

/// @nodoc
class $PeopleStatesCopyWith<T,$Res>  {
$PeopleStatesCopyWith(PeopleStates<T> _, $Res Function(PeopleStates<T>) __);
}


/// Adds pattern-matching-related methods to [PeopleStates].
extension PeopleStatesPatterns<T> on PeopleStates<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial<T> value)?  initial,TResult Function( LoadingPeopleStates<T> value)?  loading,TResult Function( EmptyPeopleStates<T> value)?  emptyInput,TResult Function( SuccessPeopleStates<T> value)?  success,TResult Function( ErrorPeopleStates<T> value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case LoadingPeopleStates() when loading != null:
return loading(_that);case EmptyPeopleStates() when emptyInput != null:
return emptyInput(_that);case SuccessPeopleStates() when success != null:
return success(_that);case ErrorPeopleStates() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial<T> value)  initial,required TResult Function( LoadingPeopleStates<T> value)  loading,required TResult Function( EmptyPeopleStates<T> value)  emptyInput,required TResult Function( SuccessPeopleStates<T> value)  success,required TResult Function( ErrorPeopleStates<T> value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case LoadingPeopleStates():
return loading(_that);case EmptyPeopleStates():
return emptyInput(_that);case SuccessPeopleStates():
return success(_that);case ErrorPeopleStates():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial<T> value)?  initial,TResult? Function( LoadingPeopleStates<T> value)?  loading,TResult? Function( EmptyPeopleStates<T> value)?  emptyInput,TResult? Function( SuccessPeopleStates<T> value)?  success,TResult? Function( ErrorPeopleStates<T> value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case LoadingPeopleStates() when loading != null:
return loading(_that);case EmptyPeopleStates() when emptyInput != null:
return emptyInput(_that);case SuccessPeopleStates() when success != null:
return success(_that);case ErrorPeopleStates() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  emptyInput,TResult Function( T response,  bool isLoadingMore)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case LoadingPeopleStates() when loading != null:
return loading();case EmptyPeopleStates() when emptyInput != null:
return emptyInput();case SuccessPeopleStates() when success != null:
return success(_that.response,_that.isLoadingMore);case ErrorPeopleStates() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  emptyInput,required TResult Function( T response,  bool isLoadingMore)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case LoadingPeopleStates():
return loading();case EmptyPeopleStates():
return emptyInput();case SuccessPeopleStates():
return success(_that.response,_that.isLoadingMore);case ErrorPeopleStates():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  emptyInput,TResult? Function( T response,  bool isLoadingMore)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case LoadingPeopleStates() when loading != null:
return loading();case EmptyPeopleStates() when emptyInput != null:
return emptyInput();case SuccessPeopleStates() when success != null:
return success(_that.response,_that.isLoadingMore);case ErrorPeopleStates() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial<T> implements PeopleStates<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PeopleStates<$T>.initial()';
}


}




/// @nodoc


class LoadingPeopleStates<T> implements PeopleStates<T> {
  const LoadingPeopleStates();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingPeopleStates<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PeopleStates<$T>.loading()';
}


}




/// @nodoc


class EmptyPeopleStates<T> implements PeopleStates<T> {
  const EmptyPeopleStates();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmptyPeopleStates<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PeopleStates<$T>.emptyInput()';
}


}




/// @nodoc


class SuccessPeopleStates<T> implements PeopleStates<T> {
  const SuccessPeopleStates(this.response, {this.isLoadingMore = false});
  

 final  T response;
@JsonKey() final  bool isLoadingMore;

/// Create a copy of PeopleStates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessPeopleStatesCopyWith<T, SuccessPeopleStates<T>> get copyWith => _$SuccessPeopleStatesCopyWithImpl<T, SuccessPeopleStates<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessPeopleStates<T>&&const DeepCollectionEquality().equals(other.response, response)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(response),isLoadingMore);

@override
String toString() {
  return 'PeopleStates<$T>.success(response: $response, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $SuccessPeopleStatesCopyWith<T,$Res> implements $PeopleStatesCopyWith<T, $Res> {
  factory $SuccessPeopleStatesCopyWith(SuccessPeopleStates<T> value, $Res Function(SuccessPeopleStates<T>) _then) = _$SuccessPeopleStatesCopyWithImpl;
@useResult
$Res call({
 T response, bool isLoadingMore
});




}
/// @nodoc
class _$SuccessPeopleStatesCopyWithImpl<T,$Res>
    implements $SuccessPeopleStatesCopyWith<T, $Res> {
  _$SuccessPeopleStatesCopyWithImpl(this._self, this._then);

  final SuccessPeopleStates<T> _self;
  final $Res Function(SuccessPeopleStates<T>) _then;

/// Create a copy of PeopleStates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = freezed,Object? isLoadingMore = null,}) {
  return _then(SuccessPeopleStates<T>(
freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as T,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ErrorPeopleStates<T> implements PeopleStates<T> {
  const ErrorPeopleStates({required this.message});
  

 final  String message;

/// Create a copy of PeopleStates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorPeopleStatesCopyWith<T, ErrorPeopleStates<T>> get copyWith => _$ErrorPeopleStatesCopyWithImpl<T, ErrorPeopleStates<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorPeopleStates<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PeopleStates<$T>.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorPeopleStatesCopyWith<T,$Res> implements $PeopleStatesCopyWith<T, $Res> {
  factory $ErrorPeopleStatesCopyWith(ErrorPeopleStates<T> value, $Res Function(ErrorPeopleStates<T>) _then) = _$ErrorPeopleStatesCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorPeopleStatesCopyWithImpl<T,$Res>
    implements $ErrorPeopleStatesCopyWith<T, $Res> {
  _$ErrorPeopleStatesCopyWithImpl(this._self, this._then);

  final ErrorPeopleStates<T> _self;
  final $Res Function(ErrorPeopleStates<T>) _then;

/// Create a copy of PeopleStates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorPeopleStates<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
