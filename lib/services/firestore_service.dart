import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focusnotes/models/note_model.dart';
import 'package:focusnotes/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestoreService = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String _userCollectionName = "user";
  final String _noteCollectionName = "note";

  Future<Either<String, void>> storeUserData(UserModel userModel) async {
    try {
      // String id = _firebaseAuth.currentUser!.uid;
      await _firestoreService
          .collection(_userCollectionName)
          .doc(userModel.id)
          .set(userModel.toJson());
      return Right(null);
    } on FirebaseException catch (exception) {
      return Left(exception.message!);
    }
  }

  Future<Either<String, UserModel>> getUserData() async {
    try {
      String id = _firebaseAuth.currentUser!.uid;
      final response = await _firestoreService
          .collection(_userCollectionName)
          .doc(id)
          .get();
      final UserModel userModel = UserModel.fromJson(response.data()!);
      return Right(userModel);
    } on FirebaseException catch (exception) {
      return Left(exception.message!);
    }
  }

  Future<Either<String, void>> add(NoteModel noteModel) async {
    try {
      String id = _firebaseAuth.currentUser!.uid;
      await _firestoreService
          .collection(_userCollectionName)
          .doc(id)
          .collection(_noteCollectionName)
          .doc(noteModel.id)
          .set(noteModel.toJson());

      return Right(null);
    } on FirebaseException catch (exception) {
      return Left(exception.message!);
    }
  }

  Future<Either<String, void>> remove(String noteId) async {
    try {
      String id = _firebaseAuth.currentUser!.uid;
      await _firestoreService
          .collection(_userCollectionName)
          .doc(id)
          .collection(_noteCollectionName)
          .doc(noteId)
          .delete();
      return Right(null);
    } on FirebaseException catch (exception) {
      return Left(exception.message!);
    }
  }

  Future<Either<String, void>> update(NoteModel noteModel) async {
    try {
      String id = _firebaseAuth.currentUser!.uid;
      await _firestoreService
          .collection(_userCollectionName)
          .doc(id)
          .collection(_noteCollectionName)
          .doc(noteModel.id)
          .update(noteModel.toJson());
      return Right(null);
    } on FirebaseException catch (exception) {
      return Left(exception.message!);
    }
  }

  Future<Either<String, List<NoteModel?>>> getNotes() async {
    try {
      String id = _firebaseAuth.currentUser!.uid;
      final snapshot = await _firestoreService
          .collection(_userCollectionName)
          .doc(id)
          .collection(_noteCollectionName)
          .get();

      List<NoteModel> list = snapshot.docs
          .map((doc) => NoteModel.fromJson(doc.data()))
          .toList();
      return Right(list);
    } on FirebaseException catch (exception) {
      return Left(exception.message!);
    }
  }
}
