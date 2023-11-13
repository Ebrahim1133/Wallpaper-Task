import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallpaper_task/model/favourite_model.dart';


class DBHelper {
  static const int _version = 1;
  static const String _tableName = 'wallpapers';
  static Database? db;

  static Future<void> initDb() async {
    if (db != null) {
      debugPrint('not null db');
    } else {
      try {
        String path = await getDatabasesPath() + 'favourite.db';
        db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, version) async {
            await db.execute(
              'CREATE TABLE wallpapers(portrait TEXT)',
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }
  static Future<int> deleteAll() async {
    print('deleteAll function called');
    return await db!.delete(_tableName);
  }
  static Future<int> insert(Favourite wallpaper) async {
    print('insert function called');
    print("model:${wallpaper.toJson()!}");
    return await db!.insert(_tableName, wallpaper.toJson());
  }

  static Future<List<Map<String, Object?>>> query() async {
    print('query function called');
    return await db!.query(_tableName);
  }

  static Future<int> delete(Favourite wallpaper) async {
    print('delete function called');
    return await db!.delete(_tableName, where: 'portrait = ?', whereArgs: [wallpaper!.imageUrl]);
  }



}
