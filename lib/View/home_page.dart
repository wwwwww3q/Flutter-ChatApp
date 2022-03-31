import 'package:flutter/material.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/all_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndexBottomNav = 1;
  final List<Widget> _widgetPage = [
    const ChatPage(),
    const ChatPage(),
    const ChatPage(),
    const ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      //huy keyboard khi bam ngoai man hinh
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: _widgetPage.elementAt(currentIndexBottomNav),
        //Footer
        bottomNavigationBar: Container(
          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 8), // changes position of shadow
            )
          ]),
          child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
              child: BottomNavigationBar(
                //backgroundColor: Colors.amber,
                type: BottomNavigationBarType.fixed, //ko cho no thu nho? mat chu~
                currentIndex: currentIndexBottomNav,
                selectedIconTheme: const IconThemeData(size: 30),
                //selectedItemColor: Colors.indigo,
                onTap: (index) => setState(() => currentIndexBottomNav = index),
                items: [
                  bottomNavBarItem(context, label: 'Diary', iconData: Icons.article_outlined),
                  bottomNavBarItem(context, label: 'Message', iconData: Icons.message_outlined),
                  bottomNavBarItem(context, label: 'Daily Task', iconData: Icons.task_outlined),
                  bottomNavBarItem(context, label: 'Profile', iconData: Icons.person_outline),
                ],
              )),
        ),
      ),
    ));
  }
}
