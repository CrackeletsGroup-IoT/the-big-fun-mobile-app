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
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Color colorBackground = const Color.fromARGB(255, 99, 99, 163);
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQs"),
        backgroundColor: const Color.fromARGB(255, 99, 99, 163),
        centerTitle: true,
      ),
      body: Container(
        color: colorBackground,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: faqList.map((item) {
                return SizedBox(
                  width: 300,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Fondo blanco del Container
                      border: Border.all(
                        width: 2,
                        color: const Color.fromARGB(255, 250, 250, 250),
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.question,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8, width: 50,),
                        Text(
                          item.answer,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}