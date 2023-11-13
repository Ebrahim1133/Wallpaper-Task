import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_task/utils/auth_validation/validition.dart';
import 'package:wallpaper_task/view/screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:wallpaper_task/view/screens/auth_screens/regsiter_screen.dart';



// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: 700,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        Text(
                          'Welcome back!',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1c1c1c)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Log in to your existant account of Q Allure',
                          style: TextStyle(
                              fontSize: 15, color: Color(0xff8b8b8b)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 375,
                          child: TextFormField(
                            controller: emailcontroller,
                            validator: (val)=>validateEmail(val!),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email Address',

                              prefixIcon: Icon(Icons.email),
                              hintStyle: TextStyle(color: Color(0xff1848fd)),
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(
                                      color: Color(0xff9fcdfc), width: 2)),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 375,
                          child: TextFormField(
                            controller: passwordcontroller,
                            validator: (val)=>validate(val!),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              hintStyle: TextStyle(color: Color(0xff1848fd)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: BorderSide(
                                      color: Color(0xff9fcdfc), width: 2)),
                            ),
                          ),
                        ),
                        // Container(
                        //   alignment: Alignment.bottomRight,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(right: 5.0),
                        //     child: TextButton(
                        //       child: Text(
                        //         'Forget password ?',
                        //         style: TextStyle(
                        //             color: Color('0xff304a59'),
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //       onPressed: () {},
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Color(0xff0148a4),
                              borderRadius: BorderRadius.circular(35)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: MaterialButton(
                              minWidth: 250,
                              onPressed: () async{
                                if(formKey.currentState!.validate()){
                                  await  AuthCubit.get(context).signIn(email: emailcontroller.text, password: passwordcontroller.text,context: context);
                                }


                              },
                              child: Text(
                                'LOG IN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dont have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => RegsiterScreen()));
                              },
                              child: Text('Register Here'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}