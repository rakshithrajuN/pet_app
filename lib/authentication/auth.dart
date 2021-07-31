import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseAuth {
  Future<String?> currentUseremail();
  Future<String?> currentUser();
  Future<String?> getname();
  Future<void> signOut();
  Future<String?> getPhone();
  Future<String?> signIn(String email, String password);
  Future<String?> createUser(
      String name, String phone, String email, String password);
  Future<bool> verifEmail();
  Future<void> resetPassword(String email);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference username =
      FirebaseFirestore.instance.collection('user');

  //signIn method
  Future<String?> signIn(String email, String password) async {
    final User? user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password))
        .user;
    return user!.uid;
  }

  Future<bool> verifEmail() async {
    User? user = await _firebaseAuth.currentUser;
    bool? d;
    await user!.sendEmailVerification().then((value) => d = true);
    return d!;
  }

//Register user details
  Future<String?> createUser(
      String name, String phone, String email, String password) async {
    final UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    await username.doc(user!.uid).set({
      'username': name,
      'phone': phone,
    });

    return user.uid;
  }

  @override
  //get current user id
  Future<String?> currentUser() async {
    User? user = await _firebaseAuth.currentUser;
    print(user);
    return user != null ? user.uid : null;
  }

  Future<String?> getPhone() async {
    User? user = await _firebaseAuth.currentUser;
    print(user);
    String? phone = '';
    await username.doc(user!.uid).get().then((value) {
      phone = value.get('phone');
      print(phone);
    });
    if (phone != '') {
      return phone;
    }
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<String?> getname() async {
    User? user = await _firebaseAuth.currentUser;
    print(user);
    String? fid = '';
    await username.doc(user!.uid).get().then((value) {
      fid = value.get('username');
      print(fid);
    });
    if (fid != '') {
      return fid;
    }
  }

//get current user mail address
  Future<String?> currentUseremail() async {
    User? user = await _firebaseAuth.currentUser;
    return user != null ? user.email : null;
  }

//sinout method
  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
