import 'package:cullinarium/features/authentication/data/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthService(this._auth);

  // Get current authenticated user
  User? get currentUser => _auth.currentUser;

  // Sign up with email and password
  Future<AuthModel> signUp({
    required String email,
    required String password,
    required String name,
    required String type,
  }) async {
    try {
      // Create user with email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('User created: ${result.user?.uid}');

      User? user = result.user;

      if (user == null) {
        throw Exception('Failed to create user');
      }

      // Create AuthModel instance
      AuthModel authModel = AuthModel(
        id: user.uid,
        name: name,
        email: email,
        type: type,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'type': type,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return authModel;
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with email and password
  Future<AuthModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in user with email and password
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user == null) {
        throw Exception('Failed to sign in');
      }

      // Get user data from Firestore
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        throw Exception('User data not found');
      }

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Create and return AuthModel
      return AuthModel(
        id: user.uid,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        type: data['type'] ?? '',
      );
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
  Future<AuthModel?> getCurrentUserData() async {
    User? user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        return null;
      }

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return AuthModel(
        id: user.uid,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        type: data['type'] ?? '',
      );
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Update user profile
  Future<void> updateProfile({
    String? name,
    String? type,
  }) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    try {
      Map<String, dynamic> updateData = {};

      if (name != null) updateData['name'] = name;
      if (type != null) updateData['type'] = type;

      if (updateData.isNotEmpty) {
        await _firestore.collection('users').doc(user.uid).update(updateData);
      }
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
