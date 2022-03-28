import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../all_page.dart';

class ChatController extends ChangeNotifier {
  List<User> chats = [];
  Future<List<User>> getData(String txtSearch) async {
    print("getData");
    chats = await apiGetUser(txtSearch);
    return chats;
  }
}
