// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:whatsapp/custom_ui/button_card.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/screens/create_group_screen.dart';

import '../custom_ui/contact_card.dart';

class SelectContactScreen extends StatefulWidget {
  const SelectContactScreen({super.key});

  @override
  State<SelectContactScreen> createState() => _SelectContactScreenState();
}

class _SelectContactScreenState extends State<SelectContactScreen> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: prefer_const_constructors
            Text(
              'Select Contact',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '256 contacts',
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
          PopupMenuButton<String>(
            onSelected: ((value) {
              print(value);
            }),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Invite a friend'),
                  value: 'Invite a friend',
                ),
                PopupMenuItem(
                  child: Text('Contacts'),
                  value: 'Contacts',
                ),
                PopupMenuItem(
                  child: Text('Refresh'),
                  value: 'Refresh',
                ),
                PopupMenuItem(
                  child: Text('Help'),
                  value: 'Help',
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => CreateGroupScreen()));
                },
                child: ButtonCard(
                  icon: Icons.group,
                  name: 'New Group',
                ),
              );
            } else if (index == 1) {
              return ButtonCard(
                icon: Icons.person_add,
                name: 'New Contact',
              );
            }
            return ContactCard(
              contacts: contacts[index - 2],
            );
          }),
    );
  }
}
