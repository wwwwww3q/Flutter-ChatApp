import 'package:flutter/material.dart';
import '../all_page.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.chat,
    required this.press,
  }) : super(key: key);

  final Chat chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Stack(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/23.jpg"),
          ),
          //neu dang hoat dong thi` them cai bo tron` nho? nho?
          if (chat.isActive)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 3),
                ),
              ),
            )
        ],
      ),
      title: Text(
        chat.name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis, //text dai` qua' thi` ...
        style: TextStyle(color: chat.isSeen ? Theme.of(context).colorScheme.primary : null),
      ),
      trailing: Text(
        chat.time,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
