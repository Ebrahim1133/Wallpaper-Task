import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_task/model/favourite_model.dart';

import 'package:wallpaper_task/view/screens/favourite_screen/favourite_cubit/favourite_cubit.dart';
//import 'dart:js' as js;

class ImageView2 extends StatefulWidget {
  final String imgPath;
  final Favourite? photo;
  final bool isFav ;

  ImageView2({required this.imgPath, required this.photo,this.isFav =false});

  @override
  _ImageView2State createState() => _ImageView2State();
}

class _ImageView2State extends State<ImageView2> {
  bool isFavourite = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgPath,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: kIsWeb
                  ? Image.network(widget.imgPath, fit: BoxFit.cover)
                  : CachedNetworkImage(
                      imageUrl: widget.imgPath,
                      placeholder: (context, url) => Container(
                        color: Color(0xfff5f8fd),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          widget.isFav == true || FavouriteCubit.get(context).favourites.any((element) => element.imageUrl == widget.imgPath)?SizedBox():
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () async {


                      await FavouriteCubit.get(context)
                          .addFavourite(wallpaper: widget.photo!);
                      setState(() {
                        isFavourite = !isFavourite;
                      });
                      //Navigator.pop(context);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 8,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xffffff),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 8,
                          height: 50,
                          alignment: Alignment.center,
                          child: Icon(
                            isFavourite == true
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: Colors.red,
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
