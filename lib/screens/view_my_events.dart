import 'package:big_fun_app/models/event.dart';
import 'package:big_fun_app/services/organizer_event_service.dart';
import 'package:flutter/material.dart';

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
                        onTap: (){},
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
              FutureBuilder(
                initialData: const [],
                 future: OrganizerEventService.getEvent(),
                 builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                   return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Event event = snapshot.data![index];
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
                                    image: DecorationImage(
                                      image: NetworkImage(event.imageUrl),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.width * 0.5,
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
