import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'all_page.dart'; //lam` v cho no' nho? ra

void main() {
  //chinh cai' mau` cua nen` pin
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}
// SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChatController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false, //tat cai' debug tren appbar
          title: 'Chat App',
          theme: ThemeData(
            //brightness: Brightness.dark, //che'do toi' hay sang'
            //scaffoldBackgroundColor: const Color(0xFFEEEEEE),
            primarySwatch: kPrimarySwatchColor,
          ),
          home: const HomePage(),
        ),
      );
}
