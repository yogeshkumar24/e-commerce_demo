import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Home/HomePage/home_page.dart';
import 'package:flutter_app/SignIn/SignInPage/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = "signUpPage";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Form(
        key: formKey,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 50, bottom: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.4,
                padding: const EdgeInsets.all(24.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple),
                      ),
                    ),
                    Spacer(),
                    buildTextFormField(nameController, "Please Enter Your Name",
                        Icon(Icons.account_circle)),
                    Spacer(),
                    buildTextFormField(emailController,
                        "Please Enter Your Email", Icon(Icons.email)),
                    Spacer(),
                    buildTextFormField(passwordController,
                        "Please Enter Your Password", Icon(Icons.lock),
                        isPassword: true),
                    Spacer(),
                    isLoading == true
                        ? Center(child: CircularProgressIndicator())
                        : signUpButton(context),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        SizedBox(
                          width: 6,
                        ),
                        InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, SignInPage.routeName),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Sign In",
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
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
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
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (formKey.currentState.validate()) {
            createUserWithEmailAndPassword(
                emailController.text, passwordController.text);
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Please Enter Value"),
                  );
                });
          }
        },
      ),
    );
  }

  bool isLoading = false;

  Future createUserWithEmailAndPassword(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      isLoading = true;
    });
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((User) {
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

  TextFormField buildTextFormField(
      TextEditingController controller, String hintText, Icon icon,
      {isPassword = false}) {
    return TextFormField(
        controller: controller,
        textInputAction:
            isPassword ? TextInputAction.done : TextInputAction.next,
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )));
  }
}
