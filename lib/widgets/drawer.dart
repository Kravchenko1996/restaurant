import 'package:flutter/material.dart';
import 'package:restaurant/pages/all-orders-page.dart';
import 'package:restaurant/pages/home-page.dart';

class BurgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('User'),
            accountEmail: Text('Some text'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                'U',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              child: Text('Closed orders'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllOrdersPage(),
                ));
              },
            ),
          ),
          ListTile(
            title: TextButton(
              child: Text('Active orders'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
