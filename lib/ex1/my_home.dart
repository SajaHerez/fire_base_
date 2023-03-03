import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream<QuerySnapshot> getStream() => FirebaseFirestore.instance
      .collection("languages")
      .orderBy("likes", descending: true) // 1
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getStream(),
        builder: (context, languages) {
          if (languages.hasError) {
            return const Text("error");
          }
          if (languages.hasData) {
            final data = languages.data;
            if (data != null) {
              return ListView.builder(
                itemExtent: 80.0,
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.docs[index].get('name')),
                    subtitle:
                        Text("Total likes: ${data.docs[index].get('likes')}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.thumb_up),
                      onPressed: ()async {
                        FirebaseFirestore.instance
                            .runTransaction((transaction) async {
// 1.
                          final secureSnapshot =
                              await transaction.get(data.docs[index].reference);
                              if(secureSnapshot.exists){
// Getting the current likes count
                          final int currentLikes =
                              secureSnapshot.get("likes") as int;
// 2.
                          transaction.update(secureSnapshot.reference,
                              {"likes": currentLikes + 1});
                              }
                        });
                      },
                    ),
                  );
                },
              );
            } else {
              return const Text("error");
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
