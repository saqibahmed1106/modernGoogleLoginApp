import 'package:custom_signin_buttons/button_data.dart';
import 'package:custom_signin_buttons/button_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_google_signin/services/auth_services.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';


class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {

    // show loading circle
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),
      );
    },);

    // try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //   pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch(e){
      //   pop the loading circle
      Navigator.pop(context);
    //   show error message
      showErrorMessage(e.code);
    }
  }

  // error message to user
  void showErrorMessage(String message){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.deepPurple,
        title: Text(
          message,
        style: TextStyle(color: Colors.white),
      ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                //   logo
            
                Icon(
                  Icons.lock,
                  size: 100,
                ),
            
                SizedBox(
                  height: 40,
                ),
            
                //   welcome back,you've been missed
            
                Text(
                  "Welcome back, you\'ve been missed!",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16
                  ),
                ),
            
                SizedBox(
                  height: 20,
                ),
            
                //   Email textfield
            
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                SizedBox(height: 10,),
            
                //   password textfield
            
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 10,),
            
                //   forgot password?
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.grey[600],
            
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
            
                //   sign in button
            
                MyButton(
                  text: "Sign in",
                  onTap: signUserIn,
                ),
            
                SizedBox(height: 30,),
            
                //   or continue with
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
            
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
            
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
            
                SizedBox(height: 30,),
            
                //   google + apple sign in buttons
            
                // google button
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google_logo.png',
                    ),
                    SizedBox(width: 25,),

                    // apple button

                    SquareTile(
                        onTap: (){},
                        imagePath: 'lib/images/apple_3.png',
                    ),

                  ],
                ),
            
                SizedBox(height: 30,),
            
                //   register now or sign up
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
