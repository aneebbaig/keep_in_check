import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keep_in_check/modules/loans/models/loan_model.dart';

import '../../../models/firebase_exception.dart';

class LoanController {
  Future<void> addLoan(LoanModel loan) async {
    try {
      final loans = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userLoans');

      // Add the TransactionModel object to the transactions collection
      await loans.add(loan.toFirestoreObject());
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'add_loan_error',
      );
    }
  }

  Future<void> markAsPaidUnpaid(String id, bool isPaid) async {
    try {
      final loan = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userLoans')
          .doc(id);

      await loan.update(
        {'isPaid': isPaid ? false : true},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LoanModel>> getAllLoans() async {
    List<LoanModel> loans = [];
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userLoans')
          .get();
      loans = snapshot.docs.map(
        (doc) {
          return LoanModel.fromFirestore(doc);
        },
      ).toList();

      return loans;
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'get_loan_error',
      );
    }
  }

  Future<List<LoanModel>> getPaidLoans() async {
    List<LoanModel> loans = [];
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userLoans')
          .where(
            "isPaid",
            isEqualTo: true,
          )
          .get();
      loans = snapshot.docs.map(
        (doc) {
          return LoanModel.fromFirestore(doc);
        },
      ).toList();

      return loans;
    } catch (e) {
      throw CustomFirebaseException(
        message: e.toString(),
        code: 'get_paid_loan_error',
      );
    }
  }
}
