import 'package:flutter/material.dart';
import 'package:flutter_chatapp/View/chat_page.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/all_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController txtTimKiem = TextEditingController();
  final colorAppBar = Colors.black;
  int currentIndexBottomNav = 0;
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
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //backgroundColor: Colors.amber,
          elevation: 0, //shadow
          automaticallyImplyLeading: false, //tat' cai' back tu dong
          leading: const CircleAvatar(
            backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/22.jpg"),
          ),
          title: Text("Chats", style: TextStyle(color: colorAppBar)),
          actions: [
            IconButton(icon: Icon(Icons.camera_alt, color: colorAppBar), onPressed: () {}),
            IconButton(icon: Icon(Icons.edit, color: colorAppBar), onPressed: () {}),
          ],
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SearchWidget(txtTimKiem: txtTimKiem, onChanged: (value) {}, hintText: "Search Anyone"),
            ),
            preferredSize: const Size(0.0, 80.0),
          ),
        ),
        body: _widgetPage.elementAt(currentIndexBottomNav),
        //Footer
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            )
          ]),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                //backgroundColor: Colors.amber,
                type: BottomNavigationBarType.fixed, //ko cho no thu nho? mat chu~
                currentIndex: currentIndexBottomNav,
                selectedIconTheme: const IconThemeData(size: 30),
                //selectedItemColor: Colors.indigo,
                onTap: (index) => setState(() => currentIndexBottomNav = index),
                items: [
                  bottomNavBarItem(context, label: 'Bác sĩ', iconData: Icons.article_outlined),
                  bottomNavBarItem(context, label: 'Spa', iconData: Icons.message_outlined),
                  bottomNavBarItem(context, label: 'Phân tích', iconData: Icons.task_outlined),
                  bottomNavBarItem(context, label: 'Chuyên mục', iconData: Icons.person_outline),
                ],
              )),
        ),
      ),
    ));
  }
}
