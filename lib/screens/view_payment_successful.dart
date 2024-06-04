import 'package:big_fun_app/models/event.dart';
import 'package:big_fun_app/screens/home.dart';
import 'package:big_fun_app/services/event_service.dart';
import 'package:big_fun_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewPaymentSuccessful extends StatefulWidget {
  final String eventId;

  const ViewPaymentSuccessful({
    super.key,
    required this.eventId,
  });

  static const name = 'payment-successfull-screen';

  @override
  State<ViewPaymentSuccessful> createState() =>
      _ViewPaymentSuccessfulState();
}

class _ViewPaymentSuccessfulState extends State<ViewPaymentSuccessful> {
  EventService? _eventService;
  Event? event;

  @override
  void initState() {
    _eventService = EventService();
    initialize();
    super.initState();
  }

  Future initialize() async {
    event = await _eventService!.getById(widget.eventId);
    setState(() {
      event = event;
    });
  }

  Widget createPaddedText(
      String text, double fontSize, double horizontalPadding) {
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
    final image = getImageEvent(event?.imageUrl ??
        "https://blog.sinapsis.agency/wp-content/uploads/2021/04/DEFINICIONES.-ERROR-404.png");

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: (AppBar().preferredSize.height / 2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit
                      .fitWidth, // Ajusta el contenido para que se ajuste horizontalmente
                  child: Text('${event?.name}',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image(
                        image: image,
                        fit: BoxFit.contain,
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.network(
                        'https://media.istockphoto.com/id/828088276/vector/qr-code-illustration.jpg?s=612x612&w=0&k=20&c=FnA7agr57XpFi081ZT5sEmxhLytMBlK4vzdQxt8A70M=',
                        fit: BoxFit.contain,
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('Date: ${DateFormat('yyyy-MM-dd').format(event?.date ?? DateTime.now())}', 20,
                    MediaQuery.of(context).size.width * 0.05),
                createPaddedText('Place: ${event?.address} - ${event?.district}', 20,
                    MediaQuery.of(context).size.width * 0.05),
                createPaddedText('Capacity: ${event?.capacity}', 20,
                    MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                createPaddedText('¡Gracias por tu compra!', 30,
                    MediaQuery.of(context).size.width * 0.05),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                FilledButton.tonalIcon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text('Finish', style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF6363A3)),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
