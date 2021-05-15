import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Home/HomePage/home_page.dart';
import 'package:flutter_app/SignUp/SignUpPage/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  static String routeName = "signInPage";

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 50, bottom: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.8,
              padding: const EdgeInsets.all(24.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.purple),
                    ),
                  ),
                  Spacer(),
                  buildTextFormField(emailController, "Please Enter Your Email",
                      Icon(Icons.email)),
                  Spacer(),
                  buildTextFormField(passwordController,
                      "Please Enter Password", Icon(Icons.lock),
                      isPassword: true),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () {
                      Flushbar(
                        message: "Not Implemented",
                        duration: Duration(seconds: 2),
                      ).show(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password",
                          style: TextStyle(color: Colors.purple),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : signInButton(),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(
                        width: 6,
                      ),
                      InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, SignUpPage.routeName),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.purple),
                            ),
                          )),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signInButton() {
    return Container(
      width: 160,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.purple,
      ),
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        child: Text(
          "Sign In",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () {
          signInWithEmailAndPassword(
              emailController.text, passwordController.text);
        },
      ),
    );
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      isLoading = true;
    });

    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((result) {
      setState(() {
        isLoading = false;
      });
      Navigator.popAndPushNamed(context, HomePage.routeName);
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  Widget buildTextFormField(
      TextEditingController controller, String hintText, Icon icon,
      {bool isPassword = false, Icon passIcon}) {
    return TextFormField(
        validator: (value) {
          if (value.isNotEmpty) {
            return "Please enter value";
          } else {
            return null;
          }
        },
        textInputAction:
            isPassword ? TextInputAction.done : TextInputAction.next,
        controller: controller,
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
            prefixIcon: icon,
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isPassword = false;
                      });
                    },
                    child: Icon(Icons.visibility))
                : null,
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )));
  }
}
