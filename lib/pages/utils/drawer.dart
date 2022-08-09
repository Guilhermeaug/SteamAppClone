import 'package:flutter/material.dart';

import 'drawer_items.dart';
import '../../steamapi/jabigod.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(
                border: Border(
                  bottom: Divider.createBorderSide(
                    context,
                    color: Colors.grey,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.network(jabigod.avatarMedium),
                  const SizedBox(width: 10),
                  Text(
                    jabigod.personaName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...createHeaderItems(context)
        ],
      ),
    );
  }
}
