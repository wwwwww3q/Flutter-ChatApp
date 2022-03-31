import 'package:flutter/material.dart';
import '../all_page.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  //dang' ly' ra la` truyen` id hoac token gi` do' de sang trang chat se~ query ra.
  //nhung API bi thieu' nen truyen` luon 1 cai'Object sang
  final User user;
  const ChatCard({
    Key? key,
    required this.chat,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => MessagePage(user),
            ));
      },
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(chat.image),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                //neu dang hoat dong thi` them cai bo tron` nho? nho?
                color: chat.isActive ? Colors.green : Colors.grey,
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
        style: chat.isSeen ? TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold) : null,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            chat.time,
            style: const TextStyle(color: Colors.grey),
          ),
          if (chat.isSeen)
            Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
                child: const Text("2", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
