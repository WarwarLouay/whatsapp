import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/custom_ui/button_card.dart';
import 'package:whatsapp/screens/home_screen.dart';

import '../models/chat_model.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;
  late Future _usersFuture;
  String? currentUser;

  Future obtainUsersFuture() async {
    final prefs = await SharedPreferences.getInstance();
    currentUser = prefs.getString("phone");
    return Provider.of<UserModel>(context, listen: false).fetchUsers();
  }

  @override
  void initState() {
    _usersFuture = obtainUsersFuture();
    super.initState();
  }

  List<ChatModel> chatModels = [
    ChatModel(
        id: 1,
        name: 'Ahmad',
        icon: 'person.svg',
        isGroup: false,
        time: '4:00',
        currentMessage: 'Hello'),
    ChatModel(
        id: 2,
        name: 'Shisha',
        icon: 'groups.svg',
        isGroup: true,
        time: '12:00',
        currentMessage: 'hahahahaha'),
    ChatModel(
        id: 3,
        name: 'Khoder',
        icon: 'person.svg',
        isGroup: false,
        time: '12:30:00',
        currentMessage: 'No'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ListView.builder(
      //   itemCount: chatModels.length,
      //   itemBuilder: (context, index) => InkWell(
      //     onTap: () {
      //       sourceChat = chatModels.removeAt(index);
      //       Navigator.pushReplacement(
      //           context, MaterialPageRoute(builder: (builder) => HomeScreen(chatModels: chatModels, souceChat: sourceChat,)));
      //     },
      //     child: ButtonCard(
      //       name: chatModels[index].name,
      //       icon: Icons.person,
      //     ),
      //   ),
      // ),
      body: FutureBuilder(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    // sourceChat = chatModels.removeAt(index);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (builder) => HomeScreen(
                    //               chatModels: chatModels,
                    //               souceChat: sourceChat,
                    //             )));
                  },
                  child: snapshot.data![index].phone != currentUser
                      ? ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFF25D366),
                            radius: 23,
                            child: Icon(
                              Icons.person,
                              size: 26,
                              color: Colors.white,
                            ),
                          ),
                          // ignore: prefer_const_constructors
                          title: Text(
                            snapshot.data![index].phone,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Container(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          }),
      // body: Center(
      //   child: FutureBuilder(
      //     future: _usersFuture,
      //     builder: (context, snapshot) {
      //       print(snapshot.hasData);
      //       if (snapshot.hasData) {
      //         return GridView.builder(
      //           padding: const EdgeInsets.all(10),
      //           itemCount: snapshot.data!.length,
      //           itemBuilder: (context, index) => Container(
      //             child: InkWell(
      //               onTap: () => {},
      //               splashColor: Theme.of(context).primaryColor,
      //               borderRadius: BorderRadius.circular(15),
      //               child: Container(
      //                 width: MediaQuery.of(context).size.width,
      //                 padding: EdgeInsets.all(15),
      //                 child: Center(
      //                   child: Text(
      //                     snapshot.data![index].phone,
      //                     style: TextStyle(
      //                       fontSize: 20,
      //                       color: Colors.teal,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                 ),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(15),
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: Colors.grey,
      //                       offset: Offset(0.0, 1.0), //(x,y)
      //                       blurRadius: 6.0,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 1,
      //               childAspectRatio: 3 / 1,
      //               crossAxisSpacing: 10,
      //               mainAxisSpacing: 10),
      //         );
      //       } else if (snapshot.hasError) {
      //         return Text('${snapshot.error}');
      //       } else {
      //         return CircularProgressIndicator();
      //       }
      //     },
      //   ),
      // ),
    );
  }
}
