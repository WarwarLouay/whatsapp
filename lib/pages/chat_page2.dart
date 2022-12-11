// ignore_for_file: use_build_context_synchronously, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../models/user_model.dart';
import '../screens/select_contact_screen.dart';

class ChatPage2 extends StatefulWidget {
  const ChatPage2({super.key});

  @override
  State<ChatPage2> createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContactScreen()));
        },
      ),
      body: FutureBuilder(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => IndividualScreen(
                  //               chatModel: chatModel,
                  //               souceChat: souceChat,
                  //             )));
                },
                child: snapshot.data![index].phone != currentUser ? Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: SvgPicture.asset(
                          'assets/person.svg',
                          color: Colors.white,
                          height: 37,
                          width: 37,
                        ),
                        backgroundColor: Colors.blueGrey,
                      ),
                      title: Text(
                        snapshot.data![index].phone,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.done_all),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Hi',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      trailing: Text('12:30'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20, left: 80),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ) : Container(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return buildShimmer();
          }
        },
      ),
    );
  }

  Widget buildShimmer() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade50,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 200,
                        height: 13,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 100,
                        height: 10,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 50,
                  height: 10,
                  color: Colors.white,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 80),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
