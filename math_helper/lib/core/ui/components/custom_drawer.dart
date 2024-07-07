import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_helper/core/strings.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      width: MediaQuery.of(context).size.width * (2 / 3),
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: Center(
            child: Text(
              Strings.appName,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          )),
          ListTile(
            title: Text(
              Strings.drawerItemTitleRecentOperations,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
