import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_task/model/favourite_model.dart';

import 'package:wallpaper_task/view/screens/favourite_screen/favourite_cubit/favourite_cubit.dart';
import 'package:wallpaper_task/view/widgets/wallpaper_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(FavouriteCubit.get(context).favourites.isNotEmpty){
      FavouriteCubit.get(context).favourites.clear();
    }
    FavouriteCubit.get(context)
        .getFavoriteWallpapers();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wallapers'),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      body: Column(
        children: [


          SizedBox(
            height: 16,
          ),
          BlocConsumer<FavouriteCubit, FavouriteState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is FavouriteSuccessful ) {
                if(FavouriteCubit.get(context).favourites.isEmpty){
                  return Center(
                    child: Text('Favourites is Empty'),
                  );
                }
                return Column(

                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      margin: EdgeInsets.all(14),
                      decoration: BoxDecoration(border: Border.all(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                      child: TextButton(child: Text('Clear All',style: TextStyle(color: Colors.red),),onPressed: () async {
                        await FavouriteCubit.get(context).removeAllFavourite();
                         FavouriteCubit.get(context).favourites.clear();
                      },),
                    ),
                    wallPaper2(FavouriteCubit.get(context).favourites, context,true),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
