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
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //backgroundColor: Colors.amber,
          elevation: 0, //shadow
          automaticallyImplyLeading: false, //tat' cai' back tu dong
          leading: const Padding(
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/22.jpg"),
              )),
          title: const Text("Chats", style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
            IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          ],
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SearchWidget(
                hintText: "Search Anyone",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
            preferredSize: const Size(0.0, 80.0),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          FutureBuilder<List<User>>(
              future: Provider.of<ChatController>(context, listen: false).getData(),
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
                                time: TimeAgo.timeAgoSinceDate("2022-03-31"),
                                isActive: Random().nextBool(),
                                isSeen: Random().nextBool()),
                            user: snapshot.data![index],
                          ),
                        );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
        ]))
      ],
    );
  }
}
