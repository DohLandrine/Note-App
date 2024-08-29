import 'package:cloud_firestore/cloud_firestore.dart';

class CloudDatabaseService {
  static CloudDatabaseService instance = CloudDatabaseService();
  late FirebaseFirestore db;
  String users = 'NoteApp notes';

  CloudDatabaseService() {
    db = FirebaseFirestore.instance;
  }

  void addNotes(String title, String description) async {
    Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'time': DateTime.now()
    };
    await db.collection(users).add(data).then(
          (DocumentReference ref) => db.collection(users).doc(ref.id).set(
            {'id': ref.id},
            SetOptions(merge: true),
          ),
        );
  }

  Stream<QuerySnapshot> get notes {
    return db.collection(users).snapshots();
  }
}
