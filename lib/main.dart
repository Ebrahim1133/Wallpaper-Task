import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_task/remote/local/db_helper.dart';
import 'package:wallpaper_task/remote/network/dio_helper.dart';
import 'package:wallpaper_task/utils/bloc_observer.dart';
import 'package:wallpaper_task/utils/shared.dart';
import 'package:wallpaper_task/view/screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:wallpaper_task/view/screens/auth_screens/login_screen.dart';
import 'package:wallpaper_task/view/screens/favourite_screen/favourite_cubit/favourite_cubit.dart';
import 'package:wallpaper_task/view/screens/home_screen/home_cubit/home_cubit.dart';
import 'package:wallpaper_task/view/screens/home_screen/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await startShared();
  await DBHelper.initDb();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<FavouriteCubit>(
          create: (context) => FavouriteCubit(),
        ),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home:prefs.getBool('isLogged')==true?HomeScreen(): LoginScreen(),
      ),
    );
  }
}

