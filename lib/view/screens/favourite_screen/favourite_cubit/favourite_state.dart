part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}
class FavouriteLoading extends FavouriteState {}
class FavouriteSuccessful extends FavouriteState {}
class FavouriteError extends FavouriteState {
  final String error ;

  FavouriteError(this.error);

}