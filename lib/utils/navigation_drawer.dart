import 'package:big_fun_app/screens/home_page.dart';
import 'package:big_fun_app/screens/view_all_events.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //BuildHeader(),
              BuildMenuItems(),

            ],
          ),
        ),
      ),
    );
  }
}

class BuildHeader extends StatefulWidget {
  const BuildHeader({super.key});

  @override
  State<BuildHeader> createState() => _BuildHeaderState();
}

class _BuildHeaderState extends State<BuildHeader> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class BuildMenuItems extends StatefulWidget {
  const BuildMenuItems({super.key});

  @override
  State<BuildMenuItems> createState() => _BuildMenuItemsState();
}

class _BuildMenuItemsState extends State<BuildMenuItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title:const Text('Home'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) {
              return const HomePage();
            },)
            );
          },
        ),

        ListTile(
          leading: const Icon(Icons.view_module),
          title:const Text('All Events'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) {
              return const ViewAllEvents();
            },)
            );
          },
        ),




      ],
    );
  }
}
