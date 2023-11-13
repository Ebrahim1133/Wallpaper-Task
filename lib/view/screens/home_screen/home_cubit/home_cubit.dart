import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_task/model/favourite_model.dart';
import 'package:wallpaper_task/utils/constants.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<Favourite> photos = [];
  List<Favourite> searchPhotos = [];
  getTrendingWallpaper(int noOfImageToLoad) async {
    emit(HomeLoading());
    await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad?page=1") ,
        headers: {"Authorization": Constants.API_KEY}).then((value) {




      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);

        Favourite favourite = new Favourite();

        favourite = Favourite.fromMap(element['src']);

        photos.add(favourite);

        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      emit(HomeSuccessful());


    }).catchError((e){
      emit(HomeError(e.toString()));
    });
  }
  getSearchWallpaper(String searchQuery) async {
    emit(HomeSearchLoading());
    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$searchQuery&per_page=30&page=1"),
        headers: {"Authorization":  Constants.API_KEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        Favourite favourite = new Favourite();

        favourite = Favourite.fromMap(element['src']);

        searchPhotos.add(favourite);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });
      emit(HomeSearchSuccessful());


    }).catchError((e){
      emit(HomeSearchError(e.toString()));
    });
  }
}
