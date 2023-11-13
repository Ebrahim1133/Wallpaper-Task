import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_task/model/favourite_model.dart';

import 'package:wallpaper_task/remote/local/db_helper.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  static FavouriteCubit get(context) => BlocProvider.of(context);

  List<Favourite> favourites = [];

  Future<int> addFavourite( {Favourite? wallpaper}) {
    return DBHelper.insert(wallpaper!);

  }
  Future<int> removeFavourite( {Favourite? wallpaper}) {

    return DBHelper.delete(wallpaper!);
  }
  Future<void> removeAllFavourite( ) async {
    emit(FavouriteLoading());
  await  DBHelper.deleteAll();

    emit(FavouriteSuccessful());
  }
  Future<List<Favourite>> getFavoriteWallpapers() async {
    try{
      emit(FavouriteLoading());
      final List<Map<String, dynamic>> wallpapers = await DBHelper.query();
      favourites.addAll(wallpapers.map((e) => Favourite.fromMap(e)).toList());

      print("favourite :$favourites");
      emit(FavouriteSuccessful());
      return favourites;
    }catch(e){
      emit(FavouriteError(e.toString()));
    }
    return favourites;
  }
}
