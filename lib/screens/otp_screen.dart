// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/screens/home_screen.dart';
import 'package:whatsapp/screens/login_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, this.number, this.countryCode});
  final String? number;
  final String? countryCode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Future futureUsers;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verify ${widget.countryCode} ${widget.number}',
          style: TextStyle(
            color: Colors.teal[800],
            fontSize: 16.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'We have sent an SMS with a code to ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                    ),
                  ),
                  TextSpan(
                    text: widget.countryCode! + ' ' + widget.number!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' Wrong number?',
                    style: TextStyle(
                      color: Colors.cyan[800],
                      fontSize: 14.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                if (pin == '000000') {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => LoginScreen()),
                      (route) => false);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Oops!'),
                            content:
                                const Text('Verification code is incorrect.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Ok')),
                            ],
                          ));
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Enter 6-digit code',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            SizedBox(height: 30),
            bottomButton('Resend SMS', Icons.message),
            SizedBox(height: 12),
            Divider(thickness: 1.5),
            SizedBox(height: 12),
            bottomButton('Call Me', Icons.call),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.teal,
          size: 24,
        ),
        SizedBox(width: 25),
        Text(
          text,
          style: TextStyle(
            color: Colors.teal,
            fontSize: 14.5,
          ),
        ),
      ],
    );
  }
}
