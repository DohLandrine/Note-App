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

  void editNote(String title, String description, String id) async{
    Map<String, dynamic> data = {
      'title': title,
      'description': description,
    };
    await db.collection(users).doc(id).set(data, SetOptions(merge: true));
  }

  void deleteNotes({required String id}) async{
    await db.collection(users).doc(id).delete();
  }

  Stream<QuerySnapshot> get notes{
    return db.collection(users).snapshots();
  }
}
