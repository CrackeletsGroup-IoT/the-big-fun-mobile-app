import 'package:big_fun_app/models/event.dart';
import 'package:flutter/material.dart';

var exampleEvents = [
  Event(
      id: 1,
      name: "Concierto de rock",
      address: "Calle Falsa 123",
      capacity: 1000,
      image: "https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png",
      date: DateTime.parse('2024-07-15 20:00:00Z'),
      cost: 1000,
      district: "San Isidro"
  ),
  Event(
      id: 2,
      name: "Concierto de pop",
      address: "Calle Falsa 123",
      capacity: 1000,
      image: "https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png",
      date: DateTime.parse('2024-07-15 20:00:00Z'),
      cost: 20,
      district: "Miraflores"
  ),
  Event(
      id: 3,
      name: "Partido Liga 1",
      address: "Calle Falsa 123",
      capacity: 1000,
      image: "https://redthread.uoregon.edu/files/original/affd16fd5264cab9197da4cd1a996f820e601ee4.png",
      date: DateTime.parse('2024-07-15 20:00:00Z'),
      cost: 20,
      district: "Callao"
  )
];

class ViewMyEvents extends StatefulWidget {
  const ViewMyEvents({super.key});

  @override
  State<ViewMyEvents> createState() => _ViewMyEventsState();
}

class _ViewMyEventsState extends State<ViewMyEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){print("Hola causa");},
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            color: Color(0xffD6D6EB)
                          ),
                          child: Icon(Icons.add, color: Color(0xff6363A3)),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            child: Text("CREAR EVENTO", style: TextStyle(color: Color(0xff63633A3), letterSpacing: 2,
                              wordSpacing: 2, fontWeight: FontWeight.w700, fontSize: 18)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: exampleEvents.length,
                itemBuilder: (context, index) {
                  Event event = exampleEvents[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff6363A3),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // Imagen del evento
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.width * 0.5,
                              child: Image(
                                image: NetworkImage(event.image),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                "${event.name.toUpperCase()}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  wordSpacing: 4,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${event.date.day}/${event.date.month}/${event.date.year}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(
                                  "${event.district}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,
                                    wordSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: FilledButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.all(8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "Editar",
                                          style: TextStyle(
                                            color: const Color(0xff6363A3),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: FilledButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.all(8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "Invitados",
                                          style: TextStyle(
                                            color: const Color(0xff6363A3),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
