import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math'; //random chơi
import '../all_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String txtSearch = "";
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
    return SafeArea(
        child: GestureDetector(
      //huy keyboard khi bam ngoai man hinh
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        //Hide
        //drawer: const NavigationDrawer(),
        body: CustomScrollView(
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
                  padding: const EdgeInsets.fromLTRB(kDefaultPadding / 2, kDefaultPadding, kDefaultPadding, kDefaultPadding),
                  child: Row(
                    children: [
                      const BackButton(),
                      Expanded(
                          child: SearchWidget(
                        textSearch: txtSearch,
                        hintText: "Search Anyone",
                        onChanged: (value) => debounce(() async => setState(() => txtSearch = value)),
                      ))
                    ],
                  ),
                ),
                preferredSize: const Size(0.0, 80.0),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              FutureBuilder<List<User>>(
                  future: Provider.of<ChatController>(context, listen: false).searchData(txtSearch),
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
                          : Column(
                              children: [
                                Text("${snapshot.data!.length} result found"),
                                ListView.builder(
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
                                )
                              ],
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ]))
          ],
        ),
      ),
    ));
  }
}
