import 'package:flutter/material.dart';

class SuccessfulPayment extends StatefulWidget {
  const SuccessfulPayment({super.key});

  @override
  State<SuccessfulPayment> createState() => _SuccessfulPaymentState();
}

class _SuccessfulPaymentState extends State<SuccessfulPayment> {


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

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: (AppBar().preferredSize.height/2)),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth, // Ajusta el contenido para que se ajuste horizontalmente
              child: Text('FIESTA DE ULTIMO AÑO', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
             ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, 
                child: Image.network('https://img.freepik.com/foto-gratis/amigos-tintinean-vasos-bebida-bar-moderno_1150-18971.jpg', fit: BoxFit.contain,)
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child:Container(
                width: MediaQuery.of(context).size.width * 0.5, 
                child: Image.network('https://media.istockphoto.com/id/828088276/vector/qr-code-illustration.jpg?s=612x612&w=0&k=20&c=FnA7agr57XpFi081ZT5sEmxhLytMBlK4vzdQxt8A70M=', fit: BoxFit.contain,)
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            createPaddedText('Fecha: 25 de noviembre', 20, MediaQuery.of(context).size.width * 0.05),
            createPaddedText('Lugar: Lugar del evento', 20, MediaQuery.of(context).size.width * 0.05),
            createPaddedText('Descripción: Descripción del evento aquí...', 20, MediaQuery.of(context).size.width * 0.05),
          ],
        ),
        ),
      ), 

    );
  }
}