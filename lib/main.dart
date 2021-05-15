import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/SignIn/SignInPage/sign_in_page.dart';

import 'Home/HomePage/home_page.dart';
import 'SignUp/SignUpPage/sign_up_page.dart';
import 'SplashPage/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.purple),
      // home: SignInPage(),

      home: SplashPage(),
      routes: {
        SignInPage.routeName: (context) => SignInPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
