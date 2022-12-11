// ignore_for_file: prefer_const_constructors, unused_field, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/pages/camera_page.dart';

import '../models/chat_model.dart';
import '../pages/chat_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.chatModels, this.souceChat});
  final List<ChatModel>? chatModels;
  final ChatModel? souceChat;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: ((value) {
              print(value);
            }),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('New Group'),
                  value: 'New Group',
                ),
                PopupMenuItem(
                  child: Text('New Broadcast'),
                  value: 'New Broadcast',
                ),
                PopupMenuItem(
                  child: Text('Whatsapp Web'),
                  value: 'Whatsapp Web',
                ),
                PopupMenuItem(
                  child: Text('Starred Messages'),
                  value: 'Starred Messages',
                ),
                PopupMenuItem(
                  child: Text('Settings'),
                  value: 'Settings',
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: 'CHATS',
            ),
            Tab(
              text: 'STATUS',
            ),
            Tab(
              text: 'CALLS',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(),
          ChatPage(
            chatModels: widget.chatModels,
            souceChat: widget.souceChat,
          ),
          Text('STATUS'),
          Text('CALLS'),
        ],
      ),
    );
  }
}
