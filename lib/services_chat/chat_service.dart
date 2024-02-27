import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chats/model/message.dart';

class ChatService extends ChangeNotifier {
  //get instance of auth and fireStore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message);

    //construct chat room id from current user id and receiver id (dorted to ensure uniqueness)
    List<String> ids =  [currentUserId, receiverId];
    ids.sort();//sort the ids (this ensures the chat room id is always the salR for any pair)
    String chatRoomId = ids.join("_");//combine the Ids into a single string  to use as chatroomid

    // add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());


  }
  //get message
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId){
    //construct chat room id from user ids (sorted to ensure it matches the id used when sending
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }}
