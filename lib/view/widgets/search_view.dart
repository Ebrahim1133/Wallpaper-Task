import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import 'package:wallpaper_task/utils/constants.dart';
import 'package:wallpaper_task/utils/extensions.dart';
import 'package:wallpaper_task/view/screens/home_screen/home_cubit/home_cubit.dart';

import 'package:wallpaper_task/view/widgets/wallpaper_widget.dart';

class SearchView extends StatefulWidget {
  final String search;

  SearchView({required this.search});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  TextEditingController searchController = new TextEditingController();



  @override
  void initState() {
    HomeCubit.get(context).getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('Wallaper'),automaticallyImplyLeading: false,leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){


        context.navigateToPop();

      },),elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
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
                          HomeCubit.get(context).getSearchWallpaper(searchController.text);
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if(state is HomeSearchSuccessful){
                    return wallPaper2(HomeCubit.get(context).searchPhotos, context,false);
                  }else{
                    return SizedBox();
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}