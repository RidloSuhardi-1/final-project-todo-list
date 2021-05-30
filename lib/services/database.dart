import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference noteCollections = firestore.collection('notes');

class Database {
  static Future<void> addNote(
      {String title = 'no title', String desc = 'no description'}) async {
    Map<String, dynamic> data = <String, dynamic>{
      'title': title,
      'description': desc,
    };

    noteCollections.add(data);
  }

  static Stream<QuerySnapshot> readNotes() {
    CollectionReference notesItemCollection = firestore.collection('notes');

    return notesItemCollection.orderBy('title', descending: true).snapshots();
  }
}
