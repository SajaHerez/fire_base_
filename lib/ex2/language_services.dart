import 'package:cloud_firestore/cloud_firestore.dart';

class LangServices {
  LangServices();
  final langStore = FirebaseFirestore.instance.collection('languages');

  Future<void> addLanguage(String name, int likes) async {
    final langDoc = await langStore.doc();
    String id = langDoc.id;
    langDoc
        .set({'name': name, 'likes': likes, "id": id})
        .then((value) => print("Language Added"))
        .catchError((error) => print("Failed to add Language: $error"));
  }

  Future<Stream<QuerySnapshot<Object?>>> getLanguages() async {
    final langCollection =
        await langStore.orderBy('likes', descending: true).snapshots();
    return langCollection;
  }

  Future<void> updateLanguage(String name, int likes) async {
    String id = await getID(name);
    await langStore.doc(id).update({"likes": likes});
  }

  Future<void> deleteLanguage(String name) async {
    String id = await getID(name);
    final lang = await langStore.doc(id).delete();
  }

  Future<String> getID(String name) async {
    String id = '';
    final lang =
        await langStore.where('name', arrayContainsAny: [name]).limit(1).get();
        lang.docs.map((e) => id = e.id);

    return id;
  }

  Future<QuerySnapshot> getLang(String name) async {
    final lang =
        await langStore.where('name', arrayContainsAny: [name]).limit(1).get();

    return lang;
  }
}
