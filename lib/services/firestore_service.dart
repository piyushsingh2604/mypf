import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/project_model.dart';

class FirestoreService {
  static final _db = FirebaseFirestore.instance;

  static Future<List<ProjectModel>> fetchProjects() async {
    final snapshot = await _db.collection('project_data').get();
    return snapshot.docs
        .map((doc) => ProjectModel.fromJson(doc.data()))
        .toList();
  }

  static Future<void> submitContact({
    required String name,
    required String email,
    required String message,
    String? phone,
  }) async {
    await _db.collection('clints_info').add({
      'name': name,
      'email': email,
      'about': message,
      if (phone != null) 'number': phone,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}