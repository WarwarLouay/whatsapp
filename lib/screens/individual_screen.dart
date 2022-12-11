// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore, sort_child_properties_last, sized_box_for_whitespace, avoid_print, prefer_is_empty, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/custom_ui/own_message_card.dart';
import 'package:whatsapp/custom_ui/reply_card.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/models/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({super.key, this.chatModel, this.souceChat});
  final ChatModel? chatModel;
  final ChatModel? souceChat;

  @override
  State<IndividualScreen> createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io('http://192.168.0.107:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.onConnect((data) {
      print('Connected');
      socket.on('message', (msg) {
        print(msg);
        setMessage('destination', msg['message']);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
    socket.emit('signin', widget.souceChat!.id);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage('source', message);
    socket.emit('message',
        {'message': message, 'sourceId': sourceId, 'targetId': targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(type: type, message: message, time: DateTime.now().toString().substring(10,16));
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/wpp_bg.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: prefer_const_constructors
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        widget.chatModel!.isGroup!
                            ? 'assets/groups.svg'
                            : 'assets/person.svg',
                        color: Colors.white,
                        height: 37,
                        width: 37,
                      ),
                    )
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel!.name!,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Last seen Today at 12:25',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {},
                ),
                PopupMenuButton<String>(
                  onSelected: ((value) {
                    print(value);
                  }),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text('View Contact'),
                        value: 'View Contact',
                      ),
                      PopupMenuItem(
                        child: Text('Media, links, and docs'),
                        value: 'Media, links, and docs',
                      ),
                      PopupMenuItem(
                        child: Text('Whatsapp Web'),
                        value: 'Whatsapp Web',
                      ),
                      PopupMenuItem(
                        child: Text('Search'),
                        value: 'Search',
                      ),
                      PopupMenuItem(
                        child: Text('Mute Notification'),
                        value: 'Mute Notification',
                      ),
                      PopupMenuItem(
                        child: Text('Wallpaper'),
                        value: 'Wallpaper',
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(height: 70);
                        }
                        if (messages[index].type == 'source') {
                          return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Card(
                                margin: EdgeInsets.only(
                                    left: 2, right: 2, bottom: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                  controller: _controller,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type a message...',
                                    prefixIcon: IconButton(
                                      icon: Icon(Icons.emoji_emotions),
                                      onPressed: () {},
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.attach_file),
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  bottomSheet(),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8, right: 2),
                              child: CircleAvatar(
                                radius: 25,
                                child: IconButton(
                                  icon:
                                      Icon(sendButton ? Icons.send : Icons.mic),
                                  onPressed: () {
                                    if (sendButton) {
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeOut);
                                      sendMessage(
                                        _controller.text,
                                        (widget.souceChat!.id)!.toInt(),
                                        (widget.chatModel!.id)!.toInt(),
                                      );
                                      _controller.clear();
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 270,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.insert_drive_file,
                    Colors.indigo,
                    'Document',
                  ),
                  SizedBox(width: 40),
                  iconCreation(
                    Icons.camera_alt,
                    Colors.pink,
                    'Camera',
                  ),
                  SizedBox(width: 40),
                  iconCreation(
                    Icons.insert_photo,
                    Colors.purple,
                    'Gallery',
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                    Icons.headset,
                    Colors.orange,
                    'Audio',
                  ),
                  SizedBox(width: 40),
                  iconCreation(
                    Icons.location_pin,
                    Colors.teal,
                    'Location',
                  ),
                  SizedBox(width: 40),
                  iconCreation(
                    Icons.person,
                    Colors.blue,
                    'Contact',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
