import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../all_page.dart';

class ChatController extends ChangeNotifier {
  List<User> chats = [];
  Future<List<User>> getData() async {
    print("getData");
    chats = await apiGetUser();
    return chats;
  }

  Future<List<User>> searchData(String txtSearch) async {
    print(txtSearch);
    return txtSearch.isNotEmpty
        ? chats.where((element) {
            final nameLower = element.firstName!.toLowerCase() + " " + element.lastName!.toLowerCase();
            final queryLower = txtSearch.toLowerCase();
            return nameLower.contains(queryLower);
          }).toList()
        : [];
  }
}
