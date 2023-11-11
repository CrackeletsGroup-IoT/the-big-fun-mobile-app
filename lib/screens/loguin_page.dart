
import 'package:big_fun_app/screens/home.dart';
import 'package:big_fun_app/screens/home_page.dart';
import 'package:big_fun_app/utils/my_button.dart';
import 'package:big_fun_app/utils/my_textfield.dart';
import 'package:big_fun_app/utils/square_tile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userNameController= TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn(){}
  void signUserUp(){}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(backgroundColor:const Color(0xFF53105C)),

        backgroundColor: Colors.grey,

        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  //const SizedBox(height: 50,), //le da espaciado
/*              const Icon(
                    Icons.lock,
                    size: 100,
                  ),*/
                  const SizedBox(height: 50,),

                  Container(
                      width: 180,
                      //height: 100,
                      child:
                      ClipOval(
                        child: Image.asset('assets/TheBigFun.png'),
                      )
                  ),



                  //CircleAvatar(backgroundImage: Image.asset('lib/images/TheBigFun.png') ,),

                  const SizedBox(height: 50,),


                  //   USER TEXT BOX
                  MyTextField(
                    controller: userNameController,
                    hintText: "User Name",
                    obscureText: false,
                  ),

                  const SizedBox(height: 20,),

                  //   PASSWORD TEXT BOX
                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),

                  const SizedBox(height: 20,),


                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        text: "         Sign In         ",
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),)),
                      ),
/*                  MyButton(
                        text: "     Sign Up     ",
                        onTap: signUserUp,
                      ),*/
                    ],
                  ),



                  const SizedBox(height: 20,),

                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.black38,
                        ),
                      ),

                      Text('   Or continue with   ',style: TextStyle(color: Colors.white),),
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40,),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(imagePath: 'assets/google.png',),

                      SizedBox(width: 30,),

                      SquareTile(imagePath: 'assets/apple.png',)
                    ],
                  ),

                  const SizedBox(height: 40,),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.black),
                      ),

                      SizedBox(width: 5,),

                      Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )


                ],
              ),
            ),
          ),
        ),


      ),
    );
  }

}