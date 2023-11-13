import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:wallpaper_task/utils/shared.dart';
import 'package:wallpaper_task/view/screens/auth_screens/login_screen.dart';
import 'package:wallpaper_task/view/screens/home_screen/home_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  String verify = '';

  //SIGN UP METHOD
  Future signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(AuthLoading());

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      prefs.setBool('isLogged', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => HomeScreen()));
      emit(AuthSuccessful());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message.toString()));
    }
  }

  //SIGN IN METHOD
  Future signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(AuthLoading());
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      prefs.setBool('isLogged', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => HomeScreen()));
      emit(AuthSuccessful());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message.toString()));
    }
  }

  //SIGN OUT METHOD
  Future signOut({required BuildContext context}) async {
    emit(AuthLoading());
    await _auth.signOut().then((value) {
      prefs.setBool('isLogged', false);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => LoginScreen()));
      emit(AuthSuccessful());
    }).catchError((e) {
      emit(AuthError(e.toString()));
    });

    print('signout');
  }
}
