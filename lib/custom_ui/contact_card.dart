// ignore_for_file: prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/models/chat_model.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, this.contacts});
  final ChatModel? contacts;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 53,
            width: 50,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey[200],
                  radius: 23,
                  child: SvgPicture.asset(
                    'assets/person.svg',
                    color: Colors.white,
                    width: 30,
                    height: 30,
                  ),
                ),
                contacts!.select ? Positioned(
                  bottom: 4,
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 11,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                )
                : Container()
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          title: Text(
            contacts!.name!,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            contacts!.status!,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20, left: 80),
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
