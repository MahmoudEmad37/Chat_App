import 'package:cloud_firestore/cloud_firestore.dart';
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
        return  ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) =>
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(docs[index]['text']),
              ),
        );
      },
    );
  }
}
