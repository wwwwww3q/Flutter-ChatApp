import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math'; //random chơi
import '../all_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
        builder: (context, chatController, child) => FutureBuilder<List<User>>(
            future: chatController.getData(""),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData) {
                return (snapshot.data!.isEmpty)
                    ? SvgPicture.asset(
                        "assets/svgIcons/search_2.svg",
                        width: 200,
                        height: 200,
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => ChatCard(
                          chat: Chat(
                              name: snapshot.data![index].firstName! + " " + snapshot.data![index].lastName!,
                              lastMessage: snapshot.data![index].address!.address!,
                              image: snapshot.data![index].image!,
                              time: TimeAgo.timeAgoSinceDate("2022-03-29"),
                              isActive: Random().nextBool(),
                              isSeen: Random().nextBool()),
                          press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Container(),
                            ),
                          ),
                        ),
                      );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
