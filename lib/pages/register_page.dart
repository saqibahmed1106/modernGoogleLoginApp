import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_google_signin/services/auth_services.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user up method
  void signUserUp() async {

    // show loading circle
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),
      );
    },);

    // try creating the user
    try{
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
      //   show error message, password don't match
        showErrorMessage("Password don't match!");
      }
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
                  size: 50,
                ),

                SizedBox(
                  height: 40,
                ),

                //   Let's create an account for you!

                Text(
                  "Let\'s create an account for you!",
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

                //  confirm password textfield

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                SizedBox(height: 20,),

                //   sign up button

                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
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

                SizedBox(height: 20,),

                //   google + apple sign in buttons

                // google button

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google_logo.png'
                    ),
                    SizedBox(width: 25,),

                    // apple button

                    SquareTile(
                      onTap: (){},
                        imagePath: 'lib/images/apple_3.png'
                    ),

                  ],
                ),

                SizedBox(height: 20,),

                //   register now or sign up

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
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


