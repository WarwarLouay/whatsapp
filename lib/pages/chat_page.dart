// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/screens/select_contact_screen.dart';

import '../custom_ui/custom_card.dart';

import '../models/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.chatModels, this.souceChat});
  final List<ChatModel>? chatModels;
  final ChatModel? souceChat;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContactScreen()));
        },
      ),
      body: ListView.builder(
        itemCount: widget.chatModels!.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: widget.chatModels![index],
          souceChat: widget.souceChat,
        ),
      ),
    );
  }
}
