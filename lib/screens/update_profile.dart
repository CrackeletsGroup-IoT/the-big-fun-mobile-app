
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}


class _UpdateProfileState extends State<UpdateProfile>{
  Widget createPaddedText(String text, double fontSize, double horizontalPadding){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }

  PopupMenuItem<int> buildMenuItem(IconData icon, String text, int value){
    return PopupMenuItem<int>(
      child: Row(children: [
        Icon(icon, color: Colors.black),
        SizedBox(width: 12),
        Text(text),
      ]),
      value: value,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Alinea los elementos al extremo derecho del AppBar
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight, // Alinea la imagen a la derecha
              child: Image.asset('assets/images/logo.png', height: 80),
            ),
          ],
        ),
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 83, 17, 92),

      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: (AppBar().preferredSize.height/2)),
            child: Column(
              children: [
                createPaddedText('Update profile', 50, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('assets/images/logo.png', height: 200, width: 200,),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('User: ___________________', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('Password: ________________', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('Name: ____________________', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('Email: _________________', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('DNI: ___________________', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                TextButton (
                  onPressed:(){Center(child: Text('GuardarDatos'));},
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Guardar datos', style: TextStyle(color: Colors.white, fontSize: 20))),
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 83, 17, 92),
                    backgroundColor: Color.fromARGB(255, 83, 17, 92),

                  ),
                ),


              ],
            ),
          ),
        ),
      ),

    );
  }
}