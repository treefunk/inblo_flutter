import 'package:flutter/material.dart';

class SideNavigationDrawer extends StatelessWidget {
  const SideNavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text("Test"),
          automaticallyImplyLeading: false,
          actions: [Container()],
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('test'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('test'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('test'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('test'),
          onTap: () {},
        ),
      ]),
    );
  }
}
