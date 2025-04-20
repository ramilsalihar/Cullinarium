import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cullinarium/core/utils/constants/app_consts.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  // Update user profile image
  // Upload profile image to Firebase Storage
  Future<String> uploadProfileImage({
    required File imageFile,
    required String userId,
    required String userType,
  }) async {
    final path = 'profile_images/$userType/$userId.jpg';
    final ref = _storage.ref().child(path);

    await ref.putFile(imageFile);

    final image = await ref.getDownloadURL();
    updateProfileImageUrl(userId: userId, imageUrl: image, userType: userType);

    return image;
  }

  // Add uploaded image URL to Firestore
  Future<void> updateProfileImageUrl({
    required String userId,
    required String imageUrl,
    required String userType,
  }) async {
    String collectionPath;

    switch (userType) {
      case 'chef':
        collectionPath = AppConsts.chefsCollection;
        break;
      case 'author':
        collectionPath = AppConsts.authorsCollection;
        break;
      case 'user':
        collectionPath = AppConsts.usersCollection;
        break;
      default:
        throw Exception('Invalid user type');
    }

    await _firestore.collection(collectionPath).doc(userId).update({
      'avatar': imageUrl,
    });
  }
}
