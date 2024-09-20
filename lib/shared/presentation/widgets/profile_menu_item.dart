import '../../../shared/presentation/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String icon;
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFffffff),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 225, 221, 221),
            blurRadius: 1.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: Offset(
              1.0, // Move to right 5  horizontally
              3.0, // Move to bottom 5 Vertically
            ),
          )
        ],
      ),
      child: MenuItem(title: title, onTap: onTap, icon: icon),
    );
  }
}
