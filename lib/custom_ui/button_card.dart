// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key, this.name, this.icon});
  final String? name;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xFF25D366),
        radius: 23,
        child: Icon(icon, size: 26, color: Colors.white,),
      ),
      // ignore: prefer_const_constructors
      title: Text(
        name!,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
