import 'package:dolphin/shared/app_imports/app_imports.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// LOGIN FUNCTION
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// SIGN UP FUNCTION + SAVE USER DATA
  Future<User?> signUp({
    required String name,
    required String email,
    required String password,
    double totalCoin = 0.0,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'totalCoin': totalCoin,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// FORGET PASSWORD FUNCTION
  Future<void> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// CHECK USER LOGGED IN OR NOT
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// LOGOUT FUNCTION
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// SAVE / UPDATE USER INFO SEPARATELY (optional)
  Future<void> saveUserInfo({
    required String uid,
    required String name,
    required String email,
    required int totalCoin,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'ui': uid,
      'name': name,
      'email': email,
      'totalCoin': totalCoin,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
