// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_final_fields, curly_braces_in_flow_control_structures, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp/models/country_model.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/screens/country_screen.dart';
import 'package:whatsapp/screens/home_screen.dart';
import 'package:whatsapp/screens/otp_screen.dart';

class Login2Screen extends StatefulWidget {
  const Login2Screen({super.key});

  @override
  State<Login2Screen> createState() => _Login2ScreenState();
}

class _Login2ScreenState extends State<Login2Screen> {
  String countryName = 'India';
  String countryCode = '+91';
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // ignore: prefer_const_constructors
        title: Text(
          'Enter your phone number',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w200,
            fontSize: 18,
            wordSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Text(
              'Whatsapp will send an sms message to verify your number',
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'What\'s my number?',
              style: TextStyle(
                fontSize: 12.8,
                color: Colors.cyan[800],
              ),
            ),
            SizedBox(height: 15),
            CountryCard(),
            SizedBox(height: 5),
            number(),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                if (_controller.text.isEmpty) {
                  showErrorDialog();
                } else {
                  showMyDialog();
                }
              },
              child: Container(
                color: Colors.tealAccent[400],
                height: 40,
                width: 70,
                child: Center(
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget CountryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => CountryScreen(
                      setCountryData: setCountryData,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.teal,
              width: 1.8,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    countryName,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      child: Row(
        children: [
          Container(
            width: 70,
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Text(
                  '+',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  countryCode.substring(1),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 30),
          Container(
            width: MediaQuery.of(context).size.width / 1.5 - 100,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                ),
              ),
            ),
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
                hintText: 'Phone Number',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = (countryModel.name).toString();
      countryCode = (countryModel.code).toString();
    });
    Navigator.pop(context);
  }

  Future<void> showMyDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We will verify your phone number',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  countryCode + ' ' + _controller.text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Is this OK, or would you like to edit the number?',
                  style: TextStyle(
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Register as new'),
              onPressed: () {
                Navigator.pop(context);
                register();
              },
            ),
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.pop(context);
                logIN();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> register() async {
    try {
      await Provider.of<UserModel>(context, listen: false).register(
        countryName,
        countryCode + ' ' + _controller.text,
      );

      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Success'),
                content: const Text('Account created'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok')),
                ],
              ));
    } on HttpException catch (error) {
      if (error.toString().contains('Phone already exist')) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Oops!'),
                  content: const Text(
                      'This phone already in use. Please press "Continue" to use it.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok')),
                  ],
                ));
      } else {
        print(error);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Oops!'),
                  content: const Text(
                      'This phone already in use. Please press "Continue" to use it.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok')),
                  ],
                ));
      }
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Oops!'),
                content: const Text(
                    'This phone already in use. Please press "Continue" to use it.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok')),
                ],
              ));
    }
  }

  Future<void> logIN() async {
    try {
      await Provider.of<UserModel>(context, listen: false)
          .login(countryCode, _controller.text);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (builder) => OtpScreen(
                    number: _controller.text,
                    countryCode: countryCode,
                  )),
          (route) => false);
    } on HttpException catch (error) {
      if (error.toString().contains('Invalid phone number')) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Oops!'),
                  content: const Text('Invalid phone number. Please register as new.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok')),
                  ],
                ));
      }
    } catch (error) {
      print(error);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Oops!'),
                content: const Text('Invalid phone number. Please register as new.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok')),
                ],
              ));
    }
  }

  Future<void> showErrorDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'There is no number entered',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
