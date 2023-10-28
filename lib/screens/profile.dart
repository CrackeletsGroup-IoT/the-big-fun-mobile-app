import 'package:big_fun_app/models/attendee.dart';
import 'package:big_fun_app/services/attendee_service.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AttendeeService attendeeService = AttendeeService();
  Attendee? attendee;

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
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.black,),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    attendeeService.getAttendeeById(1).then((data) {
      setState(() {
        attendee = Attendee.fromJson(data);
      });
    }).catchError((error) {
      print('Error al cargar los datos del Attendee: $error');
    });
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
              child: Image.asset('assets/logo.png', height: 80),
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
                  child: Image.asset('assets/logo.png', height: 200, width: 200,),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('User: ${attendee?.userName}', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('Password: *************', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('Name: ${attendee?.name}', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('Email: ${attendee?.email}', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('DNI: 12321312313', 20, MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                TextButton (
                  onPressed:(){
                    print("change view to modify profile");
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: Color.fromARGB(255, 83, 17, 92), width: 1)
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: const BorderSide(color: Colors.white)
                      )
                    ),
                  ), 
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Modificar', style: TextStyle(color: Color.fromARGB(255, 83, 17, 92), fontSize: 20))
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