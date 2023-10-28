import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  

  Widget createPaddedText(String text, double fontSize, double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
        textAlign: TextAlign.center,
      ),
    );
  }

  PopupMenuItem<int> buildMenuItem(IconData icon, String text, int value) {
    return PopupMenuItem<int>(
      child: Row(
        children: [
          Icon(icon, color: Colors.black,),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
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
                createPaddedText('Profile', 50, MediaQuery.of(context).size.width * 0.05),
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


              ],
            ),
          ),
        ),
      ), 

    );
  }
}