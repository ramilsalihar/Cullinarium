import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cullinarium/core/utils/constants/app_consts.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User data
  Future<dynamic> updateUserData({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore
        .collection(AppConsts.usersCollection)
        .doc(userId)
        .update(data);
  }

  // Update Chef data
  Future<void> updateChefData(String uid, Map<String, dynamic> data) async {
    await _firestore
        .collection(AppConsts.chefsCollection)
        .doc(uid)
        .update(data);
  }

  /// Update author data
  Future<void> updateAuthorData(String uid, Map<String, dynamic> data) async {
    await _firestore
        .collection(AppConsts.authorsCollection)
        .doc(uid)
        .update(data);
  }
}
