import 'package:big_fun_app/models/event.dart';
import 'package:big_fun_app/services/event_service.dart';
import 'package:big_fun_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';


class ViewEventsWithDetail extends StatefulWidget {
  static const name = 'events-with-details-screen';

  final String eventId;

  const ViewEventsWithDetail({
    super.key,
    required this.eventId,
  });

  @override
  State<ViewEventsWithDetail> createState() =>
      _EventsWithDetailsScreenState();
}

class _EventsWithDetailsScreenState extends State<ViewEventsWithDetail> {
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

  @override
  Widget build(BuildContext context) {
    Color colorBackground = const Color(0xFF6363A3);
    Color cardColor = Colors.white;
    Color colorTextTitle = const Color(0xFF035397);
    Color colorText = Colors.black;
    const box = SizedBox(
      height: 30,
    );
    final image = getImageEvent(event?.image ??
        "https://blog.sinapsis.agency/wp-content/uploads/2021/04/DEFINICIONES.-ERROR-404.png");
    final textStyles = TextTheme(
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: colorTextTitle,
        overflow: TextOverflow.ellipsis,
      ),
      titleSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: colorTextTitle,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: colorText,
        overflow: TextOverflow.ellipsis,
      ),
    );

    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text(event?.name ?? 'No data'),
        leading: IconButton(
          onPressed: () {
            context.go('/attendants/events');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  16.0), // Agrega bordes redondeados al card
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: colorBackground,
                    ),
                    child:
                        Hero(tag: widget.eventId, child: Image(image: image)),
                  ),
                  box,
                  const Divider(
                    color: Colors.blue,
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        box,

                        _CustomBoxAttribute(
                          colors: colorBackground,
                          textStyles: textStyles, 
                          title: 'Name', 
                          content: event?.name ?? 'No data'
                        ),
                        
                        box,

                        _CustomBoxAttribute(
                          colors: colorBackground, 
                          textStyles: textStyles, 
                          title: 'District', 
                          content: event?.district ?? 'No data'
                        ),

                        
                        box,
                        
                        _CustomBoxAttribute(
                          colors: colorBackground, 
                          textStyles: textStyles, 
                          title: 'Address', 
                          content: event?.address ?? 'No data'
                        ),
                        
                        box,

                        _CustomBoxAttribute(
                          colors: colorBackground, 
                          textStyles: textStyles, 
                          title: 'Date', 
                          content: DateFormat('yyyy-MM-dd')
                                      .format(event?.date ?? DateTime.now())
                        ),

                        
                        box,

                        _CustomBoxAttribute(
                          colors: colorBackground, 
                          textStyles: textStyles, 
                          title: 'Capacity', 
                          content: (event?.capacity ?? 'No data').toString()
                        ),

                        
                        box,

                        _CustomBoxAttribute(
                          colors: colorBackground, 
                          textStyles: textStyles, 
                          title: 'Cost', 
                          content: (event?.cost ?? 'No data').toString()
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomBoxAttribute extends StatelessWidget {
  const _CustomBoxAttribute({
    required this.colors,
    required this.textStyles,
    required this.title,
    required this.content,
  });

  final Color colors;
  final TextTheme textStyles;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 10),
      child: SizedBox(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colors,
                  overflow: TextOverflow.ellipsis,
                  fontStyle: textStyles.titleLarge!.fontStyle,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                content,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: colors,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
