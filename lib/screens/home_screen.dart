import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/firebase/ChatService.dart';
import 'package:untitled/firebase/auth_service.dart';
import 'package:untitled/models/user_tile.dart';
import 'chat_screen_2.dart';
import 'sign_in_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _emailController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  void initState ()
  {
    super.initState();
    getTokn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Chats', style: TextStyle(color: Colors.amber, fontSize: 26.0)),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.amber),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: _builderUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSearchDialog(context),
        child: Icon(Icons.search),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Widget _builderUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getuserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return Container(
          color: Colors.black12,
          child: ListView(

            children: snapshot.data!.map<Widget>((userData) => _builderUserListItem(userData, context)).toList(),
          ),
        );
      },
    );
  }

  Widget _builderUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ChatScreen_2(
              receiverEmail: userData["email"],
              receiverID: userData["uid"],
            ),),);
      },
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (context) {

        return Center(
          child: ListView(

              children: [ AlertDialog(
                backgroundColor: Colors.black87,
                title: Text('Search User by Email' , style: TextStyle(color: Colors.amber),),
                content: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Enter email" ),
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      String emailToSearch = _emailController.text.trim();
                      QuerySnapshot snapshot = await _firestore
                          .collection("Users")
                          .where("email", isEqualTo: emailToSearch)
                          .get();

                      if (snapshot.docs.isNotEmpty) {
                        // If the user is found, get the user ID and email
                        String receiverID = snapshot.docs.first.id; // Get the receiver ID

                        // Check if chat room exists
                        List<String> ids = [_auth.currentUser!.uid, receiverID];
                        ids.sort();
                        String chatRoomID = ids.join('_');

                        DocumentSnapshot chatRoomSnapshot = await _firestore
                            .collection("chat_rooms")
                            .doc(chatRoomID)
                            .get();

                        if (!chatRoomSnapshot.exists) {
                          // If the chat room doesn't exist, create it
                          await _firestore.collection("chat_rooms").doc(chatRoomID).set({
                            "participants": ids, // Store participants in the chat room
                          });
                        }

                        // Navigate to chat screen
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ChatScreen_2(
                              receiverEmail: emailToSearch,
                              receiverID: receiverID,
                            ),
                        ));
                      } else {
                        // If the user is not found, show a message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User not found')),
                        );
                      }
                      _emailController.clear(); // Clear the text field
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Search' , style: TextStyle(color: Colors.amber)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel' , style: TextStyle(color: Colors.white60)),
                  ),
                ],
              ),
              ]),
        );
      },
    );
  }

  getTokn () async {
    String?  mytoken = await FirebaseMessaging.instance.getToken();
    print("===========================================================");
    print(mytoken);
  }
}