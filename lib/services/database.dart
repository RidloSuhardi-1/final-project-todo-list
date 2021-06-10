import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference noteCollections = firestore.collection('notes');
final CollectionReference labelCollections = firestore.collection('label');

class Database {
  // Insert data

  // proses data yang diinput dari user, dan simpan ke dalam collection 'note'
  static Future<void> addNote(
      {String title = 'no title', String desc = 'no description'}) async {
    // merubah data menjadi object
    Map<String, dynamic> data = <String, dynamic>{
      'title': title,
      'description': desc,
    };

    await noteCollections.add(data);
  }

  static Future<void> addLabel({String name = 'no title'}) async {
    Map<String, dynamic> data = <String, dynamic>{
      'name': name,
    };

    await labelCollections.add(data);
  }

  // Retrieve data
  // Mendapatkan kumpulan data dari collection dengan tipe kembalian stream,
  // yang maksudnya adalah data tersebut akan ditampilkan secara dinamis.

  static Stream<QuerySnapshot> readLabels() {
    return labelCollections.orderBy('name', descending: true).snapshots();
  }

  static Stream<QuerySnapshot> readNotes() {
    return noteCollections.orderBy('title', descending: true).snapshots();
  }
}
