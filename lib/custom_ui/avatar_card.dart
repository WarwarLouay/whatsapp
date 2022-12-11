// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/models/chat_model.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, this.contact});
  final ChatModel? contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
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
              // ignore: prefer_const_constructors
              Positioned(
                bottom: 0,
                right: 0,
                // ignore: prefer_const_constructors
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 11,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            contact!.name!,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
