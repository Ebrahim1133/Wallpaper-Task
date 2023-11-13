import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_task/utils/auth_validation/validition.dart';

import 'package:wallpaper_task/view/screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:wallpaper_task/view/screens/auth_screens/login_screen.dart';

// ignore: must_be_immutable
class RegsiterScreen extends StatelessWidget {
  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController lastNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xfff6f6f6),

          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black,),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => LoginScreen()));
                        },),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: 690,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lets Get Started!',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1c1c1c)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Create an account to Q Allure to get all features',
                          style: TextStyle(fontSize: 15, color: Color(
                              0xff8b8b8b)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 375,
                          child: TextFormField(
                            controller: firstNamecontroller,
                            validator: (val)=>validateName(val!),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              prefixIcon: Icon(Icons.person),
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
                            controller: lastNamecontroller,
                            validator: (val)=>validateName(val!),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              prefixIcon: Icon(Icons.person),
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
                        ), SizedBox(
                          width: 375,
                          child: TextFormField(
                            controller: emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val)=>validateEmail(val!),
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
                        ), SizedBox(
                          width: 375,
                          child: TextFormField(
                            controller: phonecontroller,
                            keyboardType: TextInputType.phone,
                            validator: (val)=>validateMobile(val!),
                            decoration: InputDecoration(
                              hintText: 'Phone',
                              prefixIcon: Icon(Icons.phone),
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
                        ), SizedBox(
                          width: 375,
                          child: TextFormField(
                            controller: passwordcontroller,
                            validator: (val)=>validatePassword(val!),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
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
                          height: 50,
                        ),
                        Container(
                          height: 60,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Color(0xff0051ce),
                              borderRadius: BorderRadius.circular(35)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: MaterialButton(
                              minWidth: 250,
                              onPressed:() async{
                                if(formKey.currentState!.validate()){
                                  await  AuthCubit.get(context).signUp(email: emailcontroller.text, password: passwordcontroller.text,context: context);
                                }



                              },
                              child: Text(
                                'CREATE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height:25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => LoginScreen()));
                              },
                              child: Text('Login Here'),
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