// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:whatsapp/screens/login2_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Column(
                children: [
                  // ignore: prefer_const_constructors
                  SizedBox(height: 50),
                  Text(
                    'Welcome to Whatsapp',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 29,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Image.asset(
                    'assets/bg.png',
                    color: Colors.greenAccent[700],
                    width: 340,
                    height: 340,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 9),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        children: [
                          TextSpan(
                            text: 'Agree and Continue to accept the',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Whatsapp Terms of Service and Privacy Policy',
                            style: TextStyle(
                              color: Colors.cyan,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => Login2Screen()),
                          (route) => false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 110,
                      height: 50,
                      child: Card(
                        margin: EdgeInsets.all(0),
                        elevation: 8,
                        color: Colors.greenAccent[700],
                        child: Center(
                          child: Text(
                            'AGREE AND CONTINUE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
