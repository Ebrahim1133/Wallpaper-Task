part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccessful extends HomeState {}
class HomeError extends HomeState {
  final String error ;

  HomeError(this.error);

}
class HomeSearchLoading extends HomeState {}
class HomeSearchSuccessful extends HomeState {}
class HomeSearchError extends HomeState {
  final String error ;

  HomeSearchError(this.error);

}