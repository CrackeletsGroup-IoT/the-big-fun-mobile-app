import 'package:flutter/material.dart';

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  List<FAQItem> faqList = [
    FAQItem(
      question: "¿Cómo puedo suscribirme a la aplicación? ",
      answer: "Para suscribirte a nuestra aplicación, simplemente debes crear una cuenta en nuestro sitio web y completar el formulario de registro.",
    ),
    FAQItem(
      question: "¿Cómo puedo saber si hay disponibilidad de entradas para un evento?",
      answer: "Si no hay entradas en un evento este se marcará como SOLD OUT en la información del evento y no te dejará realizar la compra.",
    ),
    FAQItem(
      question: "¿Cómo puedo encontrar eventos en mi ciudad?",
      answer: "Puedes buscar eventos por ubicación en nuestra aplicación. Solo ingresa al apartado del mapa y podrás visualizar los eventos cercanos a tu ubicación",
    ),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("FAQs"),
        backgroundColor: Color.fromARGB(255, 83, 17, 92),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: faqList.map((item) {
              return SizedBox(
                width: 300, // Establece el ancho deseado para todos los contenedores.
                child: Container(
                  margin: EdgeInsets.all(8.0), // Margen alrededor del contenedor.
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2, // Ancho del borde.
                      color: Color.fromARGB(255, 83, 17, 92), // Color del borde (en este caso, azul).
                    ),
                    borderRadius: BorderRadius.circular(12.0), // Radio del borde.
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.question,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8, width: 50,),
                      Text(
                        item.answer,
                        style: TextStyle(fontSize: 14),
                      ),
                      // Una línea divisoria entre cada pregunta y respuesta.
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
