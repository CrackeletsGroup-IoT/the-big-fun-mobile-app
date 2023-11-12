import 'package:big_fun_app/screens/view_all_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {

  Home({super.key,});

  final searchController= TextEditingController();
  final bool obscureText=false;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  toAllEvents(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAllEvents(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 90,
                  child: Image.asset('assets/logo.png'),
                ),
              ),


              GestureDetector(

                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAllEvents(),)),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 1),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black)
                  ),

                  child: const Center(
                    child: Text(
                      "All Events",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller:widget.searchController,
                    obscureText: widget.obscureText,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        //borderRadius: BorderRadius.circular(18),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: Colors.white,//Darle color al interior del textBox
                      filled: true,// Si sepinta o no se pinta el interior del textbox
                      hintText: "Search Events",
                    ),
                  ),
                ),
              )

            ],
          ),

          //SizedBox(height: 10,),
          
          //Text("Popular Events",style: TextStyle(fontSize: 20),),
          
          const Expanded(child: ViewAllEvents())
          





        ],
      ),
    );
  }
}
