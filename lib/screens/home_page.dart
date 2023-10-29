import 'package:big_fun_app/screens/home.dart';
import 'package:big_fun_app/screens/view_all_events.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _selectedIndex=0;

  void _navigationBottonNavBar(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  // different pages to navigate to

  final List<Widget>_children=[
    Home(),
    const ViewAllEvents(),
    // const UserReels(),
    // const UserShop(),
    // const UserAccount(),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigationBottonNavBar,
          type: BottomNavigationBarType.fixed,// Si no le pongo fixed no aparece el BottomNavigationBar
          //backgroundColor: Color(0xFF53105C),
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(icon: Icon(Icons.stadium), label: 'My Events'),
            const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'About Us'),
          ],
        ),
      ),
    );
  }

}
