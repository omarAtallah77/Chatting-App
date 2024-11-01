import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/firebase/ChatService.dart';
import 'package:untitled/firebase/auth_service.dart';

class ChatScreen_2 extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final String  receiverEmail;
  final String receiverID;
  final ScrollController _scrollController = ScrollController();

  ChatScreen_2({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessages(receiverID, _messageController.text);
      _messageController.clear();
      _scrollToBottom(); // Scroll to the bottom after sending a message
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Text(receiverEmail, style: const TextStyle(color: Colors.white60)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.amber), // Back icon
          onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildUserInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _auth.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _auth.currentUser!.uid;
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    var bubbleColor = isCurrentUser ? Colors.amber : const Color(0xFFECECEC);
    var textColor = isCurrentUser ? Colors.black87 : Colors.black;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: BubbleSpecialThree(
        text: data["message"],
        color: bubbleColor,
        tail: true,
        isSender: isCurrentUser,
        textStyle: TextStyle(color: textColor, fontSize: 16),
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              maxLines: null, // Allows multi-line input and expands with content
              minLines: 1,
              decoration: InputDecoration(
                labelText: "Message",
                labelStyle: const TextStyle(color: Colors.amber),
                filled: true,
                fillColor: Colors.grey[800],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.amber),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.amber),
            onPressed: () {
              sendMessage();
            },
          ),
        ],
      ),
    );
  }
}