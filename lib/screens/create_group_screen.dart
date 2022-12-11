// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore, sort_child_properties_last, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:whatsapp/custom_ui/avatar_card.dart';
import 'package:whatsapp/custom_ui/button_card.dart';
import 'package:whatsapp/models/chat_model.dart';

import '../custom_ui/contact_card.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  List<ChatModel> contacts = [
    ChatModel(name: 'Ahmad', status: 'Full Stack Developer'),
    ChatModel(name: 'Bashir', status: 'React-Angular Developer'),
    ChatModel(name: 'Khoder', status: 'Web Developer'),
    ChatModel(name: 'Ali', status: 'Flutter Developer'),
    ChatModel(name: 'Mahmoud', status: 'Front End Developer'),
    ChatModel(name: 'Ahmad', status: 'Full Stack Developer'),
    ChatModel(name: 'Bashir', status: 'React-Angular Developer'),
    ChatModel(name: 'Khoder', status: 'Web Developer'),
    ChatModel(name: 'Ali', status: 'Flutter Developer'),
    ChatModel(name: 'Mahmoud', status: 'Front End Developer'),
  ];
  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: prefer_const_constructors
            Text(
              'New Group',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Add participants',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 26,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groups.length > 0 ? 90 : 10,
                  );
                }
                return InkWell(
                  onTap: () {
                    if (contacts[index - 1].select == false) {
                      setState(() {
                        contacts[index - 1].select = true;
                        groups.add(contacts[index - 1]);
                      });
                    } else {
                      setState(() {
                        contacts[index - 1].select = false;
                        groups.remove(contacts[index - 1]);
                      });
                    }
                  },
                  child: ContactCard(
                    contacts: contacts[index - 1],
                  ),
                );
              }),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            if (contacts[index].select == true) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    contacts[index].select = false;
                                    groups.remove(contacts[index]);
                                  });
                                },
                                child: AvatarCard(
                                  contact: contacts[index],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
