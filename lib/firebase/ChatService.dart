import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/models/message.dart';


class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

// get user stream
  Stream<List<Map<String, dynamic>>> getuserStream() {
    final currentUserID = _auth.currentUser!.uid;

    return _firestore.collection("chat_rooms").where("participants", arrayContains: currentUserID).snapshots().asyncMap((snapshot) async {
      List<Map<String, dynamic>> users = [];
      for (var doc in snapshot.docs) {
        // Get the participant IDs (assuming you store them in a 'participants' field)
        List<String> participants = List<String>.from(doc.data()["participants"]);

        for (String participantID in participants) {
          // Skip if it's the current user
          if (participantID != currentUserID) {
            // Fetch user data
            var userSnapshot = await _firestore.collection("Users").doc(participantID).get();
            if (userSnapshot.exists) {
              users.add(userSnapshot.data()!);
            }
          }
        }
      }
      return users;
    });
  }
  Future <void> sendMessages (String receiverID , message) async{

    final String currentUserID = _auth.currentUser!.uid ;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp
    );
    List <String> ids = [currentUserID , receiverID] ;
    ids.sort();
    String chatRoomId = ids.join('_');

    // add new message to database
    await _firestore.collection("chat_rooms")
        .doc(chatRoomId).collection("messages")
        .add(newMessage.toMap());
  }
   // to get the messages
  Stream <QuerySnapshot> getMessages (String userID, otherUserID)
  {
    List <String> ids = [userID , otherUserID] ;
    ids.sort();
    String chatRoomID = ids.join('_') ;
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp" , descending: false)
        .snapshots();
  }
}