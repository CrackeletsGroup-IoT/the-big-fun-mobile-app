
import 'package:big_fun_app/services/user_service.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController userController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool allFieldsFilled = false;

  // Instancia del servicio
  UserService _userService = UserService();

  @override
  void initState() {
    _userService = UserService(); // Inicialización del servicio
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Color color_background = Colors.white;
    Color color_text_box= Color(0xFF53105C);
    Color color_border_box= Color(0xFF53105C);
    Color color_text = Colors.black;
    Color color_text_button= Colors.white;

    return Scaffold(
      backgroundColor: color_background, // Cambia el color de fondo aquí

      body: SingleChildScrollView(

        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 85), // Espacio entre la imagen y los cuadros de texto

              Image.asset(
                'assets/logo.png', // Asegúrate de poner el nombre correcto de tu imagen
                width: 300, // Ajusta el ancho según tus necesidades
              ),

              SizedBox(height: 20), // Espacio entre la imagen y los cuadros de texto

              Container(
                width: 300,
                child: TextField(

                  controller: userController,   //Asigna el controlador aquí

                  decoration: InputDecoration(
                    labelText: 'UserName',
                    labelStyle: TextStyle(color: color_text_box),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_border_box, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_border_box, width: 2.0),
                    ),
                  ),
                  style: TextStyle(color: color_text),


                  //VALIDA QUE EL CAMPO ESTE LLENO
                  onChanged: (value){
                    setState(() {
                      allFieldsFilled=true;

                      if (userController.text.isEmpty ||
                          nameController.text.isEmpty ||
                          emailController.text.isEmpty||
                          passwordController.text.isEmpty
                      ) {

                        allFieldsFilled = false;
                      }

                    });
                  },

                ),
              ),

              SizedBox(height: 20), // Espacio entre la imagen y los cuadros de texto

              Container(
                width: 300,
                child: TextField(

                  controller: nameController,   //Asigna el controlador aquí

                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: color_text_box),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_border_box, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_border_box, width: 2.0),
                    ),
                  ),
                  style: TextStyle(color: color_text),

                  //VALIDA QUE EL CAMPO ESTE LLENO
                  onChanged: (value){
                    setState(() {
                      allFieldsFilled=true;

                      if (userController.text.isEmpty ||
                          nameController.text.isEmpty ||
                          emailController.text.isEmpty||
                          passwordController.text.isEmpty
                      ) {

                        allFieldsFilled = false;
                      }

                    });
                  },

                ),
              ),

              SizedBox(height: 10), // Espacio entre los cuadros de texto

              Container(
                width: 300,
                child: TextField(

                  controller: emailController,   //Asigna el controlador aquí

                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: color_text_box),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_border_box, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_border_box, width: 2.0),
                    ),
                  ),
                  style: TextStyle(color: color_text),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    RegExp emailRegex = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',);
                    bool isValid = emailRegex.hasMatch(value);
                    if (!isValid) {
                      // Muestra un SnackBar con el mensaje de error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('The email is incorrect'),
                          behavior: SnackBarBehavior.floating, // Mantener el SnackBar visible
                        ),
                      );
                    } else {
                      // Si el correo es válido, cierra el SnackBar
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    }

                    setState(() {
                      allFieldsFilled=true;

                      if (userController.text.isEmpty ||
                          nameController.text.isEmpty ||
                          emailController.text.isEmpty||
                          passwordController.text.isEmpty
                      ) {

                        allFieldsFilled = false;
                      }
                    }

                    );
                  },
                ),
              ),

              SizedBox(height: 10), // Espacio entre los cuadros de texto

              Container(
                width: 300,
                child: TextField(

                  controller: passwordController,   //Asigna el controlador aquí

                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: color_text_box),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_border_box, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_border_box, width: 2.0),
                    ),
                  ),
                  style: TextStyle(color: color_text),
                  obscureText: true, // Para ocultar la contraseña

                  //VALIDA QUE EL CAMPO ESTE LLENO
                  onChanged: (value){
                    setState(() {
                      allFieldsFilled=true;

                      if (userController.text.isEmpty ||
                          nameController.text.isEmpty ||
                          emailController.text.isEmpty||
                          passwordController.text.isEmpty
                      ) {

                        allFieldsFilled = false;
                      }

                    });
                  },

                ),
              ),

              SizedBox(height: 30), // Espacio entre los cuadros de texto y el botón

              Align(
                alignment: Alignment.center,

                child: ElevatedButton(

                  onPressed: allFieldsFilled ? () async {

                    bool attendeeCreated = await _userService.createUser(
                      userController.text,
                      nameController.text,
                      emailController.text,
                      //passwordController.text,
                    );

                    if (attendeeCreated) {
                      // Si el user fue creado correctamente
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Account created successfully'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } : null,

                  style: ElevatedButton.styleFrom(
                    primary: color_border_box,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80), // Ajusta el radio según tus necesidades
                    ),

                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40), // Ajusta el padding del botón

                    //PARA QUE SE HABILITE O DESHABILITE EL BOTON
                    elevation: 2,// Si no todos los campos están llenos, desactiva la elevación
                  ),
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                      color: color_text_button,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

