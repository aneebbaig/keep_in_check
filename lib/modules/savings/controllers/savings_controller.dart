import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keep_in_check/modules/savings/models/savings_model.dart';

import '../../../models/firebase_exception.dart';
import '../../../services/snackbar_service.dart';

class SavingsController {
  Future<void> addSaving(SavingsModel model) async {
    try {
      final CollectionReference savingRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userSavings');

      await savingRef.add(model.toFirestoreObject());
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'add_saving_error',
      );
    }
  }

  Future<void> deleteSaving(String id) async {
    try {
      final CollectionReference savingRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userSavings');

      await savingRef.doc(id).delete();
      SnackbarService.showSnackbar("Deleted");
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'delete_saving_error',
      );
    }
  }

  Future<void> updateSaving({
    required String monthAndYear,
    required int amountUSD,
    required int amountPKR,
  }) async {
    try {
      final CollectionReference savingRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userSavings');
      await savingRef.doc(monthAndYear).set({
        'updatedAt': DateTime.now(),
        'monthName': monthAndYear,
        'amountUSD': amountUSD,
        'amountPKR': amountPKR,
      }, SetOptions(merge: true));
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'update_saving_error',
      );
    }
  }

  Future<List<SavingsModel>> getAllSavings({DateTime? dateTime}) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot<Map<String, dynamic>> snapshot;

      final date = dateTime ?? DateTime.now();

      snapshot = await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userSavings')
          .where('dateTime', isGreaterThanOrEqualTo: DateTime(date.year, 1, 1))
          .where('dateTime', isLessThan: DateTime(date.year, 12, 1))
          .get();

      final model = List<SavingsModel>.from(
        snapshot.docs.map(
          (e) => SavingsModel.fromFirestore(
            e.data(),
            e.id,
          ),
        ),
      );
      return model;
    } catch (e) {
      rethrow;
    }
  }
}
