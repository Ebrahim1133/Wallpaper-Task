import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_task/model/favourite_model.dart';

import 'package:wallpaper_task/utils/extensions.dart';
import 'package:wallpaper_task/view/screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:wallpaper_task/view/screens/favourite_screen/favourite_cubit/favourite_cubit.dart';
import 'package:wallpaper_task/view/screens/favourite_screen/favourite_screen.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_task/view/screens/home_screen/home_cubit/home_cubit.dart';

import 'dart:convert';

import 'package:wallpaper_task/view/widgets/search_view.dart';
import 'package:wallpaper_task/view/widgets/wallpaper_widget.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int noOfImageToLoad = 10;

  List<Favourite> photos = [];

  getTrendingWallpaper() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad?page=1"),
        headers: {
          "Authorization": '563492ad6f91700001000001c30b0be49d5546f6bc3dc35a0bfa5c64'
        }).then((value) {
      print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);

      jsonData["photos"].forEach((element) {
        //print(element);

        Favourite favourite = new Favourite();

        favourite = Favourite.fromMap(element['src']);

        photos.add(favourite);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });
      setState(() {

      });

    });
  }

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {

    getTrendingWallpaper();
    FavouriteCubit.get(context).getFavoriteWallpapers();

    super.initState();


    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {

        noOfImageToLoad = noOfImageToLoad + 10;

     getTrendingWallpaper();

      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,title: Text('Wallapers'),elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),),
      body:SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(

            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: "search wallpapers",
                              border: InputBorder.none),
                        )),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchView(
                                      search: searchController.text,
                                    )));
                          }
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),

              wallPaper2(photos, context,false),
              SizedBox(
                height: 24,
              ),

            ],
          ),
        ),
      ),

      drawer: Drawer(
        backgroundColor: Colors.white,

        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36,horizontal: 8),
          child: ListView(
            padding: EdgeInsets.zero,

            children: [
              DrawerHeader(
                decoration:  BoxDecoration(
                  color:Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black,
                          width: 1
                      )
                  )
                ),
                child: Center(
                    child: Icon(Icons.account_circle_outlined,size: 50,color: Color(0xff9fcdfc))
                ),
              ),
              ListTile(
                leading: Icon(Icons.favorite_border_outlined,color:  Color(0xff9fcdfc)),
                shape: Border(
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 1
                    )
                ),
                title:  Text('Favorite',style:TextStyle(color: Colors.black) ),
                onTap: () {
                  context.navigateToPop();
                  context.navigateToPush(FavoriteScreen());

                },
              ),
              ListTile(
                leading: Icon(Icons.logout,color:  Colors.red),
                shape: Border(
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 1
                    )
                ),
                title:  Text('Log Out',style:TextStyle(color: Colors.black) ),
                onTap: () {
                   showDialog(context: context, builder: (context)=>AlertDialog(
                     title: Text('Are you sure log out ?'),
                     alignment: Alignment.center,
                     actionsAlignment:  MainAxisAlignment.center,
                     actions: [
                       Container(
                         height: 50,
                         width: 100,
                         decoration: BoxDecoration(
                             color: Colors.red,
                             borderRadius: BorderRadius.circular(10)),
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(10),
                           child: MaterialButton(
                             minWidth: 70,
                             onPressed: () async{
                               await  AuthCubit.get(context).signOut(context: context);
                               // context.navigateToPop();
                             },
                             child: Text(
                               'Log Out',
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold),
                             ),
                           ),
                         ),
                       ),
                       Container(
                         height: 50,
                         width: 100,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             border: Border.all(color: Colors.red),
                             borderRadius: BorderRadius.circular(10)),
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(10),
                           child: MaterialButton(
                             minWidth: 70,
                             onPressed: () async{
                               context.navigateToPop();

                             },
                             child: Text(
                               'Cancal',
                               style: TextStyle(
                                   color: Colors.red,
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold),
                             ),
                           ),
                         ),
                       ),
                     ],
                   ));

                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
