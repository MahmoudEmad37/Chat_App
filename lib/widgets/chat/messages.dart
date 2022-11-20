import 'package:chat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat').orderBy('createdAt',descending: true).snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snapshot.data!.docs;
        final currentUser=FirebaseAuth.instance.currentUser;
        return  ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) =>
              MessageBubble(
                docs[index]['text'],
                docs[index]['username'],
                docs[index]['userId']==currentUser?.uid,
                key: ValueKey(docs[index].id),
              ),
        );
      },
    );
  }
}
