import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math'; //random chơi
import '../all_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController txtSearch = TextEditingController();
  //thoi gian tim kiem'
  Timer? debouncer;

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    const colorAppBar = Colors.black;

    return Consumer<ChatController>(
        builder: (context, chatController, child) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  //backgroundColor: Colors.amber,
                  elevation: 0, //shadow
                  automaticallyImplyLeading: false, //tat' cai' back tu dong
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/22.jpg"),
                  ),
                  title: const Text("Chats", style: TextStyle(color: colorAppBar)),
                  actions: [
                    IconButton(icon: const Icon(Icons.camera_alt, color: colorAppBar), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.edit, color: colorAppBar), onPressed: () {}),
                  ],
                  bottom: PreferredSize(
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: SearchWidget(
                          txtSearch: txtSearch,
                          onChanged: (value) => debounce(() async => Provider.of<ChatController>(context, listen: false).notifyListeners()),
                          hintText: "Search Anyone"),
                    ),
                    preferredSize: const Size(0.0, 80.0),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  FutureBuilder<List<User>>(
                      future: chatController.getData(txtSearch.text),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        }
                        if (snapshot.hasData) {
                          return (snapshot.data!.isEmpty)
                              ? Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svgIcons/search_2.svg",
                                      width: 200,
                                      height: 200,
                                    ),
                                    const Text("Not found"),
                                  ],
                                )
                              : ListView.builder(
                                  shrinkWrap: true, //tranh' loi~ view SingleChildScrollView-column
                                  //ngan chan ListView no' cuon xuong' duoc, xai` cho SingleChildScrollView-column
                                  physics: const NeverScrollableScrollPhysics(),
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
                      })
                ])),
              ],
            ));
  }
}
