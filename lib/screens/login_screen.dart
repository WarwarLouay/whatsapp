import 'package:flutter/material.dart';
import 'package:whatsapp/custom_ui/button_card.dart';
import 'package:whatsapp/screens/home_screen.dart';

import '../models/chat_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
        id: 1,
        name: 'Ahmad',
        icon: 'person.svg',
        isGroup: false,
        time: '4:00',
        currentMessage: 'Hello'),
    ChatModel(
        id: 2,
        name: 'Shisha',
        icon: 'groups.svg',
        isGroup: true,
        time: '12:00',
        currentMessage: 'hahahahaha'),
    ChatModel(
        id: 3,
        name: 'Khoder',
        icon: 'person.svg',
        isGroup: false,
        time: '12:30:00',
        currentMessage: 'No'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chatModels.removeAt(index);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (builder) => HomeScreen(chatModels: chatModels, souceChat: sourceChat,)));
          },
          child: ButtonCard(
            name: chatModels[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}
