import 'package:flutter/material.dart';
import 'package:material_color_gen/material_color_gen.dart';

BottomNavigationBarItem bottomNavBarItem(BuildContext context, {required String label, required IconData iconData}) => BottomNavigationBarItem(
    icon: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(color: const Color(0xFFFFE6E6).toMaterialColor(), borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Icon(iconData, color: Theme.of(context).colorScheme.primary)),
    label: label,
    activeIcon: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Icon(iconData, color: Colors.white)));
