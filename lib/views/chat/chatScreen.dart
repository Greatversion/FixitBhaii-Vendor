import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String receiverId;

  ChatScreen({required this.chatId, required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    _firestore
        .collection("chats")
        .doc(widget.chatId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs.map((doc) {
        final data = doc.data();
        return types.TextMessage(
          id: doc.id,
          author: types.User(id: data["senderId"]),
          text: data["text"],
          createdAt: data["timestamp"].millisecondsSinceEpoch,
        );
      }).toList();
      setState(() {
        _messages = messages;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final messageData = {
      "senderId": user.uid,
      "receiverId": widget.receiverId,
      "text": message.text,
      "timestamp": FieldValue.serverTimestamp(),
    };

    _firestore
        .collection("chats")
        .doc(widget.chatId)
        .collection("messages")
        .add(messageData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: types.User(id: user.uid),
      ),
    );
  }
}
