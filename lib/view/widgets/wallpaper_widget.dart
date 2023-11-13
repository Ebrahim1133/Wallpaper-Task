import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_task/model/favourite_model.dart';


import 'package:wallpaper_task/view/widgets/image_view2.dart';


Widget wallPaper2(List<Favourite> listPhotos, BuildContext context,bool isFav ) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: listPhotos.map((Favourite photoModel) {
          return GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageView2(
                            imgPath: photoModel.imageUrl!,
                            photo: photoModel,
                            isFav: isFav,

                          )));
                },
                child: Hero(
                  tag: photoModel.imageUrl??"",
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: kIsWeb
                            ? Image.network(
                          photoModel.imageUrl!,
                          height: 50,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                            : CachedNetworkImage(
                            imageUrl: photoModel.imageUrl!,
                            placeholder: (context, url) => Container(
                              color: Color(0xfff5f8fd),
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
              ));
        }).toList()),
  );
}