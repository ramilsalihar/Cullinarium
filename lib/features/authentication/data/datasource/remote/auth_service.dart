import 'package:cullinarium/core/utils/constants/app_consts.dart';
import 'package:cullinarium/features/authentication/data/mappers/auth_mapper.dart';
import 'package:cullinarium/features/authentication/data/models/auth_model.dart';
import 'package:cullinarium/features/profile/data/mappers/author_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/chef_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/user_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthService(this._auth, this._firestore);

  // Get current authenticated user
  User? get currentUser => _auth.currentUser;

  // Stream to listen to auth state changes
  Stream<User?> get authChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<dynamic> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user == null) {
        throw Exception('Failed to create user');
      }

      // Create AuthModel instance
      AuthModel authModel = AuthModel(
        id: user.uid,
        name: name,
        email: email,
        role: role,
        createdAt: DateTime.now().toIso8601String(),
      );

      String dataType = '';
      dynamic data;
      dynamic userData;
      // Map role to Firestore collection

      switch (role) {
        case 'chef':
          dataType = AppConsts.chefsCollection;
          data = AuthMapper.toChef(authModel);
          userData = AuthMapper.fromJsonToChef(authModel);
          break;
        case 'author':
          dataType = AppConsts.authorsCollection;
          data = AuthMapper.toAuthor(authModel);
          userData = AuthMapper.fromJsonToAuthor(authModel);
          break;
        case 'user':
          dataType = AppConsts.usersCollection;
          data = AuthMapper.toUser(authModel);
          userData = AuthMapper.fromJsonToUser(authModel);
          break;
        default:
          dataType = AppConsts.usersCollection;
          data = AuthMapper.toJson(authModel);
          userData = AuthMapper.fromJsonToUser(authModel);
          break;
      }
      // Save user data to Firestore
      await _firestore.collection(dataType).doc(user.uid).set(data);

      return userData;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with email and password
  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user == null) {
        throw Exception('Failed to sign in');
      }

      dynamic userData;

      final possibleCollections = [
        AppConsts.chefsCollection,
        AppConsts.authorsCollection,
        AppConsts.usersCollection,
      ];

      DocumentSnapshot? userDoc;

      for (final collection in possibleCollections) {
        final doc = await _firestore.collection(collection).doc(user.uid).get();
        if (doc.exists) {
          userDoc = doc;
          break;
        }
      }

      if (userDoc == null || !userDoc.exists) {
        throw Exception('User data not found in any collection');
      }

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        switch (data['role']) {
          case 'chef':
            userData = ChefMapper.fromJson(data);
            break;
          case 'author':
            userData = AuthorMapper.fromJson(data);
            break;
          case 'user':
            userData = UserMapper.fromJson(data);
            break;
          default:
            userData = AuthMapper.fromJson(data);
        }
      }

      print('User data: $userData');

      return userData;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        throw Exception('No user is currently signed in');
      }

      // Delete user data from Firestore first
      await _firestore.collection('users').doc(user.uid).delete();

      // Then delete the user account
      await user.delete();
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Reset password
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Get current user data
  Future<dynamic> getCurrentUserData() async {
    User? user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    try {
      dynamic userData;

      final possibleCollections = [
        AppConsts.chefsCollection,
        AppConsts.authorsCollection,
        AppConsts.usersCollection,
      ];

      DocumentSnapshot? userDoc;

      for (final collection in possibleCollections) {
        final doc = await _firestore.collection(collection).doc(user.uid).get();
        if (doc.exists) {
          userDoc = doc;
          break;
        }
      }

      if (userDoc == null || !userDoc.exists) {
        return null;
      }

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        switch (data['role']) {
          case 'chef':
            userData = ChefMapper.fromJson(data);
            break;
          case 'author':
            userData = AuthorMapper.fromJson(data);
            break;
          case 'user':
            userData = UserMapper.fromJson(data);
            break;
          default:
            userData = AuthMapper.fromJson(data);
        }
      }

      return userData;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Change password
  Future<void> changePassword({required String newPassword}) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    try {
      await user.updatePassword(newPassword);
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Update email
  Future<void> updateEmail({required String newEmail}) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    try {
      await user.updateEmail(newEmail);

      // Update email in Firestore as well
      await _firestore.collection('users').doc(user.uid).update({
        'email': newEmail,
      });
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Helper method to handle Firebase Auth exceptions
  Exception _handleAuthException(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return Exception('No user found with this email');
        case 'wrong-password':
          return Exception('Incorrect password');
        case 'email-already-in-use':
          return Exception('Email is already in use');
        case 'weak-password':
          return Exception('Password is too weak');
        case 'invalid-email':
          return Exception('Invalid email address');
        case 'requires-recent-login':
          return Exception('This operation requires re-authentication');
        default:
          return Exception('Authentication error: ${e.message}');
      }
    }
    return Exception('An unknown error occurred: $e');
  }
}
