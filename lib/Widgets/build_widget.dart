import 'package:flutter/material.dart';
import 'package:material_color_gen/material_color_gen.dart';
// import '../all_page.dart';

final kPrimarySwatchColor = const Color(0xFFF76969).toMaterialColor();
final kSecondaryColor = const Color(0xFFFFE6E6).toMaterialColor();
const kDefaultPadding = 10.0;

BottomNavigationBarItem bottomNavBarItem(BuildContext context, {required String label, required IconData iconData}) => BottomNavigationBarItem(
    icon: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(color: kSecondaryColor, borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Icon(iconData, color: Theme.of(context).colorScheme.primary)),
    label: label,
    activeIcon: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Icon(iconData, color: Colors.white)));


