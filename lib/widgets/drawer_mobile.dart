import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/nav_items.dart';

class DrawerMobile extends StatelessWidget {
  const DrawerMobile({super.key, required this.onNavMenuItemTap});
  final Function(int) onNavMenuItemTap;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColor.scaffoldBg,
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ),
          ),
          for (int i = 0; i < navIcons.length; i++)
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              onTap: () {
                onNavMenuItemTap(i);
              },
              titleTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: CustomColor.whitePrimary,
              ),
              leading: Icon(navIcons[i], size: 26),
              title: Text(navTitles[i]),
            ),
        ],
      ),
    );
  }
}
