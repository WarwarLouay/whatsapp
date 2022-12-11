// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/chat_model.dart';

import '../screens/individual_screen.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key,this.chatModel, this.souceChat});
  final ChatModel? chatModel;
  final ChatModel? souceChat;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => IndividualScreen(chatModel: chatModel, souceChat: souceChat,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                chatModel!.isGroup! ? 'assets/groups.svg' : 'assets/person.svg',
                color: Colors.white,
                height: 37,
                width: 37,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chatModel!.name!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel!.currentMessage!,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
            trailing: Text(chatModel!.time!),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
