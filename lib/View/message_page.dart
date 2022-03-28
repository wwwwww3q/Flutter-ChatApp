import 'dart:math';

import 'package:flutter/material.dart';
import '../all_page.dart';

//code layout tham khao tu` google https://viblo.asia/p/flutter-viet-ung-dung-chat-voi-flutter-p1-GrLZD8GOZk0
class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State createState() => MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false; //dang nhap chu~=false

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildTextInput() => Container(
        margin: const EdgeInsets.all(kDefaultPadding),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          //duong vien`cua textbox
          //border: Border.all(width: 1.0, color: Colors.black38),
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String text) {
                  //neu' co' du lieu trong text thi` nut gui~ se~ dc hien
                  if (!_isComposing) setState(() => _isComposing = text.isNotEmpty);
                  if (text.isEmpty) setState(() => _isComposing = false);
                },
                keyboardType: TextInputType.multiline, //co the dc nhieu` dong`
                maxLines: 10, //do dai` toi' da =10
                minLines: 1,
                decoration: const InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            //neu' textfield ko rong~ thi` dc phep nhan' nut, ngc lai thi` nhan' ko dc
            IconButton(
                icon: Icon(
                  Icons.emoji_emotions_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null),
          ],
        ),
      );

  Widget _buildTextComposer() {
    //bottom chat Text o duoi man hinh`
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.primary),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(padding: const EdgeInsets.only(bottom: kDefaultPadding), icon: const Icon(Icons.more_vert), onPressed: () {}),
            IconButton(padding: const EdgeInsets.only(bottom: kDefaultPadding), icon: const Icon(Icons.attach_file), onPressed: () {}),
            IconButton(padding: const EdgeInsets.only(bottom: kDefaultPadding), icon: const Icon(Icons.mic), onPressed: () {}),
            Expanded(child: _buildTextInput()),
            IconButton(padding: const EdgeInsets.only(bottom: kDefaultPadding), icon: const Icon(Icons.thumb_up), onPressed: () {}),
          ],
        ));
  }

  //ham` khi nhan' gui~
  void _handleSubmitted(String text) async {
    //textField sẽ clear chu~
    _textController.clear();
    //dat lai trang thai' dang soan =false
    setState(() => _isComposing = false);
    if (text.isNotEmpty) {
      //neu' textField ko rong~ thi` tao 1 widget tin nhan' moi'
      // final mess = Message(khachHangId: Auth.khachHang.id, body: text);
      // //them vao` danh sach tin nhan' o phan tu? dau` tien
      // final sucssess = await Provider.of<MessageController>(context, listen: false).addData(mess);
      // if (sucssess)
      //   print("Them thanh cong");
      // else
      //   print("Them that bai");
    }
  }

  int i = 1;
  @override //new
  Widget build(BuildContext context) {
    print(i++); //text
    return SafeArea(
        child: GestureDetector(
      //huy keyboard khi bam ngoai man hinh
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 75,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary, //change your color here
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //backgroundColor: Colors.amber,
          elevation: 0, //shadow
          title: Row(children: [
            const BackButton(),
            Expanded(
                child: ListTile(
              leading: Stack(
                children: [
                  const CircleAvatar(
                    //radius: 25,
                    backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/22.jpg"),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        //neu dang hoat dong thi` them cai bo tron` nho? nho?
                        color: Random().nextBool() ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 3),
                      ),
                    ),
                  )
                ],
              ),
              title: const Text(
                "chat.name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                "online",
                style: TextStyle(fontSize: 12),
              ),
            ))
          ]),
          actions: [
            IconButton(
              icon: const Icon(Icons.local_phone),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.videocam),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {},
            ),
            const SizedBox(width: kDefaultPadding / 2),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              // Flexible dua theo widget, size cua thiet bi ma` thay doi?
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true, //tu duoi' len
                itemCount: 10,
                itemBuilder: (context, index) => ChatMessage(
                  chatString: getRandomString(100),
                ),
              ),
            ),
            // Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: SafeArea(
                bottom: true,
                //bottom chat Text o duoi man hinh`
                child: _buildTextComposer(),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class ChatMessage extends StatelessWidget {
  final String chatString;
  const ChatMessage({Key? key, required this.chatString}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //minh` nhan', xac' dinh no' thong qua thuoc tinh' gi` gi` do', o day cho dai random
    if (Random().nextBool()) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
            margin: const EdgeInsets.all(kDefaultPadding),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / (1.5)),
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.blue),
            child: Text(chatString, style: const TextStyle(color: Colors.white))), //noi dung chat
      );
    }
    //ng`khac' nhan'
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: const CircleAvatar(child: Text("A")), //hinh anh avt
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Admin"), //ten
              Container(
                //width: MediaQuery.of(context).size.width / (1.3),
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / (1.3)),
                margin: const EdgeInsets.only(top: 5.0),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)), color: Colors.grey.withOpacity(0.4)),
                child: Text(chatString), //noi dung chat
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//phan` nay` random chuoi~ copy tu` google thay cho messenge
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
