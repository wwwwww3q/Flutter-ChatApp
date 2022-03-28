import 'package:flutter/material.dart';
import '../all_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatsData.length,
      itemBuilder: (context, index) => ChatCard(
        chat: chatsData[index],
        press: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Container(),
          ),
        ),
      ),
    );
  }
}
