import 'package:big_fun_app/screens/faq.dart';
import 'package:big_fun_app/screens/home.dart';
import 'package:big_fun_app/screens/view_all_events.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {

    final List<Widget> _children=[
      Home(),
      const ViewAllEvents(),
      const Faq()
      // const UserShop(),
      // const UserAccount(),
    ];

    int _selectedIndex=0;

    void _navigationBottonNavBar(int index){
      setState(() {
        _selectedIndex=index;
      });
    }

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _navigationBottonNavBar,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.stadium), label: 'My Events'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'FAQ'),
      ],
    );
  }
}
