import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = "";

  _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData=await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt':Timestamp.now(),
      'username':userData['username'],
      'userId':user?.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (val) {
                setState(() {
                  _enteredMessage = val;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.send),
            onPressed:(){_enteredMessage.trim().isEmpty ? null : _sendMessage();},
          ),
        ],
      ),
    );
  }
}
